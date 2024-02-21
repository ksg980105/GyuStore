package category.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import category.model.CategoryBean;
import category.model.CategoryDao;

@Controller
public class CategoryListController {

	private final String command = "/list.category";
	private final String viewPage = "categoryList";
	
	@Autowired
	private CategoryDao categoryDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String listGet(Model model) {
		
		List<CategoryBean> lists = categoryDao.getAllCategory();
		model.addAttribute("categoryList", lists);
		
		return viewPage;
	}
}
