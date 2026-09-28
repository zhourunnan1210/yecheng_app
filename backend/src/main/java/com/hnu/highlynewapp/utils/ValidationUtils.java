package com.hnu.highlynewapp.utils;

import org.springframework.validation.BindingResult;

import java.util.HashMap;
import java.util.Map;

/**
 * @author zhourunnan
 * @Date 2021/1/6
 */
public class ValidationUtils {
    public static Map<String, String> getErrors(BindingResult result) {
        Map<String, String> map = new HashMap<>();
        // 获取效验错误结果
        result.getFieldErrors().forEach((item) -> {
            // 获取到错误提示
            String message = item.getDefaultMessage();
            // 获取错误的属性的名字
            String field = item.getField();
            map.put(field, message);
        });
        return map;
    }
}
