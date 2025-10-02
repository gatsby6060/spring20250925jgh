package com.example.test1.mapper;


import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;

@Mapper
public interface MemberMapper {
	//로그인
	Member memberLogin(HashMap<String, Object> map);
	
	//아이디 체크
	Member memberCheck(HashMap<String, Object> map);

	//회원저장(가입)
	int memberAdd(HashMap<String, Object> map);

	//첨부파일(이미지) 업로드 일단여기까지 251002 1837
	int insertMemberImg(HashMap<String, Object> map);
}
