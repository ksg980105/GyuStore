package product.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("ProductDao")
public class ProductDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "product.ProductBean";
	
	public ProductDao() {
		
	}

	public void insertProduct(ProductBean pb) {
		sqlSessionTemplate.insert(namespace + ".insertProduct", pb);
	}

	public List<ProductBean> getAllProduct() {
		List<ProductBean> lists = sqlSessionTemplate.selectList(namespace + ".getAllProduct");
		return lists;
	}

	public void deleteProduct(int pnum) {
		sqlSessionTemplate.delete(namespace + ".deleteProduct", pnum);
	}
}
