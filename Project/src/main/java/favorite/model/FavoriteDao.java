package favorite.model;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("FavoriteDao")
public class FavoriteDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "favorite.FavoriteBean";
	
	public FavoriteDao() {
		
	}

	public void insertFavorite(Map<String, Object> map) {
		sqlSessionTemplate.insert(namespace + ".insertFavorite", map);
	}

	public int checkFavorite(Map<String, Object> map) {
		System.out.println(map.get("pnum"));
		System.out.println(map.get("member_id"));
		int cnt = sqlSessionTemplate.selectOne(namespace + ".checkFavorite", map);
		System.out.println("daocnt:"+cnt);
		return cnt;
	}
	
}
