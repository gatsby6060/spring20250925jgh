package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.StuService;
import com.example.test1.dao.UserService;
import com.google.gson.Gson;


@Controller
public class StuController {
	// stu-list.do 주소 생성해서 http://localhost:8080/stu-list.do로 접속하면
	// sut-list.jsp 생성
	// stu-list.jsp 파일로 연결
	
	@Autowired
	StuService stuService;
	
	@RequestMapping("/stu-list.do") 
    public String login(Model model) throws Exception{

        return "/stu-list";
    }

	@RequestMapping(value = "/stu-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
//		resultMap = userService.userLogin(map);
		resultMap = stuService.stuInfo(map);
		
		return new Gson().toJson(resultMap);
	}
	
	
	
	
	
	
	
}
