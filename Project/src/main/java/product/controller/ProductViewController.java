package product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import product.model.ProductBean;
import product.model.ProductDao;

@Controller
public class ProductViewController {

	private final String command = "/view.product";
	private final String viewPage = "productView";
	
	@Autowired
	private ProductDao productDao;
	
	@RequestMapping(value = command)
	public String viewGet(Model model) {
		
		List<ProductBean> lists = productDao.getAllProduct();
		model.addAttribute("productList", lists);
		return viewPage;
	}
}
