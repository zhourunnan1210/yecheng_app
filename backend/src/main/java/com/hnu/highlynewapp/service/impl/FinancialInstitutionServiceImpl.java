package com.hnu.highlynewapp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.hnu.highlynewapp.config.WatermarkConfig;
import com.hnu.highlynewapp.dao.FinancialInstitutionDao;
import com.hnu.highlynewapp.entity.FinancialInstitutionEntity;
import com.hnu.highlynewapp.enums.StatusEnum;
import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.service.FinancialInstitutionService;
import com.hnu.highlynewapp.utils.*;
import com.hnu.highlynewapp.vo.PublishFinancialInstitutionVo;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.StandardCopyOption;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

/**
 * @author LengKuBaiCai
 * @Date
 */
@Service("FinancialInstitutionService")
public class FinancialInstitutionServiceImpl extends ServiceImpl<FinancialInstitutionDao, FinancialInstitutionEntity> implements FinancialInstitutionService {
    @Autowired
    private ImgSteganoUtil imgSteganoUtil;

    @Autowired
    private OssUtil ossUtil;

    @Autowired
    private WatermarkConfig watermarkConfig;

    @Value("${stegano.output-dir}")
    private String steganoOutputDir;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<FinancialInstitutionEntity> page = this.page(
                new Query<FinancialInstitutionEntity>().getPage(params),
                new QueryWrapper<>()
        );
        return new PageUtils(page);
    }

    @Override
    public int request(PublishFinancialInstitutionVo publishFinancialInstitutionVo) {
        FinancialInstitutionEntity financialInstitutionEntity = new FinancialInstitutionEntity();
        BeanUtils.copyProperties(publishFinancialInstitutionVo, financialInstitutionEntity);
        financialInstitutionEntity.setStatus(StatusEnum.STATUS_ONE.getCode());
        return baseMapper.insert(financialInstitutionEntity);
    }

    /*@Override
    public int request(PublishFinancialInstitutionVo publishFinancialInstitutionVo, MultipartFile financialInstitutionImage) {
        if (publishFinancialInstitutionVo.getSanctionDay() == null) {
            publishFinancialInstitutionVo.setSanctionDay(new Timestamp(System.currentTimeMillis()));
        }
        String stegaInfo = "yecheng_APP@HNU-" + publishFinancialInstitutionVo.getSocialCreditCode();
        String url = null;
        // 获取当前时间戳
        long currentTimeMillis = System.currentTimeMillis();
        // 创建SimpleDateFormat对象，定义想要的日期格式
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH");
        // 将时间戳格式化为日期字符串
        String formattedDate = sdf.format(new Date(currentTimeMillis));
        String dirName = "./cache/" + formattedDate;
        File dir = new File(dirName);
        if (!dir.exists())
            dir.mkdirs();
        if (financialInstitutionImage.getOriginalFilename() != null && financialInstitutionImage.getContentType() != null) {
            if (financialInstitutionImage.getContentType().equals("image/jpeg")) {
                File pngImg = ossUtil.JPEGToPNG(financialInstitutionImage, dirName);
                ossUtil.createMark(pngImg.getAbsolutePath(), "yecheng_app@HNU", Color.PINK, 1.0F);
                try {
                    url = uploadProcessedImg(stegaInfo, pngImg);
                } catch (IOException e) {
                    return BizCodeEnum.UPLOAD_FAIL_EXCEPTION.getCode();
                }
            } else if (financialInstitutionImage.getContentType().equals("image/png")) {
                String filePath = dirName + "/" + ossUtil.getRandomFilename() + "." + FilenameUtils.getExtension(financialInstitutionImage.getOriginalFilename());
                File origImg = new File(filePath);
                try {
                    financialInstitutionImage.transferTo(origImg.getAbsoluteFile());
                    ossUtil.createMark(origImg.getAbsolutePath(), "yecheng_app@HNU", Color.PINK, 1.0F);
                    url = uploadProcessedImg(stegaInfo, origImg);
                } catch (IOException e) {
                    e.printStackTrace();
                    return BizCodeEnum.UPLOAD_FAIL_EXCEPTION.getCode();
                }
            } else
                return BizCodeEnum.INPUT_INVALID.getCode();
        } else
            return BizCodeEnum.UPLOAD_FAIL_EXCEPTION.getCode();
        FinancialInstitutionEntity financialInstitutionEntity = new FinancialInstitutionEntity();
        BeanUtils.copyProperties(publishFinancialInstitutionVo, financialInstitutionEntity);
        financialInstitutionEntity.setFinancialInstitutionImage(url);
        financialInstitutionEntity.setStatus(StatusEnum.STATUS_ONE.getCode());
        return baseMapper.insert(financialInstitutionEntity);
    }*/

    /*private String uploadProcessedImg(String stegaInfo, File pngImg) throws IOException {
        BufferedImage embeddedImg = ossUtil.embedText(ImageIO.read(pngImg), stegaInfo);
        ImageIO.write(embeddedImg, "PNG", pngImg);
        embeddedImg.flush();
        FileInputStream fis = new FileInputStream(pngImg);
        MultipartFile multipartFile = new MockMultipartFile(pngImg.getName(), pngImg.getName(), MediaType.MULTIPART_FORM_DATA_VALUE, fis);
        return ossUtil.upload(multipartFile);
    }*/

    // 文件大小阈值（字节）
    private static final long LSB_THRESHOLD = 300 * 1024;       // 300KB
    private static final long COMPRESS_THRESHOLD = 3 * 1024 * 1024; // 3MB

    @Override
    public Map<String, String> request(PublishFinancialInstitutionVo publishFinancialInstitutionVo, MultipartFile multipartFile, String callbackUrl) {
        if (publishFinancialInstitutionVo.getSanctionDay() == null) {
            publishFinancialInstitutionVo.setSanctionDay(new Timestamp(System.currentTimeMillis()));
        }
        Map<String, String> result = new HashMap<>();
        try {
            if (multipartFile.getOriginalFilename() != null && multipartFile.getContentType() != null) {
                String inputDirName = "./cache/input_pictures/";
                String timestampDirName = new SimpleDateFormat("yyyy-MM-dd HH").format(new Date(System.currentTimeMillis()));
                String fullDirName = inputDirName + timestampDirName;
                File dir = new File(fullDirName);

                if (!dir.exists()) dir.mkdirs();

                if (multipartFile.getContentType().equals("image/jpeg") || multipartFile.getContentType().equals("image/png")) {
                    String stegaInfo = watermarkConfig.getStegano().getPrefix() + publishFinancialInstitutionVo.getUnifiedSocialCreditCode();
                    // 使用UUID生成随机文件名，保留原扩展名
                    String fileName = UUID.randomUUID() + "." + FilenameUtils.getExtension(multipartFile.getOriginalFilename());
                    String filePath = fullDirName + "/" + fileName;
                    File inputPic = new File(filePath);
                    if (!inputPic.exists()) inputPic.createNewFile();
                    multipartFile.transferTo(inputPic.getAbsoluteFile());

                    // Add visible watermark if enabled
                    if (watermarkConfig.getVisible().isEnabled()) {
                        ossUtil.createMark(inputPic.getAbsolutePath(),
                                watermarkConfig.getVisible().getText(),
                                watermarkConfig.getVisible().getColorObject(),
                                watermarkConfig.getVisible().getOpacity());
                    }

                    // 文件大小判断与处理
                    long fileSize = inputPic.length();
                    String method;
                    if (fileSize < LSB_THRESHOLD) {
                        method = "lsb";
                    } else if (fileSize > COMPRESS_THRESHOLD) {
                        method = "steganogan";
                        File compressed = ossUtil.compressImage(inputPic, dir.getAbsolutePath(), COMPRESS_THRESHOLD);
                        java.nio.file.Files.copy(compressed.toPath(), inputPic.toPath(),
                                java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                        compressed.delete();
                    } else {
                        method = "steganogan";
                    }

                    // 调用Python隐写服务进行处理（不传callbackUrl，改为同步等待）
                    Map<String, Object> encodeResponse = imgSteganoUtil.encode(timestampDirName + "/" + fileName, stegaInfo, null, method);

                    if (encodeResponse == null || !encodeResponse.containsKey("task_id")) {
                        result.put("500", "隐写服务调用失败");
                        return result;
                    }

                    String taskId = (String) encodeResponse.get("task_id");

                    // 同步轮询等待隐写处理完成
                    Map<String, Object> processResult = imgSteganoUtil.waitForEncodeCompletion(taskId);

                    if (processResult == null) {
                        result.put("500", "隐写处理超时");
                        return result;
                    }

                    Boolean success = (Boolean) processResult.get("success");
                    if (success == null || !success) {
                        String error = (String) processResult.get("error");
                        result.put("500", "隐写处理失败: " + (error != null ? error : "未知错误"));
                        return result;
                    }

                    // 获取处理后的图片文件名和方法
                    String encodedImageName = (String) processResult.get("encoded_image_name");
                    String usedMethod = (String) processResult.get("method");
                    if (usedMethod == null) usedMethod = method;
                    if (encodedImageName == null) {
                        result.put("500", "未获取到处理后的图片信息");
                        return result;
                    }

                    // 从Python输出的共享路径读取编码后的图片
                    String encodedImagePath = steganoOutputDir + "/"
                            + usedMethod + "/" + taskId + "/" + taskId + ".png";
                    File encodedImageFile = new File(encodedImagePath);
                    if (!encodedImageFile.exists()) {
                        // 回退到旧路径（兼容）
                        encodedImagePath = "./cache/encoded_pictures/" + encodedImageName;
                        encodedImageFile = new File(encodedImagePath);
                        if (!encodedImageFile.exists()) {
                            result.put("500", "处理后的图片文件不存在: " + encodedImagePath);
                            return result;
                        }
                    }

                    // 复制处理后的图片到本地存储目录（不用OSS）
                    String localImageDir = steganoOutputDir + "/" + usedMethod + "/" + taskId + "/";
                    File localDir = new File(localImageDir);
                    if (!localDir.exists()) localDir.mkdirs();

                    String localFileName = UUID.randomUUID() + ".png";
                    File destFile = new File(localImageDir + localFileName);
                    java.nio.file.Files.copy(encodedImageFile.toPath(), destFile.toPath(), StandardCopyOption.REPLACE_EXISTING);

                    // 设置VO并入库
                    publishFinancialInstitutionVo.setImgStegaStatus(2); // 2：隐写成功
                    publishFinancialInstitutionVo.setTaskId(taskId);
                    FinancialInstitutionEntity financialInstitutionEntity = new FinancialInstitutionEntity();
                    BeanUtils.copyProperties(publishFinancialInstitutionVo, financialInstitutionEntity);
                    financialInstitutionEntity.setStatus(StatusEnum.STATUS_ONE.getCode());
                    financialInstitutionEntity.setFinancialInstitutionImage("/image/watermark/encoder/" + usedMethod + "/" + taskId + "/" + localFileName);
                    baseMapper.insert(financialInstitutionEntity);

                    result.put("code", "200");
                    result.put("message", "提交成功");
                    result.put("financial_institution_id", financialInstitutionEntity.getFinancialInstitutionId().toString());
                    return result;
                } else {
                    throw new IOException("Unsupported image format. Only JPEG and PNG are supported.");
                }
            } else {
                throw new IOException("Invalid file upload");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("500", "文件处理失败: " + e.getMessage());
            return result;
        }
    }

    @Override
    public List<FinancialInstitutionEntity> getListById(long financial_institution_id) {
        QueryWrapper<FinancialInstitutionEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("financial_institution_id", financial_institution_id);
        return baseMapper.selectList(wrapper);
    }

    @Override
    public List<FinancialInstitutionEntity> getByFinancialInstitutionName(String financial_institution_name) {
        QueryWrapper<FinancialInstitutionEntity> wrapper = new QueryWrapper<>();
        wrapper.like("financial_institution_name", financial_institution_name);
        return baseMapper.selectList(wrapper);
    }

    @Override
    public int updateFinancialInstitution(FinancialInstitutionEntity financialInstitutionEntity) {
        return baseMapper.updateById(financialInstitutionEntity);
    }

    @Override
    public String getResultByFinancialInstitutionId(long financial_institution_id) {
        FinancialInstitutionEntity financialInstitutionEntity = baseMapper.selectById(financial_institution_id);
        return StatusEnum.findMsgByCode(financialInstitutionEntity.getStatus());
    }

    @Override
    public List<FinancialInstitutionEntity> getCreditMaterialsByFinancialInstitutionName(String financial_institution_name) {
        QueryWrapper<FinancialInstitutionEntity> wrapper = new QueryWrapper<>();
        wrapper.like("financial_institution_name", financial_institution_name);
        return baseMapper.selectList(wrapper);
    }
}
