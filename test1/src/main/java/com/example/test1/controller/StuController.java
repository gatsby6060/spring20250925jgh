package com.example.test1.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

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
		
	@RequestMapping("/stu-view.do") 
    public String stuview(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
//		System.out.println("stu컨트롤러 stu-view.do진입");
		System.out.println("여긴 stu-view.do 임 stuNo는 "+map.get("stuNo"));
		request.setAttribute("stuNo", map.get("stuNo"));
        return "/stu-view";
    }

	@RequestMapping("/stu-update.do") 
    public String stuUpdate(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
//		System.out.println("stu컨트롤러 stu-view.do진입");
		System.out.println("여긴 stu-update.do 임 stuNo는 "+map.get("stuNo"));
		request.setAttribute("stuNo", map.get("stuNo"));
        return "/stu-update";
    }
	
	
	
	

	@RequestMapping(value = "/stu-info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String login(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println(map);
//		resultMap = userService.userLogin(map);
		resultMap = stuService.stuInfo(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/stu-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = stuService.getStuList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	
    @RequestMapping(value = "/stu-delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String stuDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = new HashMap<String, Object>();

        resultMap = stuService.removeStudent(map);

        return new Gson().toJson(resultMap);
    }
	
    
	@RequestMapping(value = "/stu-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("stu-view.dox임 들어온 map은 "+ map); //프론트에서 보내줘야 받을수 있음
		resultMap = stuService.getStudent(map);
		System.out.println("stu-view.dox임 resultMap은 " + resultMap.toString());
		
		return new Gson().toJson(resultMap);
	}
    
       
	@RequestMapping(value = "/stu-update.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String stuUpdate(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("stu-update.dox임 들어온 map은 "+ map); //프론트에서 보내줘야 받을수 있음
		resultMap = stuService.updateStudent(map);
		System.out.println("stu-update.dox임 resultMap은 " + resultMap.toString());
		
		return new Gson().toJson(resultMap);
	}
	
	
}
