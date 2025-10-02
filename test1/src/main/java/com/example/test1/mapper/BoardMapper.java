package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Board;
import com.example.test1.model.Comment;

@Mapper
public interface BoardMapper {
	// 게시글 목록
	List<Board> selectBoardList(HashMap<String, Object> map);
	
	//게시글 전체 개수
	int selectBoardCnt(HashMap<String, Object> map);
	
	// 게시글 삭제
	int deleteBoard(HashMap<String, Object> map);

	//게시글 등록
	int insertBoard(HashMap<String, Object> map);

	//게시글 상세보기
	Board selectBoard(HashMap<String, Object> map);
	
	//특정게시글의 댓글가져오기 
	List<Comment> selectCommentList(HashMap<String, Object> map);
	
	//게시글마다의 댓글개수
//	int commentCount(HashMap<String, Object> map);
	
	//댓글 등록
	int insertComment(HashMap<String, Object> map);
	
	//게시글 조회수 증가 +1
	int updateCnt(HashMap<String, Object> map);
	
	//게시글 여러개 삭제 //숫자가 2 3 등 넘어올듯
	int deleteBoardList(HashMap<String, Object> map);

	//첨부파일(이미지) 업로드
	int insertBoardImg(HashMap<String, Object> map);
	
	//첨부파일 목록
	List<Board> selectFileList(HashMap<String, Object> map);
	
	
}
