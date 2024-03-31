package product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		Map<String, Object> cartmap = new HashMap<String, Object>();
		
		MemberBean memberBean = (MemberBean) session.getAttribute("loginInfo");
		
		//주문내역 추가
		String order_id = RandomStringUtils.randomAlphanumeric(8);
		orderBean.setOrder_id(order_id);
		orderDao.insertOrder(orderBean);
		
		//사용자 포인트 차감
		memberDao.reducePoint(orderBean.getUsing_point(), orderBean.getEmail());
		
		//구매포인트 적립
		memberDao.updatePoint(orderBean.getPoint(), orderBean.getEmail());
		
		// 사용자 정보 업데이트를 위해 데이터베이스에서 최신 정보 조회
		MemberBean updatedMemberBean = memberDao.getMemberByEmail(orderBean.getEmail());

		// 세션의 loginInfo를 최신 정보로 업데이트
		session.setAttribute("loginInfo", updatedMemberBean);
		
		//환불테이블에 결제완료 상태로 등록
		RefundBean refundBean = new RefundBean();
		refundBean.setOrder_id(orderBean.getOrder_id());
		refundBean.setMember_id(memberBean.getMember_id());
		refundBean.setPname(orderBean.getPname());
		refundBean.setPop_out(orderBean.getPop_out());
		refundBean.setReason("결제 완료");
		refundBean.setState(0);
		
		refundDao.insertRefund(refundBean);
		
		// 장바구니에 여러 상품 담아서 결제 시 재고 차감
		if(orderBean.getPname().contains(",")) {
	        String[] pnameArr = orderBean.getPname().split(",");
	        String[] popArr = orderBean.getPop_out().split(",");

	        //장바구니로 여러 상품 결제했을 때 상품명과 수량 가져와서 넣기
	        for (int i = 0; i < pnameArr.length; i++) {
	            // 공백 제거
	            String singlePname = pnameArr[i].trim();
	            int singlePop = Integer.parseInt(popArr[i].trim()); // 문자열을 정수로 변환

	            cartmap.put("pname", singlePname);
	            cartmap.put("pop_out", singlePop);
	            productDao.reduceCartPqty(cartmap);
	        }
	        
	    }else {
	    	//단일상품 재고 차감
			productDao.reducePqty(orderBean);
	    }
		
		//결제 완료시 장바구니 상품 비우기
		List<CartBean> cartLists = cartDao.getUserList(memberBean.getMember_id());
		if(cartLists.size() >= 1) {
			cartDao.deleteCart(memberBean.getMember_id());
		}
		
	}

}
