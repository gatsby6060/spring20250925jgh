package com.example.test1.model;

import lombok.Data;

@Data
public class Product {
	
	private int foodNo;
	private String foodName;
	private int price;
	private String foodKind;
	private String foodInfo;
	private String sellYn;
	private String menuNo;
	private String menuPart;
	
	private String foodFileNo;
//	private String foodNo;
	private String filePath;
	private String fileName;	
	private String fileOrgName;
	private String fileSize;
	private String fileEtc;
	private String thumbnailYn;

}
