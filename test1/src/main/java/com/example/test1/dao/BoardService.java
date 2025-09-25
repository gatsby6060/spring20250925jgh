package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.test1.controller.BoardController;
import com.example.test1.mapper.BoaMapper;
import com.example.test1.mapper.StuMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Student;


@Service
public class BoardService {

    private final BoardController boardController;
	
	@Autowired
	BoaMapper boaMapper;


    BoardService(BoardController boardController) {
        this.boardController = boardController;
    }
	
	
	public HashMap<String, Object> getBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Board> list = boaMapper.boaList(map);

		resultMap.put("list", list);
		resultMap.put("result", "success");
		
		return resultMap;
	}
	
	public int delBoardNo(int boardNo) {
		// TODO Auto-generated method stub
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int delno = boaMapper.boaDel(boardNo);
		System.out.println("delno는 "+delno);
//		resultMap.put("list", list);
//		resultMap.put("result", "success");
		
		return delno;
	}
	
	
}
