package com.hnu.highlynewapp.utils;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

@Component
public class TextEmbeddingUtils {
    @Value("${embedding.service.url}")
    private String serviceUrl;

    private static final String TEXT_EMBED_ENDPOINT = "/embed";
    private static final String BATCH_EMBED_ENDPOINT = "/embed_batch";
    private static final String RERANK_ENDPOINT = "/rerank";
    private static final String SEARCH_RERANK_ENDPOINT = "/search_and_rerank";

    /**
     * 生成单个文本的向量
     */
    public double[] getTextEmbedding(String text) {
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        RestTemplate restTemplate = new RestTemplate();
        Map<Object, Object> map = new HashMap<>();
        map.put("text", text);
        HttpEntity<Map<Object, Object>> httpEntity = new HttpEntity<>(map, httpHeaders);

        // 调用Python服务返回向量
        String response = restTemplate.postForObject(serviceUrl + TEXT_EMBED_ENDPOINT, httpEntity, String.class);
        JSONObject jsonResponse = new JSONObject(response);
        return jsonResponse.getJSONArray("embedding").toList()
                .stream().mapToDouble(val -> Double.parseDouble(val.toString())).toArray();
    }

    /**
     * 批量生成文本向量
     */
    public List<double[]> getBatchTextEmbeddings(List<String> texts) {
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        RestTemplate restTemplate = new RestTemplate();
        Map<String, Object> map = new HashMap<>();
        map.put("texts", texts);
        HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(map, httpHeaders);

        String response = restTemplate.postForObject(serviceUrl + BATCH_EMBED_ENDPOINT, httpEntity, String.class);
        JSONObject jsonResponse = new JSONObject(response);
        JSONArray embeddingsArray = jsonResponse.getJSONArray("embeddings");

        List<double[]> embeddings = new ArrayList<>();
        for (int i = 0; i < embeddingsArray.length(); i++) {
            JSONArray embedding = embeddingsArray.getJSONArray(i);
            double[] vector = new double[embedding.length()];
            for (int j = 0; j < embedding.length(); j++) {
                vector[j] = embedding.getDouble(j);
            }
            embeddings.add(vector);
        }
        return embeddings;
    }

    /**
     * 生成组合文本向量（直接传入已构建的文本）
     */
    public double[] getCombinedEmbedding(String combinedText) {
        return getTextEmbedding(combinedText);
    }

    // ==================== 通用实体操作方法 ====================

    /**
     * 通用保存组合向量方法
     *
     * @param <T>             实体类型
     * @param entityId        实体ID
     * @param combinedText    已构建的组合文本
     * @param mapper          数据访问层
     * @param queryBuilder    查询构建器（根据ID查询）
     * @param embeddingSetter 向量设置器
     * @return 更新记录数
     */
    public <T> int saveCombinedEmbedding(Long entityId,
                                         String combinedText,
                                         BaseMapper<T> mapper,
                                         Function<Long, QueryWrapper<T>> queryBuilder,
                                         java.util.function.BiConsumer<T, double[]> embeddingSetter) {
        // 生成组合向量
        double[] combinedEmbedding = getCombinedEmbedding(combinedText);

        // 查询实体
        QueryWrapper<T> queryWrapper = queryBuilder.apply(entityId);
        T entity = mapper.selectOne(queryWrapper);
        if (entity == null) {
            return 0;
        }

        // 设置向量并更新
        embeddingSetter.accept(entity, combinedEmbedding);
        return mapper.updateById(entity);
    }

    /**
     * 通用批量保存组合向量方法
     *
     * @param <T>             实体类型
     * @param mapper          数据访问层
     * @param embeddingField  向量字段名
     * @param field1Name      第一个字段名
     * @param field2Name      第二个字段名
     * @param field3Name      第三个字段名
     * @param textBuilder     文本构建器
     * @param embeddingSetter 向量设置器
     * @return 更新记录数
     */
    public <T> int batchSaveCombinedEmbeddings(BaseMapper<T> mapper,
                                               String embeddingField,
                                               String field1Name, String field2Name, String field3Name,
                                               Function<T, String> textBuilder,
                                               java.util.function.BiConsumer<T, double[]> embeddingSetter) {
        // 获取所有没有组合向量的记录
        QueryWrapper<T> wrapper = new QueryWrapper<>();
        wrapper.isNull(embeddingField)
                .isNotNull(field1Name)
                .isNotNull(field2Name)
                .isNotNull(field3Name);
        List<T> needsToUpdate = mapper.selectList(wrapper);

        if (needsToUpdate.isEmpty()) {
            return 0;
        }

        int updateCount = 0;
        // 批量处理，每次处理50条
        int batchSize = 50;
        for (int i = 0; i < needsToUpdate.size(); i += batchSize) {
            int endIndex = Math.min(i + batchSize, needsToUpdate.size());
            List<T> batch = needsToUpdate.subList(i, endIndex);

            // 准备批量文本
            List<String> combinedTexts = batch.stream()
                    .map(textBuilder)
                    .collect(java.util.stream.Collectors.toList());

            // 批量生成向量
            List<double[]> embeddings = getBatchTextEmbeddings(combinedTexts);

            // 更新数据库
            for (int j = 0; j < batch.size(); j++) {
                T entity = batch.get(j);
                embeddingSetter.accept(entity, embeddings.get(j));
                if (mapper.updateById(entity) > 0) {
                    updateCount++;
                }
            }
        }

        return updateCount;
    }

