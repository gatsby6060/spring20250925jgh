package com.example.test1.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
//		System.out.println("------------------------------ ");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = productService.getProductList(map);
		System.out.println("resultMap는 " +resultMap);
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
    
    @RequestMapping(value = "/product/fileUpload.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
    public String fileUpload(Model model, @RequestParam MultipartFile file1, @RequestParam String foodNo, HttpServletRequest request) throws Exception{
		System.out.println("/product/fileUpload.dox진입~");
		System.out.println("파일명: " + file1.getOriginalFilename());
		System.out.println("foodNo: " + foodNo);
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			// 파일이 비어있지 않은 경우에만 처리
			if (!file1.isEmpty()) {
				// 파일 저장 경로 설정
				String uploadPath = request.getSession().getServletContext().getRealPath("/") + "upload/";
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					uploadDir.mkdirs();
				}
				
				// 현재 시간을 이용한 고유한 파일명 생성
				Calendar cal = Calendar.getInstance();
				String fileName = cal.getTimeInMillis() + "_" + file1.getOriginalFilename();
				String filePath = uploadPath + fileName;
				
				
				// 파일 저장
				File dest = new File(filePath);
				file1.transferTo(dest);
				
				// 데이터베이스에 파일 정보 저장
				HashMap<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("foodNo", foodNo); // 음식 번호
				fileMap.put("filePath", "/upload/" + fileName); // 웹에서 접근 가능한 경로
				fileMap.put("fileName", fileName);
				fileMap.put("fileOrgName", file1.getOriginalFilename());
				fileMap.put("fileSize", file1.getSize());
				fileMap.put("fileEtc", "");
				
				resultMap = productService.addProductFile(fileMap);
				System.out.println("파일 업로드 성공: " + fileName);
			} else {
				resultMap.put("result", "fail");
				resultMap.put("error", "파일이 선택되지 않았습니다.");
			}
		} catch (Exception e) {
			resultMap.put("result", "fail");
			resultMap.put("error", e.getMessage());
			System.out.println("파일 업로드 오류: " + e.getMessage());
		}
		
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
