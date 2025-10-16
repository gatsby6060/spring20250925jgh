package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.BbsMapper;
import com.example.test1.model.Bbs;
import com.example.test1.model.Board;
import com.example.test1.model.Comment;

@Service
public class BbsService {

	@Autowired // 오토 와이어 안되면....
	BbsMapper bbsMapper; // 컨트롤+shift+o 눌러서 전체 임포트 해보기 안되면....

	public HashMap<String, Object> getBbsList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Bbs> list = bbsMapper.selectBbsList(map);
//		int cnt = BbsMapper.selectBbsList(map);

		resultMap.put("list", list);
//		resultMap.put("cnt", cnt);
//		resultMap.put("result", "success");

		System.out.println("프론트에 돌려주기전 resultMap에 머가 들었나~?" + resultMap);

		return resultMap;
	}

	public HashMap<String, Object> addBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("서버로 들어온 데이터 확인 addBoard " + map);
		int cnt = bbsMapper.insertBbs(map);

		resultMap.put("bbsNum", map.get("bbsNum"));
		resultMap.put("result", "success");
		return resultMap;

	}

	public HashMap<String, Object> removeBbsList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("서비스에서의 map " + map);
		int cnt = bbsMapper.deleteBbsList(map);

		resultMap.put("cnt", cnt);
		resultMap.put("result", "success");

		return resultMap;
	}

	public HashMap<String, Object> getBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

//		int cnt = bbsMapper.updateCnt(map); // 일단 조회수부터 올리고 아래(상세내용) 보여주기
		Bbs bbs = bbsMapper.selectBbs(map);

//		List<Comment> commentList = bbsMapper.selectCommentList(map);
//
//		List<Board> fileList = bbsMapper.selectFileList(map);

//		System.out.println("서비스에서 fileList에 값 넣기직전 fileList는 " + fileList);
//		resultMap.put("fileList", fileList);
		resultMap.put("info", bbs);
//				System.out.println("서비스에서 commentlist에 값 넣기직전 info는 " + board );
//		resultMap.put("commentList", commentList);
		resultMap.put("result", "success");
		return resultMap;
	}

	public HashMap<String, Object> updateBbs(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int info = bbsMapper.updateBbs(map);

		resultMap.put("info", info);
		resultMap.put("result", "success");
		
		return resultMap;
	}

}
