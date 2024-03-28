package member.model;

import java.util.List;

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

	public RefundBean getAllByOrderId(String order_id) {
		RefundBean refundBean = sqlSessionTemplate.selectOne(namespace + ".getAllByOrderId", order_id);
		return refundBean;
	}

	public List<RefundBean> getAllRefund(int standard_state) {
		List<RefundBean> refundList = sqlSessionTemplate.selectList(namespace + ".getAllRefund", standard_state);
		return refundList;
	}

	public void updateState(String order_id) {
		sqlSessionTemplate.update(namespace + ".updateState", order_id);
	}
}
