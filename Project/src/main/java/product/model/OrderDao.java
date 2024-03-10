package product.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("OrderDao")
public class OrderDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "product.OrderBean";
	
	public OrderDao() {
		
	}

	public void insertOrder(OrderBean orderBean) {
		sqlSessionTemplate.insert(namespace + ".insertOrder", orderBean);
		
	}

	public OrderBean getRecentOrder(String email) {
		OrderBean orderBean = sqlSessionTemplate.selectOne(namespace + ".getRecentOrder", email);
		return orderBean;
	}
}
