package com.example.test1.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.example.test1.model.ChatRequest;
import com.example.test1.model.ChatResponse;
import com.example.test1.model.ChatResponse.Candidate;
import com.example.test1.model.ChatResponse.Content;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class GeminiService {
	@Qualifier("geminiRestTemplate")
    @Autowired
    private RestTemplate restTemplate;

//    @Value("${gemini.api.url}")
    @Value("${GEMINI_URL}")
    private String apiUrl;

//    @Value("${gemini.api.key}")
    @Value("${GEMINI_KEY}")
    private String geminiApiKey;

    /*//jgh251021 집에서 원본 주석처리
    public String getContents(String prompt) {

        // Gemini에 요청 전송
        String requestUrl = apiUrl + "?key=" + geminiApiKey;

        ChatRequest request = new ChatRequest(prompt);
        ChatResponse response = restTemplate.postForObject(requestUrl, request, ChatResponse.class);

        String message = response.getCandidates().get(0).getContent().getParts().get(0).getText().toString();

        return message;
    }
    */
    public String getContents(String prompt) {

        // Gemini에 요청 전송
        String requestUrl = apiUrl + "?key=" + geminiApiKey;

        ChatRequest request = new ChatRequest(prompt);
        ChatResponse response = restTemplate.postForObject(requestUrl, request, ChatResponse.class);

     // 1. 응답 후보(Candidates) 리스트가 비었는지 확인
        if (response == null || response.getCandidates() == null || response.getCandidates().isEmpty()) {
            // 안전 필터링 또는 내부 오류 가능성
            return "죄송해요. 응답을 받을 수 없었습니다. 다른 질문을 해주시겠어요? (Candidates가 비어있음)";
        }

        // 2. 첫 번째 후보(Candidate)를 가져옴
        Candidate candidate = response.getCandidates().get(0);
        
        // 3. 내용(Content)이 있는지 확인
        Content content = candidate.getContent();
        if (content == null || content.getParts() == null || content.getParts().isEmpty()) {
            // 응답 텍스트가 아닌 다른 이유로 메시지가 생성되었을 수 있음 (예: Function Call)
            return "죄송해요. 응답의 내용을 찾을 수 없습니다. (Content/Parts가 비어있음)";
        }

        // 4. 파트(Part)에서 텍스트를 추출하고 null 체크
        String message = content.getParts().get(0).getText();

        if (message == null) {
            // Text 필드가 비어있음
            return "죄송해요. 텍스트 응답이 비어있습니다.";
        }

        return message;
    }
}
