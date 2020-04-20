package ino.web.admin.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class adminService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<Map<String,Object>> grplist(){
		
		return sqlSessionTemplate.selectList("grplist");
	}
	
	public List<Map<String,Object>> objlist(){
		
		return sqlSessionTemplate.selectList("objlist");
	}
	
	public List<Map<String,Object>> uselist(Map<String,Object> map){
		
		return sqlSessionTemplate.selectList("uselist", map);
	}
	
	public void admininsert(List<Map<String,String>> list){
	 	
		sqlSessionTemplate.insert("admininsert",list);
	}
	
	public void admindelete(List<Map<String,String>> list){
	 	
		sqlSessionTemplate.delete("admindelete",list);
	}

	public String grpnamelist(Map<String,Object> map) {
		
		return sqlSessionTemplate.selectOne("grpnamelist",map);
	}
	
	public int countobjid(Map<String,Object> map) {
		
		return sqlSessionTemplate.selectOne("countobj",map);
	}
	
	public int loginCheck(Map<String,Object> map) {
		
		return sqlSessionTemplate.selectOne("loginCheck",map);
	}
	
	public String findgrpid(Map<String,Object> map) {
		
		return sqlSessionTemplate.selectOne("findgrpid",map);
	}
	
	public String findhighobj(Map<String,Object> map) {
		
		return sqlSessionTemplate.selectOne("findhighobj",map);
	}
	
	public String findobjid(Map<String,Object> map) {
		
		return sqlSessionTemplate.selectOne("findobjid",map);
	}
	
	public List<Map<String,Object>> menulist(Map<String,Object> map) {
		
		return sqlSessionTemplate.selectList("menulist",map);
	}
	
	public List<Map<String,Object>> treelist(Map<String,Object> map) {
		
		return sqlSessionTemplate.selectList("treelist",map);
	}
	
	public List<Map<String,Object>> parent(Map<String,Object> map) {
		
		return sqlSessionTemplate.selectList("parent",map);
	}
}
