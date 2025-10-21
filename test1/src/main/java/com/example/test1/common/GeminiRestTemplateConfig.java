package com.example.test1.common;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

import lombok.RequiredArgsConstructor;

//잘 모름 그냥 만들어봄
//챗봇을 위해서 251021
@Configuration
@RequiredArgsConstructor
public class GeminiRestTemplateConfig {
    @Bean
    @Qualifier("geminiRestTemplate")
    public RestTemplate geminiRestTemplate() {
        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getInterceptors().add((request, body, execution) -> execution.execute(request, body));

        return restTemplate;
    }
}
