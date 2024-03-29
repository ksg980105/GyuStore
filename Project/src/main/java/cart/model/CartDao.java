package cart.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("CartDao")
public class CartDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "cart.CartBean";
	
	public CartDao() {
		
	}

	public void insertCart(CartBean cartBean) {
        sqlSessionTemplate.insert(namespace + ".insertCart", cartBean);
    }

	public List<CartBean> getUserList(String member_id) {
		List<CartBean> cartList = sqlSessionTemplate.selectList(namespace + ".getUserList", member_id);
		return cartList;
	}

	public void deleteCart(String member_id) {
		sqlSessionTemplate.delete(namespace + ".deleteCart", member_id);
	}

	public CartBean getUser(String member_id) {
		CartBean cartBean = sqlSessionTemplate.selectOne(namespace + ".getUser", member_id);
		return cartBean;
	}

	public CartBean getProduct(String pname) {
		CartBean cartBean = sqlSessionTemplate.selectOne(namespace + ".getProduct", pname);
		return cartBean;
	}

	public void updateProductPqty(Map<String, Object> map) {
		sqlSessionTemplate.update(namespace + ".updateProductPqty", map);
	}

	public void deleteAll() {
		sqlSessionTemplate.delete(namespace + ".deleteAll");
	}

	public CartBean getCartByUserAndProduct(String member_id, String product_name) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		map.put("product_name", product_name);
		CartBean cartBean = sqlSessionTemplate.selectOne(namespace + ".getCartByUserAndProduct", map);
		return cartBean;
	}

}
