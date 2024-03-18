package cart.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cart.model.CartDao;

@Controller
public class CartDeleteController {

	private final String command = "/delete.cart";
	
	@Autowired
	private CartDao cartDao;
	
	@RequestMapping(value = command)
	public String delGet(@RequestParam("product_name") String product_name) {
		
		cartDao.deleteCart(product_name);
		
		return "redirect:/list.cart";
	}
}
