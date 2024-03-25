package product.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import cart.model.CartBean;
import cart.model.CartDao;
import member.model.MemberBean;
import member.model.MemberDao;
import product.model.OrderBean;
import product.model.OrderDao;
import product.model.ProductBean;
import product.model.ProductDao;

@Controller
public class ProductOrderController {
	
	private final String command = "/order.product";
	private final String viewPage = "productOrder";
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private CartDao cartDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String orderGet(@RequestParam("pnum") int pnum, @RequestParam("pop_out") int popOut,
							Model model) {
		
		ProductBean productBean = productDao.getProductByNum(pnum);
		
		model.addAttribute("productBean", productBean);
		model.addAttribute("pop_out", popOut);
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public void orderPost(OrderBean orderBean, HttpSession session) {
		
		//주문내역 추가
		orderDao.insertOrder(orderBean);
		
		//사용자 포인트 차감
		memberDao.reducePoint(orderBean.getUsing_point(), orderBean.getEmail());
		System.out.println("using_point:" + orderBean.getUsing_point());
		
		//구매포인트 적립
		memberDao.updatePoint(orderBean.getPoint(), orderBean.getEmail());
		
		//결제 완료시 장바구니 상품 비우기
		MemberBean memberBean = (MemberBean)session.getAttribute("loginInfo");
		List<CartBean> cartLists = cartDao.getUserList(memberBean.getMember_id());
		if(cartLists.size() >= 1) {
			cartDao.deleteAll();
		}
	}

}
