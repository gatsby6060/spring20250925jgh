package com.example.test1.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.ProductMapper;
import com.example.test1.model.Board;
import com.example.test1.model.Comment;
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

	public HashMap<String, Object> addFood(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("서비스파일에서의 map값" + map);

		try {
			int cnt = productMapper.insertFood(map);
			// map변수에는 갈때도 값이 있고 xml쿼리문에서 설정하면 올때도 값이 들어온다
			resultMap.put("foodNo", map.get("foodNo")); // 돌아온 map에서 get함수로 foodNo값을 뽑아온다.
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}

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

	public HashMap<String, Object> getMenuList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			List<Menu> menuList = productMapper.selectMenuList(map);

			resultMap.put("menuList", menuList);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}

		return resultMap;
	}

	public HashMap<String, Object> addFoodImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub

		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			int cnt = productMapper.insertFoodImg(map);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
			System.out.println(e.getMessage());
		}

		return resultMap;

	}

	public HashMap<String, Object> getFood(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			Product info = productMapper.selectFood(map);

			System.out.println("서비스에서 fileList에 값 넣기직전 fileList는 " + map);

			resultMap.put("info", info);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
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