    /**
     * 通用搜索方法（使用Qwen3模型：embedding + reranker）
     *
     * @param <T>             实体类型
     * @param prompt          搜索内容
     * @param mapper          数据访问层
     * @param embeddingField  向量字段名
     * @param textBuilder     文本构建器
     * @param embeddingGetter 向量获取器
     * @param scoresSetter    分数设置器
     * @return 搜索结果列表
     */
    public <T> List<T> searchByQwen3(String prompt,
                                     BaseMapper<T> mapper,
                                     String embeddingField,
                                     Function<T, String> textBuilder,
                                     Function<T, double[]> embeddingGetter,
                                     java.util.function.BiConsumer<T, Double> scoresSetter) {
        // 1. 获取所有有组合向量的记录
        QueryWrapper<T> wrapper = new QueryWrapper<>();
        wrapper.isNotNull(embeddingField)
                .eq("status", 2); // 只搜索审核通过的
        List<T> allEntities = mapper.selectList(wrapper);

        if (allEntities.isEmpty()) {
            return new ArrayList<>();
        }

        // 2. 准备候选文本和向量
        List<String> candidateTexts = allEntities.stream()
                .map(textBuilder)
                .collect(java.util.stream.Collectors.toList());

        List<double[]> candidateEmbeddings = allEntities.stream()
                .map(embeddingGetter)
                .collect(java.util.stream.Collectors.toList());

        // 3. 使用一体化搜索：embedding + reranker
        try {
            // 动态调整参数，根据数据集大小
            int totalCandidates = allEntities.size();
            int topKInitial = Math.min(totalCandidates, Math.max(20, totalCandidates / 10));
            int topKFinal = Math.min(topKInitial, 20);

            System.out.printf("搜索参数：总数=%d, 初筛=%d, 最终=%d%n",
                    totalCandidates, topKInitial, topKFinal);

            SearchAndRerankResult searchResult = searchAndRerank(
                    prompt,
                    candidateTexts,
                    candidateEmbeddings,
                    topKInitial, // 动态初步检索数量
                    topKFinal    // 动态最终返回数量
            );

            // 4. 构建结果
            List<T> results = new ArrayList<>();
            for (SearchResult result : searchResult.getResults()) {
                if (result.getFinalScore() > 0.3) { // 设置阈值
                    T entity = allEntities.get(result.getIndex());
                    scoresSetter.accept(entity, result.getFinalScore());
                    results.add(entity);
                }
            }

            return results;
        } catch (Exception e) {
            // 如果Reranker服务不可用，降级到纯向量搜索
            System.err.println("Qwen3搜索服务异常，降级到向量搜索: " + e.getMessage());
            return fallbackVectorSearch(prompt, allEntities, candidateEmbeddings, scoresSetter);
        }
    }

