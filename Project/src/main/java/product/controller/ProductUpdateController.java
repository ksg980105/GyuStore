package product.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import category.model.CategoryBean;
import category.model.CategoryDao;
import member.model.MemberBean;
import product.model.ProductBean;
import product.model.ProductDao;

@Controller
public class ProductUpdateController {

	private final String command = "/update.product";
	private final String viewPage = "productUpdate";
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String updateGet(Model model) {
		
		List<ProductBean> lists = productDao.getAllProduct();
		model.addAttribute("productList", lists);
		
		List<CategoryBean> clists = categoryDao.getAllCategory();
		model.addAttribute("categoryList", clists);
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public void updatePost(ProductBean productBean, HttpServletResponse response, HttpServletRequest request,
							HttpSession session) throws IOException {
		
		PrintWriter out;
		out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		String path = servletContext.getRealPath("/resources/memberImage");

		File directory = new File(path);
		if (!directory.exists()) {
			directory.mkdirs();
		}
		
		String imageName = productBean.getPimage();
		File uploadImage = new File(path + File.separator + imageName);
		
		try {
			productBean.getUpload().transferTo(uploadImage);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		System.out.println(productBean.getPimage());
		System.out.println(productBean.getPname());
		session.setAttribute("productList", productBean);
		
		out.println("<script>alert('상품정보가 수정되었습니다.'); location.href='" + request.getContextPath()
		+ "/list.product';</script>");
		out.flush();
		
	}
}
