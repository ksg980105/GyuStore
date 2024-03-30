package review.model;

import java.util.List;

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

	public List<ReviewBean> getAllReviewByPnum(int pnum) {
		List<ReviewBean> reviewList = sqlSessionTemplate.selectList(namespace + ".getAllReviewByPnum", pnum);
		return reviewList;
	}
	
}
