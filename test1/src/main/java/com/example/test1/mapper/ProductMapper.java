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
	
	// 음식 이미지 파일 저장
	int insertProductFile(HashMap<String, Object> map);

//	List<Product> foodList(HashMap<String, Object> map);
//	
//	List<Product> foodImgList(HashMap<String, Object> map);
	
}
