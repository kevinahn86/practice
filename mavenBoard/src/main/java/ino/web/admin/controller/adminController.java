package ino.web.admin.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.admin.service.adminService;
import ino.web.commonCode.service.CommCodeService;
import ino.web.freeBoard.service.FreeBoardService;

@Controller
public class adminController {
	
	@Autowired
	private FreeBoardService freeBoardService;
	
	@Autowired
	private CommCodeService commCodeService;
	
	@Autowired
	public adminService adminService;
	
	@Autowired
	PlatformTransactionManager transactionManager;
	
	public void setTransactionManager(PlatformTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}
	
	@RequestMapping("/admin.ino")
	public ModelAndView admin(HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();
		
		List<Map<String,Object>> grplist = adminService.grplist();
		
		mav.addObject("grplist", grplist);	

		mav.setViewName("adminlist");

		return mav;
	}
  
	@RequestMapping("/objlist.ino")
	@ResponseBody
	public Map<String,Object> objlist(@RequestBody String result){

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("grpid", result);
			
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();

		String grpname= adminService.grpnamelist(map);
		map.put("grpname", grpname);
		
		list = adminService.objlist();
		map.put("objlist", list);
		
		list = adminService.uselist(map);
		map.put("uselist", list);
		
		
		return map;
	}
	 
	@RequestMapping("/crud.ino")
	@ResponseBody
	public Map<String,Object> crud(@RequestBody String result){

		String [] sresult = result.split("&flag=flag&");
		
		Map<String,Object> rmap = new HashMap<String,Object>();
		List<Map<String,String>> list1 = new ArrayList<Map<String,String>>();
		List<Map<String,String>> list2 = new ArrayList<Map<String,String>>();
		
		for(int a=0;a<sresult.length;++a) {

			String data =  sresult[a];
			
			Map<String, String> map = new HashMap<String, String>();		
			
			 for (String param : data.split("&")) {
			       
				 String pair[] = param.split("=");

				 if (pair.length>1) {
					 
					 String decode1 = pair[0];
					 String decode2 = pair[1];

					 try {
						String params = URLDecoder.decode(decode1,"UTF-8");
						String params2 = URLDecoder.decode(decode2,"UTF-8");
						map.put(params, params2);

						
					 } catch (UnsupportedEncodingException e) {
				
						e.printStackTrace();
					}
					 		
			        }else{
			        	
			         map.put(pair[0], "");

			        }
			  
				 
			 	}
			 	rmap.put("grpid", map.get("grpid"));
			 	rmap.put("grpname", map.get("grpname"));
			 	
			  	if(map.get("ins")!=null && map.get("chk").matches("F")) {
			  		
			  		list1.add(map);
				 
			  	}else if(map.get("del")!=null && map.get("chk").matches("T")) {
				 
			  		list2.add(map);
				 
			  	}
 	  	
			}
		
		String grpname= adminService.grpnamelist(rmap);
		rmap.put("grpname", grpname);


	
		 System.out.println("사용중으로바꿀리스트"+list1);
		 System.out.println("미사용중으로바꿀리스트"+list2);
		
		 
		int count = 0;


		DefaultTransactionDefinition def = 
				new DefaultTransactionDefinition(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
		
				try {
					
					
				if(list1.size()!=0) {
					
					adminService.admininsert(list1);
					System.out.println("insert success");
					rmap.put("ins", 1);
	
				}
					
				if(list2.size()!=0) {
						
					adminService.admindelete(list2);
					System.out.println("delete success");
					rmap.put("del", 1);
	
				}

				}catch(Exception e) {
					e.printStackTrace();
					System.out.println("exception rollback");
					transactionManager.rollback(status);
					
					return rmap;
					
				}
				
		if(list1.size()==0 && list2.size()==0 ) {
			rmap.put("flag", 1);
		}

		transactionManager.commit(status);
		
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		List<Map<String,Object>> list0 = new ArrayList<Map<String,Object>>();

		list = adminService.objlist();
		rmap.put("objlist", list);
		
		list0 = adminService.uselist(rmap);
		rmap.put("uselist", list0);

		return rmap;

	}
	
	@RequestMapping("/login.ino")
	public ModelAndView login(HttpSession session,HttpServletRequest request,HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();

		String userid = request.getParameter("userid");

		Map<String, Object> map = new HashMap<String, Object>();	
		
		map.put("userid", userid);
		
		int flag = adminService.loginCheck(map);
		String grpid = adminService.findgrpid(map);
		map.put("grpid", grpid);
		List<Map<String,Object>> menulist = adminService.menulist(map);
		List<Map<String,Object>> treelist = adminService.treelist(map);
	
	     if(flag==1) {

		     session.setAttribute("userid", map.get("userid"));
		     session.setAttribute("grpid", grpid);
		     
		     mav.addObject("treelist", treelist);
		     mav.addObject("menulist", menulist);
		     mav.addObject("sublist", treelist);
		     mav.addObject("parent", treelist);
		     mav.addObject("parent1", treelist);
		     mav.setViewName("Main");

	     }else {
	    	 mav.setViewName("default");
	     }

		return mav;
	}

	@RequestMapping("/logout.ino")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/noview.ino";	
	}
	
