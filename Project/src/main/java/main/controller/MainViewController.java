package main.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import product.model.ProductBean;
import product.model.ProductDao;

@Controller
public class MainViewController {

	private final String command = "view.main";
	private final String viewPage = "main";
	
	@Autowired
	ProductDao productDao;
	
	@RequestMapping(value = command)
	public String main(Model model) {
		
		List<ProductBean> productList = productDao.getProductCount();
		
		model.addAttribute("productList", productList);
		
		return viewPage;
	}
}
