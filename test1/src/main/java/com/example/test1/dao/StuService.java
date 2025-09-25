package com.example.test1.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.test1.mapper.StuMapper;
import com.example.test1.model.Student;


@Service
public class StuService {
	
	@Autowired
	StuMapper stuMapper;
	
	public HashMap<String, Object> stuInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("service => " + map);
		Student stu = stuMapper.stuInfo(map);
		if(stu != null) {
			System.out.println("^o^--^-^--^o^--^-^--^o^");
			System.out.println(stu.getStuNo());
			System.out.println(stu.getStuName());
			System.out.println(stu.getStuDept());
		}
		return resultMap;
	}
}
