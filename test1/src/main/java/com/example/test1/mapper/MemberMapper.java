package com.example.test1.mapper;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Member;

@Mapper
public interface MemberMapper {
	//로그인
	Member memberLogin(HashMap<String, Object> map);
	
	//아이디 체크
	Member memberCheck(HashMap<String, Object> map);
	
	//아이디 이름 전번체크
	Member memberIdNamePhoneCk(HashMap<String, Object> map);
	

	//회원저장(가입)
	int memberAdd(HashMap<String, Object> map);

	//첨부파일(이미지) 업로드 일단여기까지 251002 1837
	int insertMemberImg(HashMap<String, Object> map);

	//회원 몰록(관리자)
	List<Member> selectMemberList(HashMap<String, Object> map);

	//회원들 총 수
	int selectMemberCnt(HashMap<String, Object> map);
	
	//로그인 성공시 cnt 초기화
	int	cntInit(HashMap<String, Object> map); 
	
	//로그인 실패시 cnt1증가
	int	cntIncrease(HashMap<String, Object> map);

	//(해시화 됨) 암호바꾸기
	int memberPwdUpdate(HashMap<String, Object> map); 
	
	//사용자 인증1(리턴 Member)
	Member authMember1(HashMap<String, Object> map); 
	
	//사용자 인증1(리턴 int)
	int authMember2(HashMap<String, Object> map); 
	
	//비밀번호 변경
	int updatePwd(HashMap<String, Object> map);

	int checkPwd(HashMap<String, Object> map); 

	
}
