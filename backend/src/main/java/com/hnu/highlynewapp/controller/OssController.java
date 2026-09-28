package com.hnu.highlynewapp.controller;

import com.hnu.highlynewapp.exception.BizCodeEnum;
import com.hnu.highlynewapp.utils.ImgSteganoUtil;
import com.hnu.highlynewapp.utils.OssUtil;
import com.hnu.highlynewapp.utils.R;
import com.hnu.highlynewapp.config.WatermarkConfig;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @author zhourunnan
 * @Date 2021/1/3
 */
@Api(tags = "对象存储api管理")
@CrossOrigin
@RestController
public class OssController {
    @Autowired
    private ImgSteganoUtil imgSteganoUtil;

    @Autowired
    private OssUtil ossUtil;

    @Autowired
    private WatermarkConfig watermarkConfig;


    @Value("${storage.base-dir}")
    private String baseDirName;
    @Value("${storage.input-dir}")
    private String inputDirName;
    @Value("${storage.encoded-dir}")
    private String encoderDirName;
    @Value("${storage.decoded-dir}")
    private String decodedDirName;

    /**
     * 上传单文件
     *
     * @param file
     * @return
     */
    @ApiOperation("上传单文件")
    @PostMapping(value = "/upload/single", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
    public R upload(@RequestParam("file") MultipartFile file) {
        String url;
        try {
            url = ossUtil.upload(file);
        } catch (IOException e) {
            return R.error(BizCodeEnum.UPLOAD_FAIL_EXCEPTION.getCode(), BizCodeEnum.UPLOAD_FAIL_EXCEPTION.getMessage());
        }
        Map<String, Object> map = new HashMap<>();
        map.put("url", url);
        return R.ok().put("data", map);
    }

    /**
     * 上传单个水印文件
     *
     * @param multipartFile
     * @return
     */
    /*@ApiOperation("上传单个水印文件")
    @PostMapping(value = "/upload/stega", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
    public R uploadWithStega(@RequestParam("file") MultipartFile multipartFile) {
        String stegaInfo = "yecheng_APP@HNU";
        String url;

        try {
            // 添加可见水印
            File processedFile = processVisibleWatermark(multipartFile);

            // 使用高级隐写术添加不可见水印
            MultipartFile processedMultipartFile = convertFileToMultipartFile(processedFile);
            byte[] embeddedImageBytes = steganoClient.embedMessage(processedMultipartFile, stegaInfo);

            // 转换处理后的图像为MultipartFile并上传
            MultipartFile embeddedFile = new MockMultipartFile(
                    "embedded_" + multipartFile.getOriginalFilename(),
                    "embedded_" + multipartFile.getOriginalFilename(),
                    "image/png",
                    embeddedImageBytes
            );

            url = ossUtil.upload(embeddedFile);

            // 清理临时文件
            processedFile.delete();
        } catch (IOException e) {
            e.printStackTrace();
            return R.error(BizCodeEnum.UPLOAD_FAIL_EXCEPTION.getCode(), BizCodeEnum.UPLOAD_FAIL_EXCEPTION.getMessage());
        }

        Map<String, Object> map = new HashMap<>();
        map.put("url", url);
        return R.ok().put("data", map);
    }*/

    /**
     * 上传单个水印文件
     *
     * @param multipartFile
     * @return
     */
    @ApiOperation("上传单个水印文件")
    @PostMapping(value = "/upload/stega", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
    public R uploadWithStega(
            @ApiParam(value = "待隐写的图片文件", required = true) @RequestPart("multipartFile") MultipartFile multipartFile,
            @ApiParam(value = "要隐藏的信息", required = true) @RequestPart("message") String message,
            @ApiParam(value = "回调地址", required = false) @RequestPart(value = "callbackUrl", required = false) String callbackUrl,
            HttpServletRequest request) {
        String stegaInfo = watermarkConfig.getStegano().getPrefix();

        // 如果没有提供回调URL，构建默认回调URL
        if (callbackUrl == null || callbackUrl.trim().isEmpty()) {
            String scheme = request.getScheme();
            String serverName = request.getServerName();
            int serverPort = request.getServerPort();
            String contextPath = request.getContextPath();

            String baseUrl = scheme + "://" + serverName;
            if ((scheme.equals("http") && serverPort != 80) || (scheme.equals("https") && serverPort != 443)) {
                baseUrl += ":" + serverPort;
            }
            baseUrl += contextPath;

            callbackUrl = baseUrl + "/stegano/callback/encode/result";
        }

        try {
            if (multipartFile.getOriginalFilename() != null && multipartFile.getContentType() != null) {
//                String inputDirName = "./cache/input_pictures/";
                String timestampDirName = new SimpleDateFormat("yyyy-MM-dd HH").format(new Date(System.currentTimeMillis()));
                String fullDirName = inputDirName + timestampDirName;
                File dir = new File(fullDirName);

                if (!dir.exists()) dir.mkdirs();

                if (multipartFile.getContentType().equals("image/jpeg") || multipartFile.getContentType().equals("image/png")) {
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

                    // 调用Python隐写服务进行处理
                    Map<String, Object> encodeResponse = imgSteganoUtil.encode(timestampDirName + "/" + fileName, stegaInfo + message, callbackUrl);

                    if (encodeResponse == null || !encodeResponse.containsKey("task_id")) {
                        return R.error(500, "隐写服务调用失败");
                    }

                    String taskId = (String) encodeResponse.get("task_id");

                    // 轮询等待处理完成
                    Map<String, Object> processResult = imgSteganoUtil.waitForEncodeCompletion(taskId);

                    if (processResult == null) {
                        return R.error(500, "隐写处理超时");
                    }

                    // 检查处理是否成功
                    Boolean success = (Boolean) processResult.get("success");
                    if (success == null || !success) {
                        String error = (String) processResult.get("error");
                        return R.error(500, "隐写处理失败: " + (error != null ? error : "未知错误"));
                    }

                    // 获取处理后的图片文件名
                    String encodedImageName = (String) processResult.get("encoded_image_name");
                    if (encodedImageName == null) {
                        return R.error(500, "未获取到处理后的图片信息");
                    }

                    // 构建处理后图片的完整路径
//                    String encodedImagePath = "./cache/encoded_pictures/" + encodedImageName;
                    String encodedImagePath = encoderDirName + encodedImageName;

                    File encodedImageFile = new File(encodedImagePath);

                    if (!encodedImageFile.exists()) {
                        return R.error(500, "处理后的图片文件不存在: " + encodedImagePath);
                    }

                    // 上传处理后的图片到OSS，传入完整路径
                    String ossUrl = ossUtil.uploadFromLocalPath(encodedImagePath, "stegano");

                    // 删除本地缓存文件（可选）
                    /*try {
                        inputPic.delete();
                        encodedImageFile.delete();
                    } catch (Exception e) {
                        // 删除失败不影响主流程
                        System.out.println("清理缓存文件失败: " + e.getMessage());
                    }*/

                    // 返回OSS链接
                    Map<String, Object> result = new HashMap<>();
                    result.put("url", ossUrl);
                    result.put("task_id", taskId);
                    result.put("message", "隐写处理完成并已上传到OSS");

                    return R.ok().put("data", result);
                } else {
                    throw new IOException("Unsupported image format. Only JPEG and PNG are supported.");
                }
            } else {
                throw new IOException("Invalid file upload");
            }
        } catch (Exception e) {
            return R.error(500, "文件处理失败: " + e.getMessage());
        }
    }

    /**
     * 提取水印消息
     *
     * @param multipartFile
     * @return
     */
    /*@ApiOperation("从图片中提取水印")
    @PostMapping(value = "/extract/stega", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
    public R extractStega(@RequestParam("file") MultipartFile multipartFile) {
        try {
            String message = steganoClient.extractMessage(multipartFile);
            Map<String, Object> map = new HashMap<>();
            map.put("message", message);
            return R.ok().put("data", map);
        } catch (IOException e) {
            e.printStackTrace();
            return R.error(BizCodeEnum.UPLOAD_FAIL_EXCEPTION.getCode(), "Failed to extract steganographic message");
        }
    }*/

    /**
     * 处理可见水印
     */
    private File processVisibleWatermark(MultipartFile multipartFile) throws IOException {
//        String dirName = "./cache/" + new SimpleDateFormat("yyyy-MM-dd HH").format(new Date(System.currentTimeMillis()));
        String dirName = baseDirName + new SimpleDateFormat("yyyy-MM-dd HH").format(new Date(System.currentTimeMillis()));
        File dir = new File(dirName);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        File processedFile;
        if (multipartFile.getOriginalFilename() != null && multipartFile.getContentType() != null) {
            if (multipartFile.getContentType().equals("image/jpeg")) {
                // Convert JPEG to PNG for better quality watermarking
                processedFile = ossUtil.JPEGToPNG(multipartFile, dirName);
            } else if (multipartFile.getContentType().equals("image/png")) {
                // Save PNG file directly
                String filePath = dirName + "/" + ossUtil.getRandomFilename() + "." + FilenameUtils.getExtension(multipartFile.getOriginalFilename());
                processedFile = new File(filePath);
                multipartFile.transferTo(processedFile.getAbsoluteFile());
            } else {
                throw new IOException("Unsupported image format. Only JPEG and PNG are supported.");
            }

            // Add visible watermark if enabled
            if (watermarkConfig.getVisible().isEnabled()) {
                ossUtil.createMark(processedFile.getAbsolutePath(),
                        watermarkConfig.getVisible().getText(),
                        watermarkConfig.getVisible().getColorObject(),
                        watermarkConfig.getVisible().getOpacity());
            }
            return processedFile;
        } else {
            throw new IOException("Invalid file upload");
        }
    }

    /**
     * 将File转换为MultipartFile
     */
    private MultipartFile convertFileToMultipartFile(File file) throws IOException {
        FileInputStream fileInputStream = new FileInputStream(file);
        return new MockMultipartFile(
                file.getName(),
                file.getName(),
                MediaType.IMAGE_PNG_VALUE,
                fileInputStream
        );
    }

    /**
     * 上传多文件
     *
     * @param files
     * @return
     */
    @ApiOperation("上传多文件")
    @PostMapping(value = "/upload/multi", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
    public R upload(@RequestParam("files") MultipartFile[] files) {
        List<String> urls = null;
        try {
            urls = ossUtil.upload(files);
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (urls == null || urls.size() == 0) {
            return R.error(BizCodeEnum.UPLOAD_FAIL_EXCEPTION.getCode(), BizCodeEnum.UPLOAD_FAIL_EXCEPTION.getMessage());
        }
        Map<String, Object> map = new HashMap<>();
        map.put("urls", urls);
        return R.ok().put("data", map);
    }

    /**
     * 删除文件
     *
     * @param urls
     * @return
     */
    @ApiOperation("删除文件")
    @DeleteMapping("/delete")
    public R delete(@RequestBody String[] urls) {
        ossUtil.delete(urls);
        return R.ok();
    }

    /**
     * 删除指定前缀或目录下的多个文件
     *
     * @param targetName
     * @return
     */
    @ApiOperation("删除指定前缀或目录下的多个文件")
    @DeleteMapping("/deleteAllOf")
    public R deleteAllOf(@RequestParam("targetName") String targetName) {
        int result = ossUtil.deleteAllOf(targetName);
        if (result == 1)
            return R.ok();
        else
            return R.error("删除失败！");
    }
}
