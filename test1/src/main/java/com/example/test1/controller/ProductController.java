package com.example.test1.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.test1.dao.ProductService;
import com.example.test1.dao.StuService;
import com.google.gson.Gson;

@Controller
public class ProductController {
	
	@Autowired
	ProductService productService; //
	

	@RequestMapping("/product.do") 
    public String product(Model model) throws Exception{
		
        return "/product";
    }
	
	@RequestMapping("/product/add.do") 
    public String productadd(Model model) throws Exception{
		System.out.println("/product/add.do진입~");
        return "/product/add";
    }
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/product/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
    public String productlistdox(Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		System.out.println("/product/list.dox진입~");
		System.out.println("map은 " + map);
		System.out.println("------------------------------ ");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.getProductList(map);
		
        return new Gson().toJson(resultMap);
    }
	
	
	@RequestMapping(value = "/product/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
    public String productadd(Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		System.out.println("/product/add.dox진입~");
		System.out.println("서버에 도착한 map은 " + map);
		System.out.println("------------------------------ ");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.addProduct(map);
        return new Gson().toJson(resultMap);
    }
	
	
	
	
//	@RequestMapping(value = "/product/search.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
//	@ResponseBody
//    public String productsearchdox(Model model, @RequestParam HashMap<String, Object> map) throws Exception{
//		System.out.println("/product/search.dox진입~");
//		System.out.println("map은 " + map);
//		System.out.println("------------------------------ ");
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		resultMap = productService.getProductList(map);
//		
//        return new Gson().toJson(resultMap);
//    }
	
//	@RequestMapping(value = "/product/TopKindClick.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
//	@ResponseBody
//    public String producttopkinddox(Model model, @RequestParam HashMap<String, Object> map) throws Exception{
//		System.out.println("/product/TopKindClick.dox진입~");
//		System.out.println("map은 " + map);
//		System.out.println("------------------------------ ");
//		HashMap<String, Object> resultMap = new HashMap<String, Object>();
////		resultMap = productService.getProductTopClick(map);
//		
//        return new Gson().toJson(resultMap);
//    }
	
}
