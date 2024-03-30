package review.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("ReviewDao")
public class ReviewDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "review.ReviewBean";
	
	public ReviewDao() {
		
	}

	public void insertReview(ReviewBean reviewBean) {
		sqlSessionTemplate.insert(namespace + ".insertReview", reviewBean);
	}
	
}
