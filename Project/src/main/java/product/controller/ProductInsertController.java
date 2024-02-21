package product.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import category.model.CategoryBean;
import category.model.CategoryDao;
import product.model.ProductBean;
import product.model.ProductDao;

@Controller
public class ProductInsertController {

	private final String command = "/insert.product";
	private final String viewPage = "productInsert";
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String insertGet(Model model) {
		
		List<CategoryBean> lists = categoryDao.getAllCategory();
		model.addAttribute("categoryList", lists);
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public void insertPost(@Valid ProductBean pb, BindingResult bresult, HttpServletResponse response,
							HttpServletRequest request, Model model) throws IOException {
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		String path = servletContext.getRealPath("/resources/productImage");
		
		File directory = new File(path);
	    if (!directory.exists()) {
	        directory.mkdirs();
	    }
	    
	    String imageName = pb.getPimage();
	    File uploadImage = new File(path + File.separator + imageName);
	    try {
			pb.getUpload().transferTo(uploadImage);
		} catch (Exception e) {
			e.printStackTrace();
		}
	    
	    productDao.insertProduct(pb);
	    out.println("<script>alert('상품 등록완료'); location.href='" + request.getContextPath() + "/list.product';</script>");
		
	}
	
}
