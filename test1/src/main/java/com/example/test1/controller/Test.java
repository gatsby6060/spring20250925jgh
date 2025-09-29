package com.example.test1.controller;

import java.util.Random;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// 랜덤한 숫자6자리(0~9)
		// random(10) 0~9
		// random(100000) 이러면 안댐 350 이렇게나올수도 있음  003500 이렇게 나와야함
		Random ran = new Random();
		String ranStr = "";
		for(int i=0; i<6 ; i++) {
			ran.nextInt(10);
			ranStr += ran.nextInt(10);
		}
		
		System.out.println(ranStr);

		
	}


}
