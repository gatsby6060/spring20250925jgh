package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

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

	/*
	public HashMap<String, Object> login(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		Member member = memberMapper.memberCheck(map); // 아이디가 있나 확인
//		String message  =  (member != null) ? "로그인 성공!" : "로그인 실패!";
//		System.out.println("엠버서비스의 member임: " + member);
		String message = (member != null) ? " " : "아이디가 존재하지 않습니다.";
		if (member == null) {
			String result = (member != null) ? " " : "fail";
			resultMap.put("msg", message);
			resultMap.put("result", result);
			return resultMap;
		}
		
		member = memberMapper.memberLogin(map); // 아이디 패스워드가 map안에 담겨있을꺼임
		message = (member != null) ? "로그인 성공!" : "패스워드를 확인해주세요";

		String result = (member != null) ? "success" : "fail";

		if (member != null) {
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionName", member.getName());
			session.setAttribute("sessionStatus", member.getStatus());
		}

		resultMap.put("msg", message);
		resultMap.put("result", result);

		return resultMap;
	}
	*/
	
	public HashMap<String, Object> login(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		Member member = memberMapper.memberLogin(map); // 아이디 패스워드가 map안에 담겨있을꺼임
		String message = "";
		String result = "";
//		String message = (member != null) ? "로그인 성공!" : "패스워드를 확인해주세요";
//		String result  =  (member != null) ? "success" : "fail";
		
		if(member !=  null && member.getCnt() >= 5) {
			message = "암호는 맞지만...(비밀번호를 5회이상 잘못입력하셨습니다)";
			result = "fail";
		} else if(member !=  null) {
			//cnt값 0으로 초기화
			memberMapper.cntInit(map);
			message = "로그인 성공!";
			result = "success";
			session.setAttribute("sessionId", member.getUserId());
			session.setAttribute("sessionName", member.getName());
			session.setAttribute("sessionStatus", member.getStatus());
			if(member.getStatus().equals("A")) {
				resultMap.put("url", "/mgr/member/list.do");
			} else {
				resultMap.put("url", "/main.do");
			}
			
		} else {
			Member idCheck = memberMapper.memberCheck(map);
			if(idCheck != null) {
				
				if(idCheck.getCnt() >=5) {
					message = "비밀번호를 5회이상 잘못입력하셨습니다";
				}else {
					//로그인 실패시 cnt 1증가
					memberMapper.cntIncrease(map);
					message = "패스워드를 확인해주세요";
				}
				
		
				
			} else {
				message = "아이디가 존재하지 않습니다.";
			}
		}
		
		resultMap.put("msg", message);
		resultMap.put("result", result);

		return resultMap;
	}
	
	

	public HashMap<String, Object> check(HashMap<String, Object> map) {
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
		// 세션정보 삭제하는 방법은
		// 1개씩 키값을 이용해 삭제하거나 전체를 한번에 삭제
		String message = session.getAttribute("sessionName") + "님 로그아웃 되었습니다.";
		resultMap.put("msg", message);

//		session.removeAttribute("sessionId"); //1개씩 삭제방식

		session.invalidate(); // 세션 정보 전체 삭제

		return resultMap;
	}

	public HashMap<String, Object> memberInsert(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		int cnt = memberMapper.memberAdd(map); // 아이디 패스워드가 map안에 담겨있을꺼임

		if (cnt < 1) {
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



	public HashMap<String, Object> getMemberList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Member> list = memberMapper.selectMemberList(map);
			resultMap.put("list", list);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		
		
//		int cnt = memberMapper.selectMemberCnt(map);
//		resultMap.put("cnt", cnt);
//		System.out.println("프론트에 돌려주기전 멤버관련 resultMap에 머가 들었나~?" + resultMap);
		
		return resultMap;
	}



	public HashMap<String, Object> removeCnt(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			 memberMapper.cntInit(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}
		
		return resultMap;
	}
}
