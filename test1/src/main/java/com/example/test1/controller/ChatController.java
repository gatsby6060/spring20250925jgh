package com.example.test1.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.test1.dao.ChatService;
import com.example.test1.model.ChatMessage;

@Controller
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
    @MessageMapping("/sendMessage") // 클라이언트에서 "/app/sendMessage"로 요청 시 실행
    @SendTo("/topic/public") // 메시지를 "/topic/public"을 구독하는 모든 사용자에게 전송
    public ChatMessage sendMessage(ChatMessage message) {
        System.out.println("Received message: " + message.getMessage()); // 로그 확인
        
        // DB에 메시지 저장
        try {
            String senderId = message.getSenderId() != null ? message.getSenderId() : message.getSender();
            Long chatroomNo = message.getChatroomNo() != null ? message.getChatroomNo() : 1L; // 기본 채팅방 번호
            
            chatService.saveChatMessage(senderId, message.getMessage(), chatroomNo);
            System.out.println("Chat message saved to database: " + senderId + " - " + message.getMessage());
        } catch (Exception e) {
            System.err.println("Failed to save chat message to database: " + e.getMessage());
            e.printStackTrace();
        }
        
        return message;
    }
    
	@RequestMapping("/jghchatbot.do") 
    public String list(Model model) throws Exception{

        return "/jghchatbot"; //
    }
    
	@RequestMapping("/togetherchat.do") 
    public String togetherchat(Model model) throws Exception{

        return "/togetherchat"; //
    }
	
}