    /**
     * 通用降级搜索方法：纯向量相似度搜索
     */
    private <T> List<T> fallbackVectorSearch(String prompt,
                                             List<T> allEntities,
                                             List<double[]> candidateEmbeddings,
                                             java.util.function.BiConsumer<T, Double> scoresSetter) {
        try {
            // 生成查询向量
            double[] promptEmbedding = getTextEmbedding(prompt);

            // 批量计算相似度
            List<Double> similarities = batchCalculateCosineSimilarity(
                    promptEmbedding, candidateEmbeddings);

            // 构建结果
            List<T> results = new ArrayList<>();
            for (int i = 0; i < allEntities.size(); i++) {
                double similarity = similarities.get(i);
                if (similarity > 0.5) { // 设置阈值
                    T entity = allEntities.get(i);
                    scoresSetter.accept(entity, similarity);
                    results.add(entity);
                }
            }

            // 按相似度排序
            results.sort((e1, e2) -> {
                // 这里需要通过反射或其他方式获取分数，暂时使用简单方式
                return Double.compare(
                        similarities.get(allEntities.indexOf(e2)),
                        similarities.get(allEntities.indexOf(e1))
                );
            });

            return results.stream().limit(20).collect(java.util.stream.Collectors.toList());
        } catch (Exception e) {
            System.err.println("降级搜索也失败: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * 使用Reranker重排序搜索结果
     */
    public List<RerankResult> rerank(String query, List<String> candidates) {
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        RestTemplate restTemplate = new RestTemplate();

        Map<String, Object> map = new HashMap<>();
        map.put("query", query);
        map.put("candidates", candidates);
        HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(map, httpHeaders);

        String response = restTemplate.postForObject(serviceUrl + RERANK_ENDPOINT, httpEntity, String.class);
        JSONObject jsonResponse = new JSONObject(response);

        JSONArray indices = jsonResponse.getJSONArray("reranked_indices");
        JSONArray scores = jsonResponse.getJSONArray("scores");

        List<RerankResult> results = new ArrayList<>();
        for (int i = 0; i < indices.length(); i++) {
            results.add(new RerankResult(indices.getInt(i), scores.getDouble(i)));
        }

        return results;
    }

    /**
     * 一体化搜索：embedding + reranker
     */
    public SearchAndRerankResult searchAndRerank(String query, List<String> candidates,
                                                 List<double[]> candidateEmbeddings,
                                                 int topKInitial, int topKFinal) {
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        RestTemplate restTemplate = new RestTemplate();

        Map<String, Object> map = new HashMap<>();
        map.put("query", query);
        map.put("candidates", candidates);
        if (candidateEmbeddings != null && !candidateEmbeddings.isEmpty()) {
            // 转换double[]数组为List<List<Double>>格式，便于JSON序列化
            List<List<Double>> embeddingsList = new ArrayList<>();
            for (double[] embedding : candidateEmbeddings) {
                List<Double> embeddingList = new ArrayList<>();
                for (double value : embedding) {
                    embeddingList.add(value);
                }
                embeddingsList.add(embeddingList);
            }
            map.put("candidate_embeddings", embeddingsList);
        }
        map.put("top_k_initial", topKInitial);
        map.put("top_k_final", topKFinal);

        HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(map, httpHeaders);

        String response = restTemplate.postForObject(serviceUrl + SEARCH_RERANK_ENDPOINT, httpEntity, String.class);
        JSONObject jsonResponse = new JSONObject(response);

        JSONArray resultsArray = jsonResponse.getJSONArray("results");
        List<SearchResult> results = new ArrayList<>();
        for (int i = 0; i < resultsArray.length(); i++) {
            JSONObject result = resultsArray.getJSONObject(i);
            results.add(new SearchResult(
                    result.getInt("index"),
                    result.getDouble("embedding_score"),
                    result.getDouble("rerank_score"),
                    result.getDouble("final_score")
            ));
        }

        return new SearchAndRerankResult(
                results,
                jsonResponse.getInt("total_candidates"),
                jsonResponse.getInt("initial_retrieved"),
                jsonResponse.getInt("final_returned")
        );
    }

    /**
     * 批量计算余弦相似度 - 优化版本
     * 使用向量化计算提高效率
     */
    public List<Double> batchCalculateCosineSimilarity(double[] queryVector, List<double[]> targetVectors) {
        List<Double> similarities = new ArrayList<>();

        // 预计算查询向量的模长
        double queryNorm = calculateVectorNorm(queryVector);

        for (double[] targetVector : targetVectors) {
            if (targetVector == null || targetVector.length != queryVector.length) {
                similarities.add(0.0);
                continue;
            }

            double dotProduct = 0.0;
            double targetNorm = 0.0;

            // 单次循环计算点积和目标向量模长
            for (int i = 0; i < queryVector.length; i++) {
                dotProduct += queryVector[i] * targetVector[i];
                targetNorm += targetVector[i] * targetVector[i];
            }

            targetNorm = Math.sqrt(targetNorm);

            if (queryNorm == 0 || targetNorm == 0) {
                similarities.add(0.0);
            } else {
                similarities.add(dotProduct / (queryNorm * targetNorm));
            }
        }

        return similarities;
    }

    /**
     * 计算向量模长
     */
    private double calculateVectorNorm(double[] vector) {
        double norm = 0.0;
        for (double v : vector) {
            norm += v * v;
        }
        return Math.sqrt(norm);
    }

    /**
     * Rerank结果类
     */
    public static class RerankResult {
        private int index;
        private double score;

        public RerankResult(int index, double score) {
            this.index = index;
            this.score = score;
        }

        public int getIndex() {
            return index;
        }

        public double getScore() {
            return score;
        }
    }

    /**
     * 搜索结果类
     */
    public static class SearchResult {
        private int index;
        private double embeddingScore;
        private double rerankScore;
        private double finalScore;

        public SearchResult(int index, double embeddingScore, double rerankScore, double finalScore) {
            this.index = index;
            this.embeddingScore = embeddingScore;
            this.rerankScore = rerankScore;
            this.finalScore = finalScore;
        }

        public int getIndex() {
            return index;
        }

        public double getEmbeddingScore() {
            return embeddingScore;
        }

        public double getRerankScore() {
            return rerankScore;
        }

        public double getFinalScore() {
            return finalScore;
        }
    }

    /**
     * 搜索和重排序结果类
     */
    public static class SearchAndRerankResult {
        private List<SearchResult> results;
        private int totalCandidates;
        private int initialRetrieved;
        private int finalReturned;

        public SearchAndRerankResult(List<SearchResult> results, int totalCandidates,
                                     int initialRetrieved, int finalReturned) {
            this.results = results;
            this.totalCandidates = totalCandidates;
            this.initialRetrieved = initialRetrieved;
            this.finalReturned = finalReturned;
        }

        public List<SearchResult> getResults() {
            return results;
        }

        public int getTotalCandidates() {
            return totalCandidates;
        }

        public int getInitialRetrieved() {
            return initialRetrieved;
        }

        public int getFinalReturned() {
            return finalReturned;
        }
    }
}
