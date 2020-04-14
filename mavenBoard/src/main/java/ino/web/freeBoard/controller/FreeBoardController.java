package ino.web.freeBoard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.set.SynchronizedSortedSet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.commonCode.service.CommCodeService;
import ino.web.freeBoard.common.util.PageMaker;
import ino.web.freeBoard.service.FreeBoardService;


@Controller
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;
	
	@Autowired
	private CommCodeService commCodeService;
	

	@RequestMapping("/main.ino")
	public String main(HttpServletRequest request, @RequestParam(defaultValue = "1") int curPage) {
			
		Map<String,Object> map = new HashMap();
	
		String searchType = request.getParameter("searchType")==null ? "" :request.getParameter("searchType");
		String keyword1 =request.getParameter("keyword1")==null ? "" :request.getParameter("keyword1");
		String day1 =request.getParameter("day1")==null ? "" :request.getParameter("day1");
		String day2 =request.getParameter("day2")==null ? "" :request.getParameter("day2");
		
		map.put("curPage", curPage);
		map.put("searchType", searchType);
		map.put("keyword1", keyword1);
		map.put("day1", day1);
		map.put("day2", day2);
		map.put("listCount", freeBoardService.main(map).get("listCount"));
		map.put("sno", freeBoardService.main(map).get("sno"));
		map.put("eno", freeBoardService.main(map).get("eno"));
		map.put("pageMaker",freeBoardService.main(map).get("pageMaker"));

		List<Map<String,Object>> list = freeBoardService.mainList(map);
	
		map.put("code", "COM001");
		List<Map<String, Object>> dname = commCodeService.dcodeName(map);

		map.put("code", "COM002");
		List<Map<String,Object>> dname2 = commCodeService.dcodeName(map);
	
		request.setAttribute("listCount", freeBoardService.main(map).get("listCount"));
		request.setAttribute("freeBoardList", list);
		request.setAttribute("dname2", dname2);
		request.setAttribute("dname", dname);
		request.setAttribute("map", map);
		request.setAttribute("pageMaker",freeBoardService.main(map).get("pageMaker"));


		return "boardMain";
	}

	@RequestMapping("/search.ino")
	@ResponseBody
	public Map<String,Object> search(HttpServletRequest request,
			@RequestParam(defaultValue = "1") int curPage ) {
		 
		Map<String, Object> map = new HashMap<String, Object>();

		String searchType = request.getParameter("searchType")==null ? "" :request.getParameter("searchType");
		String keyword1 =request.getParameter("keyword1")==null ? "" :request.getParameter("keyword1");
		String day1 =request.getParameter("day1")==null ? "" :request.getParameter("day1");
		String day2 =request.getParameter("day2")==null ? "" :request.getParameter("day2");
		
		day1 = day1.replaceAll("-", "");
		day2 = day2.replaceAll("-", "");

		map.put("searchType", searchType);
		map.put("keyword1", keyword1);
		map.put("day1", day1);
		map.put("day2", day2);
		map.put("curPage", curPage);
		map.put("listCount", freeBoardService.search(map).get("listCount"));
		map.put("sno", freeBoardService.search(map).get("sno"));
		map.put("eno", freeBoardService.search(map).get("eno"));
		map.put("pageMaker",freeBoardService.search(map).get("pageMaker"));
		
		map = freeBoardService.search(map);

		List<Map<String, Object>> list = freeBoardService.mainList(map);

		map.put("list", list);
		
		request.setAttribute("map", map);
		request.setAttribute("list", list);
		request.setAttribute("listCount", freeBoardService.main(map).get("listCount"));
		request.setAttribute("pageMaker",freeBoardService.main(map).get("pageMaker"));
		
		return map;
	}


	@RequestMapping("/insert.ino")
	@ResponseBody
	public int Insert(HttpServletRequest request, Map<String, Object> map) {
	
			String num = request.getParameter("num")==null ? "" :request.getParameter("num");
			String name = request.getParameter("name")==null ? "" :request.getParameter("name");
			String title = request.getParameter("title")==null ? "" :request.getParameter("title");
			String content = request.getParameter("content")==null ? "" :request.getParameter("content");
			String regdate = request.getParameter("regdate")==null ? "" :request.getParameter("regdate");
			int result = 0;
	
			map.put("num", num);
			map.put("name", name);
			map.put("title", title);
			map.put("content", content);
			map.put("regdate", regdate);
			map.put("result", result);
			
			freeBoardService.Insert(map);
			
			int confirm = (int)map.get("result");
			
			if(confirm==1) {
				
				return 1;
			}else {
				
				return 0;
			}
			
	}

	@RequestMapping("/mod.ino")
	@ResponseBody
	public int Modify(HttpServletRequest request, Map<String, Object> map) {


			String num = request.getParameter("num");
			String name = request.getParameter("name");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String regdate = request.getParameter("regdate");

			map.put("num", num);
			map.put("name", name);
			map.put("title", title);
			map.put("content", content);
			map.put("regdate", regdate);
			map.put("result", 0);
			
			freeBoardService.Modify(map);
	
			int confirm = (int)map.get("result");
			
			if(confirm==1) {
				
				return 1;
			}else {
				
				return 0;
			}
		
	}

	@RequestMapping("/del.ino")
	@ResponseBody
	public int del(HttpServletRequest request, int num) {
		
		try {

			freeBoardService.del(num);

		} catch (Exception e) {

			return 0;
		}
		
		return 1;		
	}

	@RequestMapping("/freeBoardInsert.ino")
	public String freeBoardInsert() {

		return "freeBoardInsert";
	}

	@RequestMapping("/freeBoardInsertPro.ino")
	public String freeBoardInsertPro(HttpServletRequest request, Map<String, Object> map) {

		return "redirect:/main.ino";
	}

	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request, int num) {
		
		ModelAndView mav = new ModelAndView();

		Map<String, Object> map = freeBoardService.freeBoardDetail(num);

		mav.setViewName("freeBoardDetail");

		mav.addObject("map", map);

		return mav;
	}

	@RequestMapping("/freeBoardModify.ino")
	public String freeBoardModify(HttpServletRequest request, Map<String, Object> map) {

		return "redirect:/main.ino";
	}

	@RequestMapping("/freeBoardDelete.ino")
	public String FreeBoardDelete(int num) {

		return "redirect:/main.ino";
	}

}
