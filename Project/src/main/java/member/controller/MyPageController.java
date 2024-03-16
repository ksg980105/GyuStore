package member.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import member.model.MemberBean;
import product.model.OrderBean;
import product.model.OrderDao;

@Controller
public class MyPageController {

	private final String command = "/mypage.member";
	private final String viewPage = "mypage";
	
	@Autowired
	private OrderDao orderDao;
	
	@RequestMapping(value = command)
	public String mypageGet(HttpSession session, Model model) {
		
		MemberBean memberBean = (MemberBean) session.getAttribute("loginInfo");
		List<OrderBean> orderList = orderDao.getAllOrder(memberBean.getEmail());
		
		model.addAttribute("orderList", orderList);
		
		return viewPage;
	}
}
