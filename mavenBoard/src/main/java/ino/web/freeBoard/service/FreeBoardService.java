package ino.web.freeBoard.service;

import java.util.List;
import java.util.Map;


public interface FreeBoardService {

	public Map<String,Object> main(Map<String,Object> map) ;
	
	public Map<String, Object> search(Map<String,Object> map) ;
	
	public Map<String,Object> Insert(Map<String, Object> map);
	
	public Map<String,Object> Modify(Map<String, Object> map);
	
	public void del(int num);
	
	public String freeBoardInsert();
	
	public void freeBoardInsertPro(Map<String, Object> map);
	
	public Map<String,Object> freeBoardDetail(int num);
	
	public String freeBoardModify(Map<String, Object> map);
	
	public String FreeBoardDelete(int num);

	public List<Map<String, Object>> mainList(Map<String, Object> map);

	public int listCount(Map<String, Object> map);

	
	
}
