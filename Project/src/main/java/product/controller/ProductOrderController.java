package product.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
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
import member.model.RefundBean;
import member.model.RefundDao;
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
	
	@Autowired
	private RefundDao refundDao;
	
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
		
		MemberBean memberBean = (MemberBean) session.getAttribute("loginInfo");
		
		//주문내역 추가
		String order_id = RandomStringUtils.randomAlphanumeric(8);
		orderBean.setOrder_id(order_id);
		orderDao.insertOrder(orderBean);
		
		//사용자 포인트 차감
		memberDao.reducePoint(orderBean.getUsing_point(), orderBean.getEmail());
		
		//구매포인트 적립
		memberDao.updatePoint(orderBean.getPoint(), orderBean.getEmail());
		
		//환불테이블에 결제완료 상태로 등록
		RefundBean refundBean = new RefundBean();
		refundBean.setOrder_id(orderBean.getOrder_id());
		refundBean.setMember_id(memberBean.getMember_id());
		refundBean.setPname(orderBean.getPname());
		refundBean.setPop_out(orderBean.getPop_out());
		refundBean.setReason("결제 완료");
		refundBean.setState(0);
		
		refundDao.insertRefund(refundBean);
		
		//결제 완료시 장바구니 상품 비우기
		List<CartBean> cartLists = cartDao.getUserList(memberBean.getMember_id());
		if(cartLists.size() >= 1) {
			cartDao.deleteCart(memberBean.getMember_id());
		}
		
		//환불완료시 차감된포인트 반환
		
		//환불완료시 적립된 포인트 반환
		
	}

}
