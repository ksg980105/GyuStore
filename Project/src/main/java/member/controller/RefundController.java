package member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.model.MemberBean;
import member.model.MemberDao;
import member.model.RefundBean;
import member.model.RefundDao;
import product.model.OrderBean;
import product.model.OrderDao;

@Controller
public class RefundController {

	private final String command = "/refund.member";
	private final String viewPage = "refundForm";
	private final String gotoPage = "mypage";
	
	@Autowired
	private RefundDao refundDao;
	
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String refundGet(String order_id, Model model, HttpSession session) {
		
		//주문번호로 주문정보 가져오기
		OrderBean orderBean = orderDao.getAllByOrderId(order_id);
		
		model.addAttribute("orderBean", orderBean);
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String refundPost(RefundBean refundBean, HttpSession session) {
		
		//환불 상태 변경 0:결제완료, 1:신청중, 2:환불 완료, 3:구매 확정
		refundDao.updaterefundState(refundBean);
		
		//환불시 포인트 되돌리기 위해 order_id에 맞는 정보 가져오기
		OrderBean orderBean = orderDao.getAllByOrderId(refundBean.getOrder_id());
		
		//환불완료시 사용한포인트 반환
		memberDao.returnPoint(orderBean);
		
		//환불완료시 적립된 포인트 반환
		memberDao.returnUsingPoint(orderBean);
		
		return gotoPage;
	}
}
