package ino.web.commonCode.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommCodeService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<HashMap<String, Object>> selectCommonCode() {
		
		return sqlSessionTemplate.selectList("selectCommonCodeList");
	}
	
	public List<Map<String,Object>> dcodeName(Map<String,Object> map){
		
		return sqlSessionTemplate.selectList("dcodeName",map);
	}

	public List<Map<String, Object>> detail(Map<String,Object> map){
		
		return sqlSessionTemplate.selectList("detail",map);
	}
	
	public void insert(List<Map<String,String>> list){
		 	
		sqlSessionTemplate.insert("insert",list);
	}

	public List<Map<String, Object>> insertlist(Map<String, Object> map)  {
		
		return sqlSessionTemplate.selectList("insertlist",map);
	}
	
	public int count(Map<String,Object> map) {
		
		return sqlSessionTemplate.selectOne("count",map);
	}
	
	public void modify(List<Map<String,String>> list) {
		
		sqlSessionTemplate.update("modify", list);
	}

	public String modifylist(Map<String, Object> map){
		
		return sqlSessionTemplate.selectOne("modifylist", map);
	}
	
	public String deletelist(Map<String, Object> map){
		
		return sqlSessionTemplate.selectOne("deletelist", map);
	}
 
	public void delete(List<Map<String,String>> list){
	 	
		sqlSessionTemplate.delete("delete",list);
	}

}
