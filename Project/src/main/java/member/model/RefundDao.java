package member.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("RefundDao")
public class RefundDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "member.RefundBean";

	public RefundDao() {
	
	}

	public void insertRefund(RefundBean refundBean) {
		sqlSessionTemplate.insert(namespace + ".insertRefund", refundBean);
	}
}
