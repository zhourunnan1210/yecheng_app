package com.hnu.highlynewapp.controller;

import com.hnu.highlynewapp.utils.ImgSteganoUtil;
import com.hnu.highlynewapp.utils.OssUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

@Api(tags = "图片深度隐写api管理")
@CrossOrigin
@RequestMapping("/imgstegano")
@RestController
public class ImgSteganoController {
    @Autowired
    private OssUtil ossUtil;

    @Autowired
    private ImgSteganoUtil imgSteganoUtil;

    @Value("${storage.input-dir}")
    private String inputDirName;
    @Value("${storage.encoded-dir}")
    private String encoderDirName;
    @Value("${storage.decoded-dir}")
    private String decodedDirName;

    // 文件大小阈值（字节）
    private static final long LSB_THRESHOLD = 300 * 1024;       // 300KB
    private static final long COMPRESS_THRESHOLD = 3 * 1024 * 1024; // 3MB

    @ApiOperation("深度隐写编码")
    @PostMapping(value = "/encode", consumes = {"multipart/form-data"})
    public ResponseEntity<?> encode(
            @ApiParam(value = "待隐写的图片文件", required = true) @RequestPart("file") MultipartFile file,
            @ApiParam(value = "要隐藏的信息", required = true) @RequestPart("message") String message,
            @ApiParam(value = "回调地址", required = false) @RequestPart(value = "callbackUrl", required = false) String callbackUrl,
            HttpServletRequest request) {
        // 如果没有提供回调URL，构建默认回调URL
        if (callbackUrl == null || callbackUrl.trim().isEmpty()) {
            String scheme = request.getScheme();
            String serverName;
            try {
                // 获取本机实际IP地址而不是localhost
                serverName = InetAddress.getLocalHost().getHostAddress();
            } catch (UnknownHostException e) {
                // 如果获取IP失败，回退到使用request.getServerName()
                serverName = request.getServerName();
            }
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
            if (file.getOriginalFilename() != null && file.getContentType() != null) {
//                String inputDirName = "./cache/input_pictures/";
                String timestampDirName = new SimpleDateFormat("yyyy-MM-dd HH").format(new Date(System.currentTimeMillis()));
                // 使用 Paths.get 确保路径分隔符正确
                java.nio.file.Path fullDirPath = java.nio.file.Paths.get(inputDirName, timestampDirName);
                File dir = fullDirPath.toFile();
                if (!dir.exists()) dir.mkdirs();

                String contentType = file.getContentType();
                if (contentType != null && (contentType.equals("image/jpeg") || contentType.equals("image/png"))) {
                    // 生成随机文件名，保留原扩展名
                    String fileName = ossUtil.getRandomFilename() + "." + FilenameUtils.getExtension(file.getOriginalFilename());
                    java.nio.file.Path filePath = fullDirPath.resolve(fileName);
                    File inputPic = filePath.toFile();
                    if (!inputPic.exists()) inputPic.createNewFile();
                    file.transferTo(inputPic.getAbsoluteFile());

                    // 文件大小判断与处理
                    long fileSize = inputPic.length();
                    String method;
                    if (fileSize < LSB_THRESHOLD) {
                        // 小于300KB，使用LSB
                        method = "lsb";
                    } else if (fileSize > COMPRESS_THRESHOLD) {
                        // 大于3MB，先压缩再使用SteganoGAN
                        method = "steganogan";
                        File compressed = ossUtil.compressImage(inputPic, dir.getAbsolutePath(), COMPRESS_THRESHOLD);
                        // 用压缩后的文件替换原文件（保持文件名一致以便后续处理）
                        java.nio.file.Files.copy(compressed.toPath(), inputPic.toPath(),
                                java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                        compressed.delete();
                    } else {
                        // 300KB ~ 3MB，直接使用SteganoGAN
                        method = "steganogan";
                    }

                    // 调用工具类，传递文件名、message、callbackUrl和method
                    Map<String, String> result = imgSteganoUtil.encode(timestampDirName + "/" + fileName, message, callbackUrl, method);
                    return ResponseEntity.ok(result);
                } else {
                    throw new IOException("Unsupported image format: " + contentType + ". Only JPEG and PNG are supported.");
                }
            } else {
                throw new IOException("Invalid file upload");
            }
        } catch (Exception e) {
            return ResponseEntity.status(500).body("文件保存失败: " + e.getMessage());
        }
    }

    @ApiOperation("深度隐写解码")
    @PostMapping(value = "/decode", consumes = {"multipart/form-data"})
    public ResponseEntity<?> decode(
            @ApiParam(value = "待解码的图片文件", required = true) @RequestPart("file") MultipartFile file) {
        try {
            if (file.getOriginalFilename() != null && file.getContentType() != null) {
//                String decodedDirName = "./cache/decoded_pictures/";
                String timestampDirName = new SimpleDateFormat("yyyy-MM-dd HH").format(new Date(System.currentTimeMillis()));
                // 使用 Paths.get 确保路径分隔符正确
                java.nio.file.Path fullDirPath = java.nio.file.Paths.get(decodedDirName, timestampDirName);
                File dir = fullDirPath.toFile();
                if (!dir.exists()) dir.mkdirs();

                // 放宽格式检查，支持常见图片格式
                String contentType = file.getContentType();
                if (contentType != null && (contentType.equals("image/png") || contentType.equals("image/jpeg") || contentType.equals("image/jpg"))) {
                    // 生成随机文件名，统一使用.png扩展名（LSB输出需要PNG）
                    String fileName = ossUtil.getRandomFilename() + ".png";
                    java.nio.file.Path filePath = fullDirPath.resolve(fileName);
                    File decodedPic = filePath.toFile();
                    if (!decodedPic.exists()) decodedPic.createNewFile();
                    file.transferTo(decodedPic.getAbsoluteFile());
                    // 只传递相对文件名
                    Map<String, String> result = imgSteganoUtil.decode(timestampDirName + "/" + fileName);
                    return ResponseEntity.ok(result);
                } else {
                    throw new IOException("Unsupported image format: " + contentType + ". Only JPEG and PNG are supported.");
                }
            } else {
                throw new IOException("Invalid file upload");
            }
        } catch (Exception e) {
            return ResponseEntity.status(500).body("文件保存失败: " + e.getMessage());
        }
    }
}
