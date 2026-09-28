package com.hnu.highlynewapp.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Web配置类，用于配置CORS和静态资源映射
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Value("${storage.image-dir:${storage.base-dir}}")
    private String imageDir;

    /** 允许跨域访问的前端来源，逗号分隔。部署时通过 CORS_ALLOWED_ORIGINS 环境变量覆盖。 */
    @Value("${cors.allowed-origins:http://localhost:8080,http://127.0.0.1:8080}")
    private String[] allowedOrigins;

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**") // 应用到所有端点
                .allowedOrigins(allowedOrigins) // 允许前端域名
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // 允许的HTTP方法
                .allowedHeaders("*") // 允许所有请求头
                .allowCredentials(true) // 允许携带凭证
                .maxAge(3600); // 预检请求的缓存时间
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/image/**")
                .addResourceLocations("file:" + imageDir + "/");
    }
} 