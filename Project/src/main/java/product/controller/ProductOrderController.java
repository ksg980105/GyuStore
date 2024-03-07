package product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import product.model.OrderBean;
import product.model.ProductBean;
import product.model.ProductDao;

@Controller
public class ProductOrderController {
	
	private final String command = "/order.product";
	private final String viewPage = "productOrder";
	private final String gotoPage = "/main.view";
	
	@Autowired
	private ProductDao productDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String orderGet(@RequestParam("pnum") int pnum, @RequestParam("pop_out") int popOut,
							Model model) {
		
		ProductBean productBean = productDao.getProductByNum(pnum);
		
		model.addAttribute("productBean", productBean);
		model.addAttribute("pop_out", popOut);
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String orderPost(OrderBean orderBean) {
		
		System.out.println("name:" + orderBean.getName());
		System.out.println(orderBean.getEmail());
		System.out.println(orderBean.getPop_out());
		System.out.println(orderBean.getAddress1());
		System.out.println(orderBean.getAddress2());
		System.out.println(orderBean.getPhone());
		System.out.println(orderBean.getPimage());
		System.out.println(orderBean.getPname());
		System.out.println(orderBean.getPoint());
		System.out.println(orderBean.getProductPrice());
		System.out.println(orderBean.getRequestOrder());
		System.out.println(orderBean.getUsing_point());
		return gotoPage;
	}

}
