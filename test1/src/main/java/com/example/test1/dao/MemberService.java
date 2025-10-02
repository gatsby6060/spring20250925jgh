package com.example.test1.dao;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.mapper.MemberMapper;
import com.example.test1.model.Member;

@Service
public class MemberService {

 
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpSession session;

	
	public HashMap<String, Object> login(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		Member member = memberMapper.memberLogin(map); // 아이디 패스워드가 map안에 담겨있을꺼임

		String message  =  (member != null) ? "로그인 성공!" : "로그인 실패!";
		String result = (member != null) ? "success" : "fail";
		
		if(member != null) {
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionName", member.getName());
			session.setAttribute("sessionStatus", member.getStatus());
		}
		
		resultMap.put("msg", message);
		resultMap.put("result", result);
		
		return resultMap;
	}
	
	
	public HashMap<String, Object> check(HashMap<String, Object> map){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		Member member = memberMapper.memberCheck(map); // 아이디 패스워드가 map안에 담겨있을꺼임

//		String message  =  (member != null) ? "이미 사용중인 아이디입니다" : "사용 가능한 아이디입니다.";
		String result = (member != null) ? "true" : "false";
		
//		resultMap.put("msg", message);
		resultMap.put("result", result);
		
		return resultMap;
	}


	public HashMap<String, Object> logout(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//세션정보 삭제하는 방법은
		// 1개씩 키값을 이용해 삭제하거나 전체를 한번에 삭제
		String message = session.getAttribute("sessionName")+ "님 로그아웃 되었습니다.";
		resultMap.put("msg", message);
		
//		session.removeAttribute("sessionId"); //1개씩 삭제방식
		
		session.invalidate(); //세션 정보 전체 삭제
		
		return null;
	}


	public HashMap<String, Object> memberInsert(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		int cnt = memberMapper.memberAdd(map); // 아이디 패스워드가 map안에 담겨있을꺼임
		
		if(cnt<1) {
			resultMap.put("result", "fail");
		} else {
			resultMap.put("userId", map.get("userId"));
			resultMap.put("result", "success");
		}
		
//		resultMap.put("msg", message);
//		resultMap.put("result", result);
		
		return resultMap;
	}


	public void addMemberImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		int cnt = memberMapper.insertMemberImg(map);
	}
}
