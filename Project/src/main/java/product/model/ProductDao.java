package product.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import utility.Paging;

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

	public List<ProductBean> getAllProducts() {
		List<ProductBean> lists = sqlSessionTemplate.selectList(namespace + ".getAllProduct");
		return lists;
	}
	
	public List<ProductBean> getAllProduct(Map<String, String> map, Paging pageInfo) {
		RowBounds rowbounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		List<ProductBean> lists = sqlSessionTemplate.selectList(namespace + ".getAllProduct", map, rowbounds);
		return lists;
	}

	public void deleteProduct(int pnum) {
		sqlSessionTemplate.delete(namespace + ".deleteProduct", pnum);
	}

	public ProductBean getProductByNum(int pnum) {
		ProductBean pb = sqlSessionTemplate.selectOne(namespace + ".getProductByNum", pnum);
		return pb;
	}

	public void updateProduct(ProductBean productBean) {
		sqlSessionTemplate.update(namespace + ".updateProduct", productBean);
	}

	public int getTotalCount(Map<String, String> map) {
		int cnt = sqlSessionTemplate.selectOne(namespace + ".getTotalCount", map);
		return cnt;
	}

	public int getPointForProduct(String product_name) {
		int totalPoint = sqlSessionTemplate.selectOne(namespace + ".getPointForProduct", product_name);
		return totalPoint;
	}

	public int getpnumByPname(String pname) {
		int pnum = sqlSessionTemplate.selectOne(namespace + ".getpnumByPname", pname);
		return pnum;
	}

	public void reducePqty(OrderBean orderBean) {
		sqlSessionTemplate.update(namespace + ".reducePqty", orderBean);
	}

	public void returnPqty(OrderBean orderBean) {
		sqlSessionTemplate.update(namespace + ".returnPqty", orderBean);
	}

}