	@RequestMapping("/noview.ino")
	public ModelAndView noview(HttpServletRequest request) {

		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("defaultmain");

		return mav;
	}
	
	@RequestMapping("/OBJ100.ino")
	public String main(HttpSession session, HttpServletRequest request, @RequestParam(defaultValue = "1") int curPage) {
			
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

		String userid = (String)session.getAttribute("userid");

		map.put("userid", userid);
		
		String objid = "OBJ100";
		map.put("objid", objid);

		String grpid = adminService.findgrpid(map);
		map.put("grpid", grpid);

		List<Map<String,Object>> menulist = adminService.menulist(map);
		List<Map<String,Object>> treelist = adminService.treelist(map);

		session.setAttribute("grpid", grpid);
		request.setAttribute("menulist", menulist);
		request.setAttribute("treelist", treelist);
		request.setAttribute("sublist", treelist);
		request.setAttribute("parent", treelist);
		request.setAttribute("parent1", treelist);

		return "boardMain";
	}
	
	@RequestMapping("/OBJ110.ino")
	public ModelAndView commonCode(HttpSession session, HttpServletRequest request){
		
		ModelAndView mav = new ModelAndView();
		

		List<HashMap<String,Object>> list = commCodeService.selectCommonCode();
		
		mav.addObject("list" , list); 
		mav.setViewName("commonCodeMain");
		
		
		Map<String,Object> map = new HashMap<String,Object>();
		String userid = (String)session.getAttribute("userid");

		map.put("userid", userid);
		
		String objid = "OBJ110";
		map.put("objid", objid);
		 
		String grpid = adminService.findgrpid(map);
		map.put("grpid", grpid);
		
		String highobj = adminService.findhighobj(map);
		map.put("high_obj", highobj);
		
		List<Map<String,Object>> menulist = adminService.menulist(map);
		List<Map<String,Object>> treelist = adminService.treelist(map);
		List<Map<String,Object>> parentlist = adminService.parent(map);
		
		session.setAttribute("grpid", grpid);
		request.setAttribute("menulist", menulist);
		request.setAttribute("treelist", treelist);
		request.setAttribute("sublist", treelist);
		request.setAttribute("parent", parentlist);
		request.setAttribute("parent1", parentlist);
		
		return mav;
	}
	
