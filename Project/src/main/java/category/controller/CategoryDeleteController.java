package category.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import category.model.CategoryDao;

@Controller
public class CategoryDeleteController {

	private final String command = "/delete.category";
	
	@Autowired
	private CategoryDao categoryDao;
	
	@RequestMapping(value = command)
	public void delete(@RequestParam("category_number") int category_number,
						HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		categoryDao.deleteCategory(category_number);
		out.println("<script>alert('카테고리 삭제완료'); location.href='" + request.getContextPath() + "/list.category';</script>");
	}
}
