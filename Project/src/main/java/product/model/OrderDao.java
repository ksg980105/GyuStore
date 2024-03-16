package product.model;

import java.util.List;

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

	public List<OrderBean> getAllOrder(String email) {
		List<OrderBean> orderList = sqlSessionTemplate.selectList(namespace + ".getAllOrder", email);
		return orderList;
	}
}
