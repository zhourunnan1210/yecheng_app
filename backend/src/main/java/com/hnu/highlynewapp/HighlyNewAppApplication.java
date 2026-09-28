package com.hnu.highlynewapp;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan("com.hnu.highlynewapp.dao")
@SpringBootApplication
public class HighlyNewAppApplication {
    public static void main(String[] args) {
        SpringApplication.run(HighlyNewAppApplication.class, args);
    }
}
