package cart.controller;

import java.util.HashMap;
import java.util.Map;

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
	    int price = productBean.getPrice();
	    
	    CartBean cartBean = new CartBean();
	    cartBean.setMember_id(memberBean.getMember_id());
	    cartBean.setProduct_name(pname);
	    cartBean.setPqty(pqty);
	    cartBean.setPrice(price);

	    // 사용자 ID와 상품명을 모두 고려하여 동일한 상품이 있는지 확인
	    CartBean existingCart = cartDao.getCartByUserAndProduct(cartBean.getMember_id(), cartBean.getProduct_name());
	    System.out.println(existingCart);
	    if(existingCart != null) { // 해당 사용자의 장바구니에 같은 상품명이 있으면
	        // 수량만 추가
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("pname", pname);
	        map.put("pqty", pqty); // 기존 수량에 추가
	        map.put("member_id", memberBean.getMember_id()); // 사용자 ID도 맵에 추가
	        cartDao.updateProductPqty(map);
	    } else {
	        // 없으면 그냥 추가
	        cartDao.insertCart(cartBean);
	    }
	    
	    return viewPage;
	}

}
