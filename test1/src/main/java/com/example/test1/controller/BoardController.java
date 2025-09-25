package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.BoardService;
import com.example.test1.dao.StuService;
import com.example.test1.dao.UserService;
import com.google.gson.Gson;


@Controller
public class BoardController {
	// stu-list.do 주소 생성해서 http://localhost:8080/stu-list.do로 접속하면
	// sut-list.jsp 생성
	// stu-list.jsp 파일로 연결
	
	@Autowired
	BoardService boardService;
	
	@RequestMapping("/board-list.do") 
    public String login(Model model) throws Exception{

        return "/board-list";
    }
	
	@RequestMapping(value = "/board-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.getBoardList(map);
		
		return new Gson().toJson(resultMap);
	}
	
    @RequestMapping(value = "/board-del.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String boardDel(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        int boardNo = Integer.parseInt(String.valueOf(map.get("boardNo")));
        int delCnt = boardService.delBoardNo(boardNo);
        System.out.println("delCnt는 " + delCnt);
        resultMap.put("result", "success");
        resultMap.put("affected", delCnt);
        
        return new Gson().toJson(resultMap);
    }
	
	
}
