package category.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import category.model.CategoryBean;
import category.model.CategoryDao;

@Controller
public class CategoryUpdateController {

	private final String command = "/update.category";
	private final String viewPage = "categoryUpdate";
	
	@Autowired
	private CategoryDao categoryDao;
	
	@RequestMapping(value = command)
	public String updateGet(Model model) {
		
		List<CategoryBean> lists = categoryDao.getAllCategory();
		model.addAttribute("categoryList", lists);
		
		return viewPage;
	}
}
