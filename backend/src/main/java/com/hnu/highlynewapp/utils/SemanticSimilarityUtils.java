package com.hnu.highlynewapp.utils;

import org.springframework.stereotype.Component;

import java.util.*;

/**
 * 语义相似性工具类
 * 用于计算标签之间的语义相似度
 */
@Component
public class SemanticSimilarityUtils {
    // 职位相似性映射
    private static final Map<String, List<String>> POSITION_SIMILARITY_MAP = new HashMap<>();

    // 技能相似性映射
    private static final Map<String, List<String>> SKILL_SIMILARITY_MAP = new HashMap<>();

    // 地点相似性映射
    private static final Map<String, List<String>> LOCATION_SIMILARITY_MAP = new HashMap<>();

    static {
        // 初始化职位相似性映射
        POSITION_SIMILARITY_MAP.put("Java开发", Arrays.asList("Java后端开发", "Java工程师", "后端开发", "Java开发工程师"));
        POSITION_SIMILARITY_MAP.put("前端开发", Arrays.asList("前端工程师", "Web前端", "Vue开发", "React开发", "前端开发工程师"));
        POSITION_SIMILARITY_MAP.put("Python开发", Arrays.asList("Python工程师", "Python后端", "数据分析师", "算法工程师"));
        POSITION_SIMILARITY_MAP.put("Android开发", Arrays.asList("Android工程师", "移动端开发", "APP开发"));
        POSITION_SIMILARITY_MAP.put("运维工程师", Arrays.asList("DevOps工程师", "系统运维", "运维开发"));
        POSITION_SIMILARITY_MAP.put("测试工程师", Arrays.asList("测试开发", "QA工程师", "自动化测试"));

        // 初始化技能相似性映射
        SKILL_SIMILARITY_MAP.put("Java", Arrays.asList("Spring", "SpringBoot", "MyBatis", "Maven", "Gradle"));
        SKILL_SIMILARITY_MAP.put("前端", Arrays.asList("HTML", "CSS", "JavaScript", "Vue", "React", "TypeScript"));
        SKILL_SIMILARITY_MAP.put("Python", Arrays.asList("Django", "Flask", "Pandas", "NumPy", "Scikit-learn"));
        SKILL_SIMILARITY_MAP.put("数据库", Arrays.asList("MySQL", "PostgreSQL", "Redis", "MongoDB"));
        SKILL_SIMILARITY_MAP.put("云服务", Arrays.asList("AWS", "阿里云", "腾讯云", "Docker", "Kubernetes"));

        // 初始化地点相似性映射
        LOCATION_SIMILARITY_MAP.put("北京", Arrays.asList("北京市", "海淀区", "朝阳区", "西城区"));
        LOCATION_SIMILARITY_MAP.put("上海", Arrays.asList("上海市", "浦东新区", "黄浦区", "徐汇区"));
        LOCATION_SIMILARITY_MAP.put("深圳", Arrays.asList("深圳市", "南山区", "福田区", "罗湖区"));
        LOCATION_SIMILARITY_MAP.put("杭州", Arrays.asList("杭州市", "西湖区", "滨江区", "余杭区"));
        LOCATION_SIMILARITY_MAP.put("广州", Arrays.asList("广州市", "天河区", "越秀区", "海珠区"));
    }

    /**
     * 计算职位相似度
     *
     * @param tag1 标签1
     * @param tag2 标签2
     * @return 相似度分数 (0-1)
     */
    public double calculatePositionSimilarity(String tag1, String tag2) {
        if (tag1 == null || tag2 == null) return 0.0;

        // 完全匹配
        if (tag1.equals(tag2)) return 1.0;

        // 包含关系
        if (tag1.contains(tag2) || tag2.contains(tag1)) return 0.8;

        // 相似性映射匹配
        for (Map.Entry<String, List<String>> entry : POSITION_SIMILARITY_MAP.entrySet()) {
            String key = entry.getKey();
            List<String> similarTags = entry.getValue();

            if ((tag1.equals(key) || similarTags.contains(tag1)) &&
                    (tag2.equals(key) || similarTags.contains(tag2))) {
                return 0.7;
            }
        }

        // 关键词匹配
        String[] keywords1 = tag1.split("开发|工程师|开发工程师");
        String[] keywords2 = tag2.split("开发|工程师|开发工程师");

        for (String keyword1 : keywords1) {
            for (String keyword2 : keywords2) {
                if (!keyword1.trim().isEmpty() && !keyword2.trim().isEmpty() &&
                        keyword1.trim().equals(keyword2.trim())) {
                    return 0.6;
                }
            }
        }

        return 0.0;
    }