	@RequestMapping("/OBJ111.ino")
	public ModelAndView notice(HttpSession session, HttpServletRequest request){
		
		ModelAndView mav = new ModelAndView();

		mav.setViewName("loginlist");
		
		Map<String,Object> map = new HashMap<String,Object>();
		String userid = (String)session.getAttribute("userid");

		map.put("userid", userid);
		
		String objid = "OBJ111";
		map.put("objid", objid);

		String grpid = adminService.findgrpid(map);
		map.put("grpid", grpid);
		
		String highobj = adminService.findhighobj(map);
		map.put("high_obj", highobj);
		
		List<Map<String,Object>> menulist = adminService.menulist(map);
		List<Map<String,Object>> treelist = adminService.treelist(map);
		List<Map<String,Object>> parentlist = adminService.parent(map);
		session.setAttribute("grpid", grpid);
		request.setAttribute("menulist", menulist);
		request.setAttribute("treelist", treelist);
		request.setAttribute("sublist", treelist);
		request.setAttribute("parent", parentlist);
		request.setAttribute("parent1", treelist);
		
		return mav;
	}
	
	@RequestMapping("/OBJ120.ino")
	public ModelAndView QnA(HttpSession session, HttpServletRequest request){
		
		ModelAndView mav = new ModelAndView();

		mav.setViewName("obj120");
		
		Map<String,Object> map = new HashMap<String,Object>();
		String userid = (String)session.getAttribute("userid");

		map.put("userid", userid);
		
		String objid = "OBJ120";
		map.put("objid", objid);

		String grpid = adminService.findgrpid(map);
		map.put("grpid", grpid);
		
		String highobj = adminService.findhighobj(map);
		map.put("high_obj", highobj);
		
		List<Map<String,Object>> menulist = adminService.menulist(map);
		List<Map<String,Object>> treelist = adminService.treelist(map);
		List<Map<String,Object>> parentlist = adminService.parent(map);
		session.setAttribute("grpid", grpid);
		request.setAttribute("menulist", menulist);
		request.setAttribute("treelist", treelist);
		request.setAttribute("sublist", treelist);
		request.setAttribute("parent", parentlist);
		request.setAttribute("parent1", parentlist);
		
		return mav;
	}
	
	@RequestMapping("/OBJ121.ino")
	public ModelAndView board(HttpSession session, HttpServletRequest request){
		
		ModelAndView mav = new ModelAndView();

		mav.setViewName("obj121");
		
		Map<String,Object> map = new HashMap<String,Object>();
		String userid = (String)session.getAttribute("userid");

		map.put("userid", userid);
		
		String objid = "OBJ121";
		map.put("objid", objid);

		String grpid = adminService.findgrpid(map);
		map.put("grpid", grpid);
		
		String highobj = adminService.findhighobj(map);
		map.put("high_obj", highobj);
		
		List<Map<String,Object>> menulist = adminService.menulist(map);
		List<Map<String,Object>> treelist = adminService.treelist(map);
		List<Map<String,Object>> parentlist = adminService.parent(map);
		session.setAttribute("grpid", grpid);
		request.setAttribute("menulist", menulist);
		request.setAttribute("treelist", treelist);
		request.setAttribute("sublist", treelist);
		request.setAttribute("parent", treelist);
		request.setAttribute("parent1", parentlist);
		
		return mav;
	}
	
	@RequestMapping("/OBJ122.ino")
	public ModelAndView event(HttpSession session, HttpServletRequest request){
		
		ModelAndView mav = new ModelAndView();

		mav.setViewName("obj122");
		
		Map<String,Object> map = new HashMap<String,Object>();
		String userid = (String)session.getAttribute("userid");

		map.put("userid", userid);
			
		String objid = "OBJ122";
		map.put("objid", objid);

		String grpid = adminService.findgrpid(map);
		map.put("grpid", grpid);
		
		String highobj = adminService.findhighobj(map);
		map.put("high_obj", highobj);
		
		List<Map<String,Object>> menulist = adminService.menulist(map);
		List<Map<String,Object>> treelist = adminService.treelist(map);
		List<Map<String,Object>> parentlist = adminService.parent(map);
		session.setAttribute("grpid", grpid);
		request.setAttribute("menulist", menulist);
		request.setAttribute("treelist", treelist);
		request.setAttribute("sublist", treelist);
		request.setAttribute("parent1", parentlist);
		request.setAttribute("parent", treelist);
		
		return mav;
	}
	
}
