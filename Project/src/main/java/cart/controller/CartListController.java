package cart.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cart.model.CartBean;
import cart.model.CartDao;
import member.model.MemberBean;
import product.model.ProductDao;

@Controller
public class CartListController {

	private final String command = "/list.cart";
	private final String viewPage = "cartList";
	
	@Autowired
	private CartDao cartDao;
	
	@Autowired
	private ProductDao productDao;
	
	@RequestMapping(value = command)
	public String cartGet(HttpSession session, Model model) {
		
		MemberBean memberBean = (MemberBean) session.getAttribute("loginInfo");
		
		//로그인한 사용자 장바구니 목록 가져오기
		List<CartBean> cartList = cartDao.getUserList(memberBean.getMember_id());
		model.addAttribute("cartList", cartList);
		
		//총 상품가격 가져오기
		int totalPrice = 0;
		for (CartBean cartBean : cartList) {
			// 장바구니에 있는 각 상품의 가격 가져오기
	        int price = cartBean.getPrice()*cartBean.getPqty();
	        
	        // 카트 상품가격들 더하기
	        totalPrice += price;
		}
		
		//총 적립포인트 가져오기
	    int totalPoint = 0;
	    for (CartBean cartBean : cartList) {
	        // 장바구니에 있는 각 상품의 포인트 가져오기
	        int point = productDao.getPointForProduct(cartBean.getProduct_name());
	        
	        // 상품의 포인트 * 수량 값을 총 포인트에 더하기
	        totalPoint += point * cartBean.getPqty();
	    }
	    
	    model.addAttribute("totalPrice", totalPrice);
	    model.addAttribute("totalPoint", totalPoint);
		
		return viewPage;
	}
	
}
