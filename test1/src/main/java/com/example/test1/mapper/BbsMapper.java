package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Bbs;


@Mapper
public interface BbsMapper {
	
	// 게시글 목록
	List<Bbs> selectBbsList(HashMap<String, Object> map);

	int insertBbs(HashMap<String, Object> map);

	int deleteBbsList(HashMap<String, Object> map);

	Bbs selectBbs(HashMap<String, Object> map);

	int updateBbs(HashMap<String, Object> map);

}
