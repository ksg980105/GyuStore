package member.controller;

import java.util.HashMap;
import java.util.Map;

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
import product.model.ProductDao;

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
	
	@Autowired
	private ProductDao productDao;
	
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
		
		return gotoPage;
	}
}
