package board.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component("BoardDao")
public class BoardDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "board.BoardBean";
	
	public BoardDao() {
		
	}

	public int getTotalCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace+".getTotalCount",map);
		return cnt;
	}

	public List<BoardBean> getAllBoard(Map<String, String> map, Paging pageInfo) {
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		List<BoardBean> lists = sqlSessionTemplate.selectList(namespace+".getAllBoard", map, rowbounds);
		
		return lists;
	}

	public int insertBoard(BoardBean boardBean) {
		int cnt = sqlSessionTemplate.insert(namespace + ".insertBoard", boardBean);
		return cnt;
	}

	public BoardBean getBoardByNum(int board_number) {
		BoardBean boardBean = sqlSessionTemplate.selectOne(namespace + ".getBoardByNum", board_number);
		return boardBean;
	}

	public void updateBoard(BoardBean boardBean) {
		sqlSessionTemplate.update(namespace + ".updateBoard", boardBean);
	}

	public void deleteBoard(int board_number) {
		sqlSessionTemplate.delete(namespace + ".deleteBoard", board_number);
	}

}
