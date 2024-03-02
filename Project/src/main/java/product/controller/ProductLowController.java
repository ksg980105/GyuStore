package product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import product.model.ProductBean;
import product.model.ProductDao;

@Controller
public class ProductLowController {

	private final String command = "/low.product";
	private final String viewPage = "productView";
	
	@Autowired
	private ProductDao productDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String viewPriceLow(Model model) {
		
		List<ProductBean> lists = productDao.ProductByPriceAsc();
		model.addAttribute("productList", lists);
		return viewPage;
	}
}
