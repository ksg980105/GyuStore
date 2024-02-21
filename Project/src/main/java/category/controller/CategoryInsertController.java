package category.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import category.model.CategoryDao;

@Controller
public class CategoryInsertController {

	private final String command = "/insert.category";
	private final String viewPage = "categoryInsert";
	
	@Autowired
	private CategoryDao categoryDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String insertGet() {
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public void insertPost(@RequestParam("category_name") String category_name,
							HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		categoryDao.insertCategory(category_name);
		out.println("<script>alert('카테고리 등록완료'); location.href='" + request.getContextPath() + "/list.category';</script>");
	}
}