    /**
     * 计算技能相似度
     *
     * @param tag1 标签1
     * @param tag2 标签2
     * @return 相似度分数 (0-1)
     */
    public double calculateSkillSimilarity(String tag1, String tag2) {
        if (tag1 == null || tag2 == null) return 0.0;

        // 完全匹配
        if (tag1.equals(tag2)) return 1.0;

        // 包含关系
        if (tag1.contains(tag2) || tag2.contains(tag1)) return 0.8;

        // 相似性映射匹配
        for (Map.Entry<String, List<String>> entry : SKILL_SIMILARITY_MAP.entrySet()) {
            String key = entry.getKey();
            List<String> similarTags = entry.getValue();

            if ((tag1.equals(key) || similarTags.contains(tag1)) &&
                    (tag2.equals(key) || similarTags.contains(tag2))) {
                return 0.7;
            }
        }

        return 0.0;
    }

    /**
     * 计算地点相似度
     *
     * @param tag1 标签1
     * @param tag2 标签2
     * @return 相似度分数 (0-1)
     */
    public double calculateLocationSimilarity(String tag1, String tag2) {
        if (tag1 == null || tag2 == null) return 0.0;

        // 完全匹配
        if (tag1.equals(tag2)) return 1.0;

        // 相似性映射匹配
        for (Map.Entry<String, List<String>> entry : LOCATION_SIMILARITY_MAP.entrySet()) {
            String key = entry.getKey();
            List<String> similarTags = entry.getValue();

            if ((tag1.equals(key) || similarTags.contains(tag1)) &&
                    (tag2.equals(key) || similarTags.contains(tag2))) {
                return 0.8;
            }
        }

        return 0.0;
    }

    /**
     * 计算薪资相似度
     *
     * @param salary1 薪资1 (格式: "min-max")
     * @param salary2 薪资2 (格式: "min-max")
     * @return 相似度分数 (0-1)
     */
    public double calculateSalarySimilarity(String salary1, String salary2) {
        if (salary1 == null || salary2 == null) return 0.0;

        try {
            String[] parts1 = salary1.split("-");
            String[] parts2 = salary2.split("-");

            if (parts1.length != 2 || parts2.length != 2) return 0.0;

            double min1 = Double.parseDouble(parts1[0]);
            double max1 = Double.parseDouble(parts1[1]);
            double min2 = Double.parseDouble(parts2[0]);
            double max2 = Double.parseDouble(parts2[1]);

            // 计算重叠度
            double overlapMin = Math.max(min1, min2);
            double overlapMax = Math.min(max1, max2);

            if (overlapMax < overlapMin) return 0.0;

            double overlap = overlapMax - overlapMin;
            double union = Math.max(max1, max2) - Math.min(min1, min2);

            return overlap / union;
        } catch (NumberFormatException e) {
            return 0.0;
        }
    }

    /**
     * 计算综合相似度
     *
     * @param tag1    标签1
     * @param tag2    标签2
     * @param tagType 标签类型
     * @return 综合相似度分数 (0-1)
     */
    public double calculateComprehensiveSimilarity(String tag1, String tag2, String tagType) {
        if (tag1 == null || tag2 == null) return 0.0;

        switch (tagType) {
            case "position":
                return calculatePositionSimilarity(tag1, tag2);
            case "skill":
                return calculateSkillSimilarity(tag1, tag2);
            case "location":
                return calculateLocationSimilarity(tag1, tag2);
            case "salary":
                return calculateSalarySimilarity(tag1, tag2);
            default:
                return tag1.equals(tag2) ? 1.0 : 0.0;
        }
    }

    /**
     * 获取相似标签列表
     *
     * @param tag     原始标签
     * @param tagType 标签类型
     * @return 相似标签列表
     */
    public List<String> getSimilarTags(String tag, String tagType) {
        List<String> similarTags = new ArrayList<>();

        switch (tagType) {
            case "position":
                for (Map.Entry<String, List<String>> entry : POSITION_SIMILARITY_MAP.entrySet()) {
                    if (entry.getKey().equals(tag) || entry.getValue().contains(tag)) {
                        similarTags.addAll(entry.getValue());
                        similarTags.add(entry.getKey());
                    }
                }
                break;
            case "skill":
                for (Map.Entry<String, List<String>> entry : SKILL_SIMILARITY_MAP.entrySet()) {
                    if (entry.getKey().equals(tag) || entry.getValue().contains(tag)) {
                        similarTags.addAll(entry.getValue());
                        similarTags.add(entry.getKey());
                    }
                }
                break;
            case "location":
                for (Map.Entry<String, List<String>> entry : LOCATION_SIMILARITY_MAP.entrySet()) {
                    if (entry.getKey().equals(tag) || entry.getValue().contains(tag)) {
                        similarTags.addAll(entry.getValue());
                        similarTags.add(entry.getKey());
                    }
                }
                break;
        }

        return similarTags;
    }
}
