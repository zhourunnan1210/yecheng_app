package com.hnu.highlynewapp.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @author zhourunnan
 * @Date 2021/1/3
 */
@Component
@ConfigurationProperties(prefix = "highlynewapp.oss")
@Data
public class OssConfigProperties {
    private Integer coreSize;
    private Integer maxSize;
    private Integer keepAliveTime;
}
