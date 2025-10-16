package com.example.test1.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.test1.model.Menu;
import com.example.test1.model.Product;


@Mapper
public interface ProductMapper {
	// 제품 목록
	List<Product> selectProductList(HashMap<String, Object> map);
	
//	List<Product> selectProductSearch(HashMap<String, Object> map);
	
	// 메뉴 목록
	List<Menu> selectMenuList(HashMap<String, Object> map);

	// 음식 추가입력
	int insertProduct(HashMap<String, Object> map);
	
	// 음식제품 등록
	int insertFood(HashMap<String, Object> map);
	
	// 음식 이미지 파일 저장
	int insertProductFile(HashMap<String, Object> map);

	// 음식 이미지 파일 저장2 , 제품 이미지등록
	int insertFoodImg(HashMap<String, Object> map);

	// 음식 1개 모든 상세정보    제품상세정보조회
	Product selectFood(HashMap<String, Object> map);

//	List<Product> foodList(HashMap<String, Object> map);
//	
//	List<Product> foodImgList(HashMap<String, Object> map);
	
	int insertPayHistory(HashMap<String, Object> map);
	
}
