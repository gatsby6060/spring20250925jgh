package com.example.test1.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.BbsService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;


@Controller
public class BbsController {

	@Autowired
	BbsService bbsService;

	@RequestMapping("/bbs/list.do")
	public String bbslist(Model model) throws Exception {
		return "/bbs/list"; // .jsp빠진형태
	}
	
	@RequestMapping("/bbs/add.do")
	public String bbsadd(Model model) throws Exception {
		return "/bbs/add"; // .jsp빠진형태
	}
	
	@RequestMapping("/bbs/view.do")
	public String bbsview(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("/bbs/view.do 컨트롤러 도착");
		
		request.setAttribute("bbsNum", map.get("bbsNum"));
		
		return "/bbs/view"; // 
	}
	
	@RequestMapping("/bbs/bbs-update.do")
	public String bbsupdate(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		System.out.println("/bbs/bbs-update.do 컨트롤러 도착");
		
		request.setAttribute("bbsNum", map.get("bbsNum"));
		
		return "/bbs/update"; // 
	}
	
	
		
	
	@RequestMapping(value = "/bbs-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap = bbsService.getBbsList(map);
		System.out.println("프론트에 돌려주기 직전 map " + map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs/bbs-add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		System.out.println("들어온 map은 "+ map);
		resultMap = bbsService.addBbs(map);
//		System.out.println("resultMap은 " + resultMap);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/bbs/deleteList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsdeleteList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		System.out.println("/bbs/deleteList.dox임 들어온 map은 " + map); // 프론트에서 보내줘야 받을수 있음

//		String json = map.get("selectItem").toString();
//		ObjectMapper mapper = new ObjectMapper();
//		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>() {
//		});
//		map.put("list", list);

		resultMap = bbsService.removeBbsList(map);
		System.out.println("/bbs/deleteList.dox임 프론트로 되돌려주기 직전 " + resultMap);

		return new Gson().toJson(resultMap);
	}
	
	
	@RequestMapping(value = "/bbs/bbs-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsview(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("/bbs/bbs-view.dox임 들어온 map은 " + map);
		resultMap = bbsService.getBbs(map);
		System.out.println("/bbs/bbs-view.dox임 화면에 돌려주기 직전의 resultMap은 " + resultMap.toString());
		return new Gson().toJson(resultMap);
	}
	
	
	@RequestMapping(value = "/bbs/bbs-update.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String bbsupdate(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("/bbs/bbs-update.dox임 들어온 map은 "+ map); //프론트에서 보내줘야 받을수 있음
		resultMap = bbsService.updateBbs(map);
		System.out.println("/bbs/bbs-update.dox임 resultMap은 " + resultMap.toString());
		
		return new Gson().toJson(resultMap);
	}
	
}
