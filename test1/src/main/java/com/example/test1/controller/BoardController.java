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

import com.example.test1.dao.BoardService;
import com.google.gson.Gson;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;

	@RequestMapping("/board-list.do")
	public String login(Model model) throws Exception {

		return "/board-list"; // .jsp빠진형태
	}
	
	@RequestMapping("/board-add.do")
	public String boardAdd(Model model) throws Exception {

		return "/board-add"; // .jsp빠진형태
	}
	
	@RequestMapping("/board-view.do")
	public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception {
//		System.out.println(map.get("boardNo"));
		request.setAttribute("boardNo", map.get("boardNo"));
		return "/board-view"; 
	}
	
	@RequestMapping(value = "/board-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.getBoardList(map);
		

		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "/board-delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap = boardService.removeBoard(map);

		return new Gson().toJson(resultMap);
	}


	@RequestMapping(value = "/board-add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		System.out.println("들어온 map은 "+ map);
		resultMap = boardService.addBoard(map);
//		System.out.println("resultMap은 " + resultMap);
		return new Gson().toJson(resultMap);
	}
	
	
	@RequestMapping(value = "/board-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("board-view.dox임 들어온 map은 "+ map);
		resultMap = boardService.getBoard(map);
		System.out.println("board-view.dox임 화면에 돌려주기 직전의 resultMap은 " + resultMap.toString());
		return new Gson().toJson(resultMap);
	}

}
