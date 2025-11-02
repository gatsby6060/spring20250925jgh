package com.example.test1.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ChatMapper;

@Service
public class ChatService {

	@Autowired
	ChatMapper chatMapper;

	// 채팅 메시지 저장
	public int saveChatMessage(String senderId, String message, Long chatroomNo) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("senderId", senderId);
		map.put("message", message);
		map.put("chatroomNo", chatroomNo != null ? chatroomNo : 1L); // 기본값 1
		
		return chatMapper.insertChatMessage(map);
	}
}

