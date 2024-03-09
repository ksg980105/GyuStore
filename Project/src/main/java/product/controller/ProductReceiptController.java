package product.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProductReceiptController {

	private final String command = "/receipt.product";
	private final String viewPage = "productReceipt";
	
	@RequestMapping(value = command)
	public String receiptGet() {
		
		return viewPage;
	}
}
