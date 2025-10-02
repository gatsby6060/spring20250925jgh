package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.AreaService;
import com.google.gson.Gson;

@Controller
public class AreaController {
	
	@Autowired
	AreaService areaService;
	
	@RequestMapping("/area/list.do")
	public String login(Model model) throws Exception {

		return "/area/area-list"; // .jsp빠진형태
	}
	
	@RequestMapping(value = "/area/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String areaList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("/area/list.dox 호출됨" + map);
	
		resultMap = areaService.getAreaList(map);
		
//		System.out.println("서버에서 보내주는 값 resultMap는 " + resultMap);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/area/si.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String si(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("/area/list.dox 호출됨");
		resultMap = areaService.getSiList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/area/gu.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
		public String gu(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("/area/gu.dox 호출됨 들어온 map은 " + map);
		resultMap = areaService.getGuList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/area/dong.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
		public String dong(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("/area/dong.dox 호출됨 들어온 map은 " + map);
		resultMap = areaService.getDongList(map);
		System.out.println("resultMap은 " + resultMap);
		return new Gson().toJson(resultMap);
	}
	

}
