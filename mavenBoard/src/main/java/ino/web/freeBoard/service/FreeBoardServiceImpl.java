package ino.web.freeBoard.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ino.web.freeBoard.common.util.PageMaker;
import ino.web.freeBoard.mapper.FreeBoardDao;

 
@Service
public class FreeBoardServiceImpl implements FreeBoardService{

	@Autowired
	private FreeBoardDao FreeBoardDao;
	
	@Override
	public Map<String, Object> main(Map<String, Object> map) {
			
		int listCount = FreeBoardDao.total(map);
		
		int curPage =  (int) map.get("curPage");
		
		PageMaker pageMaker = null;
		 
		pageMaker = new PageMaker(listCount, curPage);

		int sno = pageMaker.getPageBegin();
		int eno = pageMaker.getPageEnd();
					
		map.put("sno", sno);
		map.put("eno", eno);
		map.put("pageMaker", pageMaker);

		return map;
	}

	@Override
	public Map<String, Object> search(Map<String,Object> map){
		
		int listCount = FreeBoardDao.total(map);
		
		int curPage =  (int) map.get("curPage");
		
		PageMaker pageMaker = null;
		 
		pageMaker = new PageMaker(listCount, curPage);

		int sno = pageMaker.getPageBegin();
		int eno = pageMaker.getPageEnd();
					
		map.put("sno", sno);
		map.put("eno", eno);
		map.put("pageMaker", pageMaker);
		
		return map;
	}
	
	@Override
	public Map<String,Object> Insert(Map<String, Object> map) {
		System.out.println(map);
		Map<String,Object> kk = new HashMap();
		
		kk = FreeBoardDao.merge(map);
		
		return kk;
	}
	
	@Override
	public Map<String,Object> Modify(Map<String, Object> map) {
		
		Map<String,Object> kk = new HashMap();
		
		kk= FreeBoardDao.merge(map);
		
		return kk;
	}
	
	@Override
	public void del(int num) {
		
		FreeBoardDao.FreeBoardDelete(num);
	}
	
	@Override
	public String freeBoardInsert() {
		
		return "freeBoardInsertPro";
	}
	
	@Override
	public void freeBoardInsertPro(Map<String, Object> map) {
		
		FreeBoardDao.freeBoardInsertPro(map);
	}
	
	@Override
	public Map<String,Object> freeBoardDetail(int num) {
		
		return FreeBoardDao.getDetailByNum(num);
	}
	
	@Override
	public String freeBoardModify(Map<String, Object> map) {
		
		
		return "redirect:/main.ino";
	}
	
	@Override
	public String FreeBoardDelete(int num){
		
		return "redirect:/main.ino";
	}
	
	@Override
	public List<Map<String, Object>> mainList(Map<String, Object> map){

		return  FreeBoardDao.freeBoardList(map);
	}

	@Override
	public int listCount(Map<String, Object> map) {
		
		return FreeBoardDao.total(map);
	}

	


}	
