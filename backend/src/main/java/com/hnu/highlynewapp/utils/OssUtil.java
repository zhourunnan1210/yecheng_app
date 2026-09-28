package com.hnu.highlynewapp.utils;

import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.OSSException;
import com.aliyun.oss.model.*;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.*;

/**
 * @author zhourunnan
 * @Date 2021/1/3
 */
@Component
public class OssUtil {
    @Value("${oss.endpoint}")
    private String endpoint;
    @Value("${oss.access-key-id}")
    private String accessKeyId;
    @Value("${oss.access-key-secret}")
    private String accessKeySecret;
    @Value("${oss.bucket-name}")
    private String bucketName;
    private OSS ossClient = null;
    private InputStream inputStream = null;

    /**
     * 本桶的访问域名，形如 {bucket}.{endpoint}。
     * 业务代码用它判断一个图片 URL 是指向本桶（真实上传的图片）还是默认占位图。
     */
    public String getBucketDomain() {
        return bucketName + "." + endpoint;
    }

    public String upload(MultipartFile file) throws IOException {
        ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

        String fileName = new SimpleDateFormat("yyyy-MM-dd").format(new Date()) + "/" + UUID.randomUUID().toString() + "." + file.getOriginalFilename().split("\\.")[1];
        try {
            inputStream = new ByteArrayInputStream(file.getBytes());
            ossClient.putObject(bucketName, fileName, inputStream);
        } catch (OSSException oe) {
            System.out.println("Caught an OSSException, which means your request made it to OSS, "
                    + "but was rejected with an error response for some reason.");
            System.out.println("Error Message:" + oe.getErrorMessage());
            System.out.println("Error Code:" + oe.getErrorCode());
            System.out.println("Request ID:" + oe.getRequestId());
            System.out.println("Host ID:" + oe.getHostId());
        } catch (ClientException ce) {
            System.out.println("Caught an ClientException, which means the client encountered "
                    + "a serious internal problem while trying to communicate with OSS, "
                    + "such as not being able to access the network.");
            System.out.println("Error Message:" + ce.getMessage());
        } finally {
            if (ossClient != null)
                ossClient.shutdown();
        }
        return "http://" + bucketName + "." + endpoint + "/" + fileName;
    }

