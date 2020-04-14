package ino.web.freeBoard.mapper;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FreeBoardDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	public List<Map<String, Object>> freeBoardList(Map<String, Object> map) {

		return sqlSessionTemplate.selectList("freeBoardGetList", map);
	}

	
	public void freeBoardInsertPro(Map<String, Object> map) {
		sqlSessionTemplate.insert("freeBoardInsertPro", map);
	}
	
	
	public Map<String, Object> getDetailByNum(int num) {
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}

	
	public int getNewNum() { 
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}

	
	public void freeBoardModify(Map<String, Object> map) {
		sqlSessionTemplate.update("freeBoardModify", map);
	}

	
	public void FreeBoardDelete(int num) {
		sqlSessionTemplate.delete("freeBoardDelete", num);

	}
	
	public int total(Map<String, Object> map) {
		return sqlSessionTemplate.selectOne("total", map);
	}
	
	public Map<String,Object> merge(Map<String,Object> map) {
		return sqlSessionTemplate.selectOne("merge", map);
	}
	
}
