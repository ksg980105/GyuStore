package category.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("CategoryDao")
public class CategoryDao {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	private String namespace = "category.CategoryBean";
	
	public CategoryDao() {
		
	}

	public List<CategoryBean> getAllCategory() {
		List<CategoryBean> lists = sqlSessionTemplate.selectList(namespace + ".getAllCategory");
		return lists;
	}

	public void insertCategory(String category_name) {
		sqlSessionTemplate.insert(namespace + ".insertCategory", category_name);
	}

	public void deleteCategory(int category_number) {
		sqlSessionTemplate.delete(namespace + ".deleteCategory", category_number);
		
	}
}
