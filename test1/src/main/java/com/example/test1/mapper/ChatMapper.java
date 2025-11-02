package com.example.test1.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChatMapper {
	// 채팅 메시지 저장
	int insertChatMessage(HashMap<String, Object> map);
}

