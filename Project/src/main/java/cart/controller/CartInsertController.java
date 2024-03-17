package cart.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cart.model.CartBean;
import cart.model.CartDao;
import member.model.MemberBean;
import product.model.ProductBean;

@Controller
public class CartInsertController {

	private final String command = "/insert.cart";
	private final String viewPage = "cartList";
	
	@Autowired
	private CartDao cartDao;
	
	@RequestMapping(value = command)
	public String insertGet(ProductBean productBean, HttpSession session) {
		
		MemberBean memberBean = (MemberBean) session.getAttribute("loginInfo");
		String pname = productBean.getPname();
		int pqty = productBean.getPqty();
	    int price = productBean.getPrice() * pqty;
	    
	    CartBean cartBean = new CartBean();
	    cartBean.setMember_id(memberBean.getMember_id());
	    cartBean.setProduct_name(pname);
	    cartBean.setPqty(pqty);
	    cartBean.setPrice(price);

	    cartDao.insertCart(cartBean);
	    
	    return viewPage;
	}
}
