package cart.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CartListController {

	private final String command = "/list.cart";
	private final String viewPage = "cartList";
	
	@RequestMapping(value = command)
	public String cartGet() {
		
		return viewPage;
	}
	
}
