package product.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import member.model.MemberBean;
import product.model.OrderBean;
import product.model.OrderDao;

@Controller
public class ProductReceiptController {

	private final String command = "/receipt.product";
	private final String viewPage = "productReceipt";
	
	@Autowired
	private OrderDao orderDao;
	
	@RequestMapping(value = command)
	public String receiptGet(HttpSession session, Model model) {
		
		//현재 로그인 정보
		MemberBean memberBean = (MemberBean) session.getAttribute("loginInfo");
		
		//전체 주문내역중 이메일주소가 같은 주문 중 최근주문 1개 가져오기
		OrderBean orderBean = orderDao.getRecentOrder(memberBean.getEmail());
		
		model.addAttribute("orderBean", orderBean);
		
		return viewPage;
	}
}
