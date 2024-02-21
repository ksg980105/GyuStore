package product.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import product.model.ProductDao;

@Controller
public class ProductDeleteController {

	private final String command = "/delete.product";
	
	@Autowired
	private ProductDao productDao;
	
	@RequestMapping(value = command)
	public void deleteGet(@RequestParam("pnum") int pnum, HttpServletRequest request,
							HttpServletResponse response) throws IOException {
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		productDao.deleteProduct(pnum);
		
		out.println("<script>alert('상품이 삭제되었습니다.'); location.href='" + request.getContextPath()
		+ "/list.product';</script>");
		out.flush();
	}
}