    public List<String> upload(MultipartFile[] files) throws IOException {
        ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
        List<String> urls = new ArrayList<>();

        try {
            for (MultipartFile file : files) {
                if (StringUtils.isNotBlank(file.getOriginalFilename())) {
                    String fileName = new SimpleDateFormat("yyyy-MM-dd").format(new Date()) + "/" + UUID.randomUUID().toString() + "." + file.getOriginalFilename().split("\\.")[1];
                    inputStream = new ByteArrayInputStream(file.getBytes());
                    ossClient.putObject(bucketName, fileName, inputStream);
                    String url = "http://" + bucketName + "." + endpoint + "/" + fileName;
                    urls.add(url);
                } else
                    return null;
            }
        } catch (OSSException oe) {
            System.out.println("Caught an OSSException, which means your request made it to OSS, "
                    + "but was rejected with an error response for some reason.");
            System.out.println("Error Message:" + oe.getErrorMessage());
            System.out.println("Error Code:" + oe.getErrorCode());
            System.out.println("Request ID:" + oe.getRequestId());
            System.out.println("Host ID:" + oe.getHostId());
        } catch (ClientException ce) {
            System.out.println("Caught an ClientException, which means the client encountered "
                    + "a serious internal problem while trying to communicate with OSS, "
                    + "such as not being able to access the network.");
            System.out.println("Error Message:" + ce.getMessage());
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
        return urls;
    }

    public void delete(String[] objectNames) {
        // 创建OSSClient实例。
        OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

        for (String objectName : objectNames) {
            try {
                // 删除文件或目录。如果要删除目录，目录必须为空。
                ossClient.deleteObject(bucketName, objectName);
            } catch (OSSException oe) {
                System.out.println("Caught an OSSException, which means your request made it to OSS, "
                        + "but was rejected with an error response for some reason.");
                System.out.println("Error Message:" + oe.getErrorMessage());
                System.out.println("Error Code:" + oe.getErrorCode());
                System.out.println("Request ID:" + oe.getRequestId());
                System.out.println("Host ID:" + oe.getHostId());
            } catch (ClientException ce) {
                System.out.println("Caught an ClientException, which means the client encountered "
                        + "a serious internal problem while trying to communicate with OSS, "
                        + "such as not being able to access the network.");
                System.out.println("Error Message:" + ce.getMessage());
            } finally {
                if (ossClient != null) {
                    ossClient.shutdown();
                }
            }
        }
    }

    public int deleteAllOf(String targetName) {
        // 如果您需要删除所有前缀为src的文件，则prefix设置为src。设置为src后，所有前缀为src的非目录文件、src目录以及目录下的所有文件均会被删除。
        String prefix = targetName;
        if (StringUtils.isBlank(prefix))
            return 0;
        // 如果您仅需要删除src目录及目录下的所有文件，则prefix设置为src/。
        // String prefix = "src/";

        // 创建OSSClient实例。
        OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

        try {
            // 列举所有包含指定前缀的文件并删除。
            String nextMarker = null;
            ObjectListing objectListing = null;
            do {
                ListObjectsRequest listObjectsRequest = new ListObjectsRequest(bucketName)
                        .withPrefix(prefix)
                        .withMarker(nextMarker);

                objectListing = ossClient.listObjects(listObjectsRequest);
                if (objectListing.getObjectSummaries().size() > 0) {
                    List<String> keys = new ArrayList<String>();
                    for (OSSObjectSummary s : objectListing.getObjectSummaries()) {
                        System.out.println("key name: " + s.getKey());
                        keys.add(s.getKey());
                    }
                    DeleteObjectsRequest deleteObjectsRequest = new DeleteObjectsRequest(bucketName).withKeys(keys).withEncodingType("url");
                    DeleteObjectsResult deleteObjectsResult = ossClient.deleteObjects(deleteObjectsRequest);
                    List<String> deletedObjects = deleteObjectsResult.getDeletedObjects();
                    try {
                        for (String obj : deletedObjects) {
                            String deleteObj = URLDecoder.decode(obj, "UTF-8");
                            System.out.println(deleteObj);
                        }
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    }
                }

                nextMarker = objectListing.getNextMarker();
            } while (objectListing.isTruncated());
        } catch (OSSException oe) {
            System.out.println("Caught an OSSException, which means your request made it to OSS, "
                    + "but was rejected with an error response for some reason.");
            System.out.println("Error Message:" + oe.getErrorMessage());
            System.out.println("Error Code:" + oe.getErrorCode());
            System.out.println("Request ID:" + oe.getRequestId());
            System.out.println("Host ID:" + oe.getHostId());
        } catch (ClientException ce) {
            System.out.println("Caught an ClientException, which means the client encountered "
                    + "a serious internal problem while trying to communicate with OSS, "
                    + "such as not being able to access the network.");
            System.out.println("Error Message:" + ce.getMessage());
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
            return 1;
        }
    }

    public File JPEGToPNG(MultipartFile multipartFile, String directoryName) {
        String filename = getRandomFilename();
        File jpegImg = new File(directoryName + "/" + filename + "." + FilenameUtils.getExtension(multipartFile.getOriginalFilename()));
        String filePath = directoryName + "/" + filename + ".png";
        File pngImg = new File(filePath);
        try {
            multipartFile.transferTo(jpegImg.getAbsoluteFile());
            BufferedImage bufferedImage = ImageIO.read(jpegImg);
            ImageIO.write(bufferedImage, "PNG", pngImg);
            bufferedImage.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return pngImg;
    }

    /**
     * 给图片添加水印
     *
     * @param filePath         需要添加水印的图片的路径
     * @param markContent      水印的文字
     * @param markContentColor 水印文字的颜色
     * @param qualNum          图片质量
     * @return
     */
    public boolean createMark(String filePath, String markContent,
                              Color markContentColor, float qualNum) {
        try {
            File srcFile = new File(filePath);
            BufferedImage srcImg = ImageIO.read(srcFile);
            if (srcImg == null) return false;

            int imgType = srcImg.getColorModel().hasAlpha() ? BufferedImage.TYPE_INT_ARGB : BufferedImage.TYPE_INT_RGB;
            BufferedImage bufferedImage = new BufferedImage(srcImg.getWidth(), srcImg.getHeight(), imgType);
            Graphics2D g = bufferedImage.createGraphics();
            g.drawImage(srcImg, 0, 0, null);

            // 设置抗锯齿
            g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

            // 文字水印大小自适应
            int width = srcImg.getWidth();
            int height = srcImg.getHeight();
            int maxFontSize = width / 5; // 最大字体
            int minFontSize = 16;        // 最小字体
            int fontSize = maxFontSize;
            Font font = new Font("Microsoft YaHei", Font.ITALIC, fontSize);
            g.setFont(font);
            FontMetrics metrics = g.getFontMetrics(font);
            while ((metrics.stringWidth(markContent) > width * 0.8) && (fontSize > minFontSize)) {
                fontSize--;
                font = new Font("Microsoft YaHei", Font.ITALIC, fontSize);
                g.setFont(font);
                metrics = g.getFontMetrics(font);
            }
            g.setFont(font);
            g.setColor(markContentColor);

            // 居中或自定义位置
            int x = (width - metrics.stringWidth(markContent)) / 2;
            int y = height / 5 + metrics.getAscent();

            // 设置透明度
            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER, Math.min(qualNum, 1.0f)));

            g.drawString(markContent, x, y);
            g.dispose();

            // 判断保存格式
            String ext = FilenameUtils.getExtension(filePath).toLowerCase();
            if (ext.equals("png")) {
                ImageIO.write(bufferedImage, "PNG", srcFile);
            } else {
                ImageIO.write(bufferedImage, "JPEG", srcFile);
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 将字符串嵌入图像
    /*public BufferedImage embedText(BufferedImage image, String text) {
        int width = image.getWidth();
        int height = image.getHeight();
        BufferedImage newImage = new BufferedImage(width, height, image.getType());
        newImage.getGraphics().drawImage(image, 0, 0, null);

        // 将字符串转为二进制
        String binaryText = toBinaryString(text) + "1111111111111110"; // 用特定标记表示结束
        int index = 0;

        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                int pixel = newImage.getRGB(i, j);
                int a = (pixel >> 24) & 0xff; // alpha
                int r = (pixel >> 16) & 0xff; // red
                int g = (pixel >> 8) & 0xff; // green
                int b = (pixel) & 0xff; // blue

                // 替换最低有效位
                if (index < binaryText.length()) {
                    r = (r & 0xFE) | (binaryText.charAt(index) - '0');
                    index++;
                }
                pixel = (a << 24) | (r << 16) | (g << 8) | b;
                newImage.setRGB(i, j, pixel);

                if (index >= binaryText.length()) break;
            }
            if (index >= binaryText.length()) break;
        }
        return newImage;
    }*/

    // 从图像中提取字符串
    /*public String extractText(BufferedImage image) {
        StringBuilder binaryText = new StringBuilder();
        int width = image.getWidth();
        int height = image.getHeight();

        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                int pixel = image.getRGB(i, j);
                int r = (pixel >> 16) & 0xff; // red
                binaryText.append(r & 1); // 获取最低有效位

                // 检查结束标记
                if (binaryText.length() >= 16 && binaryText.substring(binaryText.length() - 16).equals("1111111111111110")) {
                    return fromBinaryString(binaryText.substring(0, binaryText.length() - 16));
                }
            }
        }
        return null; // 如果没有找到文本
    }*/

    // 将字符串转为二进制
    /*private String toBinaryString(String text) {
        StringBuilder binary = new StringBuilder();
        for (char c : text.toCharArray()) {
            String bin = Integer.toBinaryString(c);
            while (bin.length() < 8) {
                bin = "0" + bin;
            }
            binary.append(bin);
        }
        return binary.toString();
    }*/

    // 从二进制转为字符串
    /*private String fromBinaryString(String binary) {
        StringBuilder text = new StringBuilder();
        for (int i = 0; i < binary.length(); i += 8) {
            String byteString = binary.substring(i, Math.min(i + 8, binary.length()));
            text.append((char) Integer.parseInt(byteString, 2));
        }
        return text.toString();
    }*/

    /**
     * 压缩图片文件到指定大小以下
     * 策略：先降低JPEG quality，如果仍不满足则按比例缩小尺寸
     *
     * @param sourceFile 原图文件
     * @param outputDir  输出目录
     * @param maxBytes   目标最大文件大小（字节）
     * @return 压缩后的文件
     */
    public File compressImage(File sourceFile, String outputDir, long maxBytes) throws IOException {
        String baseName = FilenameUtils.getBaseName(sourceFile.getName());
        File outputFile = new File(outputDir + "/" + baseName + "_compressed.jpg");

        BufferedImage image = ImageIO.read(sourceFile);
        if (image == null) {
            throw new IOException("无法读取图片: " + sourceFile.getAbsolutePath());
        }

        // 先尝试降低JPEG quality
        float[] qualities = {0.85f, 0.7f, 0.55f, 0.4f, 0.25f};
        for (float quality : qualities) {
            writeJpegWithQuality(image, outputFile, quality);
            if (outputFile.length() <= maxBytes) {
                return outputFile;
            }
        }

        // 如果降低quality仍不满足，则按比例缩小尺寸
        int width = image.getWidth();
        int height = image.getHeight();
        double scale = Math.sqrt((double) maxBytes / outputFile.length()) * 0.9;

        int newWidth = Math.max((int) (width * scale), 100);
        int newHeight = Math.max((int) (height * scale), 100);
        Image scaled = image.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH);
        BufferedImage resized = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_RGB);
        resized.getGraphics().drawImage(scaled, 0, 0, null);

        writeJpegWithQuality(resized, outputFile, 0.7f);
        return outputFile;
    }

    private void writeJpegWithQuality(BufferedImage image, File outputFile, float quality) throws IOException {
        javax.imageio.ImageWriter writer = ImageIO.getImageWritersByFormatName("jpg").next();
        javax.imageio.stream.ImageOutputStream ios = ImageIO.createImageOutputStream(outputFile);
        writer.setOutput(ios);

        javax.imageio.plugins.jpeg.JPEGImageWriteParam param = new javax.imageio.plugins.jpeg.JPEGImageWriteParam(null);
        param.setCompressionMode(javax.imageio.plugins.jpeg.JPEGImageWriteParam.MODE_EXPLICIT);
        param.setCompressionQuality(quality);
        writer.write(null, new javax.imageio.IIOImage(image, null, null), param);
        writer.dispose();
        ios.close();
    }

    public String getRandomFilename() {
        long currentTimeMillis = System.currentTimeMillis();
        SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
        String formattedDate = sdf.format(new Date(currentTimeMillis));
        String characters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        Random random = new Random();
        StringBuilder stringBuilder = new StringBuilder();
        for (int i = 0; i < 4; i++) {
            int index = random.nextInt(characters.length());
            stringBuilder.append(characters.charAt(index));
        }
        return formattedDate + stringBuilder;
    }

    /**
     * 从本地文件路径上传到OSS
     *
     * @param localFilePath 本地加密图像的完整路径
     * @return OSS文件URL
     * @throws IOException 上传失败时抛出异常
     */
    public String uploadFromLocalPath(String localFilePath) throws IOException {
        File localFile = new File(localFilePath);
        if (!localFile.exists()) {
            throw new FileNotFoundException("本地加密文件不存在: " + localFilePath);
        }

        ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

        // 生成OSS文件名，保持原有的目录结构
        String fileName = new SimpleDateFormat("yyyy-MM-dd").format(new Date())
                + "/stegano/" + UUID.randomUUID().toString()
                + "." + FilenameUtils.getExtension(localFilePath);

        try {
            // 使用FileInputStream读取本地文件
            inputStream = new FileInputStream(localFile);
            ossClient.putObject(bucketName, fileName, inputStream);
        } catch (OSSException oe) {
            System.out.println("Caught an OSSException, which means your request made it to OSS, "
                    + "but was rejected with an error response for some reason.");
            System.out.println("Error Message:" + oe.getErrorMessage());
            System.out.println("Error Code:" + oe.getErrorCode());
            System.out.println("Request ID:" + oe.getRequestId());
            System.out.println("Host ID:" + oe.getHostId());
            throw new IOException("OSS上传失败: " + oe.getErrorMessage());
        } catch (ClientException ce) {
            System.out.println("Caught an ClientException, which means the client encountered "
                    + "a serious internal problem while trying to communicate with OSS, "
                    + "such as not being able to access the network.");
            System.out.println("Error Message:" + ce.getMessage());
            throw new IOException("OSS客户端错误: " + ce.getMessage());
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }

        return "http://" + bucketName + "." + endpoint + "/" + fileName;
    }

    /**
     * 从本地文件路径上传到OSS（指定目录）
     *
     * @param localFilePath 本地加密图像的完整路径
     * @param ossDirectory  OSS目录前缀
     * @return OSS文件URL
     * @throws IOException 上传失败时抛出异常
     */
    public String uploadFromLocalPath(String localFilePath, String ossDirectory) throws IOException {
        File localFile = new File(localFilePath);
        if (!localFile.exists()) {
            throw new FileNotFoundException("本地加密文件不存在: " + localFilePath);
        }

        ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

        // 生成OSS文件名
        String fileName = ossDirectory + "/" + new SimpleDateFormat("yyyy-MM-dd").format(new Date())
                + "/stegano/" + UUID.randomUUID().toString()
                + "." + FilenameUtils.getExtension(localFilePath);

        try {
            inputStream = new FileInputStream(localFile);
            ossClient.putObject(bucketName, fileName, inputStream);
        } catch (OSSException oe) {
            System.out.println("OSS上传异常: " + oe.getErrorMessage());
            throw new IOException("OSS上传失败: " + oe.getErrorMessage());
        } catch (ClientException ce) {
            System.out.println("OSS客户端异常: " + ce.getMessage());
            throw new IOException("OSS客户端错误: " + ce.getMessage());
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }

        return "http://" + bucketName + "." + endpoint + "/" + fileName;
    }
}
