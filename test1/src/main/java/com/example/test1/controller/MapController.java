package com.example.test1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MapController {
	
	@RequestMapping("/map.do") 
    public String map(Model model) throws Exception{
        return "/map/map1";
    }
	
	@RequestMapping("/map2.do") 
    public String map2(Model model) throws Exception{
        return "/map/map2";
    }
	
	@RequestMapping("/mapjgh.do")  //테스트용
    public String mapjgh(Model model) throws Exception{
        return "/map/mapjgh";
    }
	
	@RequestMapping("/mapjghslide.do")  //테스트용
    public String mapjghslide(Model model) throws Exception{
        return "/map/mapjghslide";
    }
	
	@RequestMapping("/mapjghcalenda.do")  //테스트용
    public String mapjghcalenda(Model model) throws Exception{
        return "/map/mapjghcalenda";
    }
}
