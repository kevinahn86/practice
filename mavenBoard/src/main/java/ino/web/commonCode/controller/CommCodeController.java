package ino.web.commonCode.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.commonCode.service.CommCodeService;

@Controller
public class CommCodeController {

	@Autowired 
	public CommCodeService commCodeService;
	
	@Autowired
	PlatformTransactionManager transactionManager;

	public void setTransactionManager(PlatformTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}
	
	@RequestMapping("/commonCode.ino")
	public ModelAndView commonCode(HttpServletRequest request){
		
		ModelAndView mav = new ModelAndView();


		List<HashMap<String,Object>> list = commCodeService.selectCommonCode();
		
		mav.addObject("list" , list); 
		mav.setViewName("commonCodeMain");
		
		return mav;
	}
	
	@RequestMapping("/commonCodeDetail.ino")
	public ModelAndView detail(HttpServletRequest request){
		String code = request.getParameter("code")==null ? "" :request.getParameter("code");
		
		ModelAndView mav = new ModelAndView();
		
		Map<String,Object> map = new HashMap();
		
		map.put("code", code);

		List<Map<String,Object>> list = commCodeService.detail(map);
	
		mav.setViewName("commonCodedetail");
		mav.addObject("list",list);
		mav.addObject("map",map);

		return mav;
	}

	@RequestMapping(value="/create.ino")
	@ResponseBody
	public Map<String,Object> create(HttpServletRequest request,
			@RequestBody String result)  {

		String [] sresult = result.split("&flag=flag&");

		int confirm = 0;
		
		Map<String,Object> resultmap = new HashMap<String,Object>();
		Map<String,Object> resultmap2 = new HashMap<String,Object>();
		Map<String,Object> resultmap3 = new HashMap<String,Object>();
		List<Map<String,String>> list = new ArrayList<Map<String,String>>();
		List<Map<String,String>> list2 = new ArrayList<Map<String,String>>();
		List<Map<String,String>> list3 = new ArrayList<Map<String,String>>();

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

			 if(map.get("code")!=null) {
				 
				 list.add(map);
				 
				 resultmap.put("code", map.get("code"));
				 resultmap.put("dcode", map.get("dcode"));
				 confirm += commCodeService.count(resultmap);
				 
			 }else if(map.get("code")==null && map.get("modify")!=null){
				 
				 list2.add(map);


			 }else if(map.get("code")==null && map.get("delete")!=null) {
				 
				 list3.add(map);

			 }

			 System.out.println("삭제할리스트"+list3);
			 System.out.println("수정할리스트"+list2);
			 System.out.println("삽입할리스트"+list);

		}
		


		DefaultTransactionDefinition def = 
				new DefaultTransactionDefinition(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
		TransactionStatus status = transactionManager.getTransaction(def);
		
		
		try {

	
			if(confirm==0 && list.size()!=0) {

			commCodeService.insert(list); 

			resultmap.put("confirm", confirm);
			System.out.println("1");
			} 

			if(confirm==0 && list2.size()!=0) {
				
			commCodeService.modify(list2);

			resultmap2.put("dcode", list2.get(0).get("dcode"));
			
			String concode = commCodeService.modifylist(resultmap2);

			resultmap.put("confirm", confirm);
			resultmap.put("code", concode);

			System.out.println("2");
			}
			
			if(confirm==0 && list3.size()!=0) {

			resultmap3.put("dcode", list3.get(0).get("dcode"));	

			String concode = commCodeService.deletelist(resultmap3);
	
			commCodeService.delete(list3);

			resultmap.put("confirm", confirm);
			resultmap.put("code", concode);

			System.out.println("3");
			}

			
			
		}catch(Exception e) {
			
			confirm = 0;
			transactionManager.rollback(status);

			if(list2.size()!=0) {
				
			resultmap2.put("dcode", list2.get(0).get("dcode"));
			String concode = commCodeService.modifylist(resultmap2);
			resultmap.put("code", concode);
			
			}

			resultmap.put("error", 1);
			resultmap.put("confirm", confirm);
			
			return resultmap;
		}

		transactionManager.commit(status);

		return resultmap;
	}


	
}

