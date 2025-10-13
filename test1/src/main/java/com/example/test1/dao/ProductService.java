package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ProductMapper;
import com.example.test1.model.Menu;
import com.example.test1.model.Product;

@Service
public class ProductService {

	@Autowired
	ProductMapper productMapper;

	public HashMap<String, Object> getProductList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			List<Product> list = productMapper.selectProductList(map);
			List<Menu> menuList = productMapper.selectMenuList(map);

			resultMap.put("list", list);
			resultMap.put("menuList", menuList);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}

		return resultMap;
	}

	public HashMap<String, Object> addProduct(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int cnt = productMapper.insertProduct(map);

		resultMap.put("foodNo", map.get("foodNo"));
		resultMap.put("result", "success");
		return resultMap;
	}
	
	public HashMap<String, Object> addProductFile(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int cnt = productMapper.insertProductFile(map);
			resultMap.put("result", "success");
			resultMap.put("cnt", cnt);
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("error", e.getMessage());
			System.out.println(e.getMessage());
		}
		return resultMap;
	}
	
//	public HashMap<String, Object> getProductSearch(HashMap<String, Object> map) {
//		// TODO Auto-generated method stub
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//
//		try {
//			List<Product> list = productMapper.selectProductSearch(map);
//
//			resultMap.put("list", list);
//			resultMap.put("result", "success");
//		} catch (Exception e) {
//			// TODO: handle exception
//			resultMap.put("result", "fail");
//			System.out.println(e.getMessage());
//		}
//
//		return resultMap;
//	}
	
//	public HashMap<String, Object> selectProductList(HashMap<String, Object> map) {
//		// TODO Auto-generated method stub
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//
//		try {
//			List<Product> list = productMapper.selectProductList(map);
//			List<Menu> menuList = productMapper.selectMenuList(map);
//
//			resultMap.put("list", list);
//			resultMap.put("menuList", menuList);
//			resultMap.put("result", "success");
//		} catch (Exception e) {
//			// TODO: handle exception
//			resultMap.put("result", "fail");
//			System.out.println(e.getMessage());
//		}
//
//		return resultMap;
//	}
	
	
	
	
	

//	public HashMap<String, Object> getFoodList(HashMap<String, Object> map) {
//		// TODO Auto-generated method stub
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		List<Product> list = productMapper.foodList(map);
//
//		resultMap.put("list", list);
//		resultMap.put("result", "success");
//		
//		return resultMap;
//	}
//	
//	public HashMap<String, Object> getFoodImgList(HashMap<String, Object> map) {
//		// TODO Auto-generated method stub
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		List<Product> list = productMapper.foodImgList(map);
//
//		resultMap.put("list", list);
//		resultMap.put("result", "success");
//		
//		return resultMap;
//	}

}
