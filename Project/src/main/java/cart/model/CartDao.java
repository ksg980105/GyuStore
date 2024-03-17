package cart.model;

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
	
}
