package com.example.test1.controller;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.test1.dao.BoardService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;

	@RequestMapping("/board-list.do")
	public String login(Model model) throws Exception {

		return "/board-list"; // .jsp빠진형태
	}

	@RequestMapping("/board-add.do")
	public String boardAdd(Model model) throws Exception {

		return "/board-add"; // .jsp빠진형태
	}

	@RequestMapping("/board-view.do")
	public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map)
			throws Exception {
//		System.out.println(map.get("boardNo"));
		request.setAttribute("boardNo", map.get("boardNo"));
		return "/board-view";
	}

	@RequestMapping(value = "/board-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap = boardService.getBoardList(map);

		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "/board-delete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardDelete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap = boardService.removeBoard(map);

		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "/board-add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
//		System.out.println("들어온 map은 "+ map);
		resultMap = boardService.addBoard(map);
//		System.out.println("resultMap은 " + resultMap);
		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "/board-view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		System.out.println("board-view.dox임 들어온 map은 " + map);
		resultMap = boardService.getBoard(map);
		System.out.println("board-view.dox임 화면에 돌려주기 직전의 resultMap은 " + resultMap.toString());
		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "/comment/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String commentAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap = boardService.addComment(map);

		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "/board/deleteList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deleteList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		System.out.println("/board/deleteList.dox임 들어온 map은 " + map); // 프론트에서 보내줘야 받을수 있음

		String json = map.get("selectItem").toString();
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>() {
		});
		map.put("list", list);

		resultMap = boardService.removeBoardList(map);
		System.out.println("/board/deleteList.dox임 프론트로 되돌려주기 직전 " + resultMap);

		return new Gson().toJson(resultMap);
	}

	// controller
	@RequestMapping("/fileUpload.dox")
	public String result(@RequestParam("file1") MultipartFile multi, @RequestParam("boardNo") int boardNo,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		String url = null;
		String path = "c:\\img";
		try {
//			System.out.println("업로드컨트롤진입");
			// String uploadpath = request.getServletContext().getRealPath(path);
			String uploadpath = path;
			String originFilename = multi.getOriginalFilename();
			String extName = originFilename.substring(originFilename.lastIndexOf("."), originFilename.length());
			long size = multi.getSize();
			String saveFileName = genSaveFileName(extName);

//			System.out.println("uploadpath : " + uploadpath);
			System.out.println("originFilename : " + originFilename);
			System.out.println("extensionName : " + extName);
			System.out.println("size : " + size);
			System.out.println("saveFileName : " + saveFileName);
			String path2 = System.getProperty("user.dir");
			System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img");
			if (!multi.isEmpty()) {
				File file = new File(path2 + "\\src\\main\\webapp\\img", saveFileName);
				multi.transferTo(file);

				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("filename", saveFileName);
				map.put("path", "/img/" + saveFileName);
				map.put("boardNo", boardNo);
				map.put("orgName", originFilename);
				map.put("size", size);
				map.put("ext", extName);

				// insert 쿼리 실행
				boardService.addBoardImg(map);

				model.addAttribute("filename", multi.getOriginalFilename());
				model.addAttribute("uploadPath", file.getAbsolutePath());

				return "redirect:list.do";
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return "redirect:list.do";
	}

	// 현재 시간을 기준으로 파일 이름 생성
	private String genSaveFileName(String extName) {
		String fileName = "";

		Calendar calendar = Calendar.getInstance();
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH);
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += calendar.get(Calendar.MILLISECOND);
		fileName += extName;

		return fileName;
	}

}
