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

@Controller
public class CartListController {

	private final String command = "/list.cart";
	private final String viewPage = "cartList";
	
	@Autowired
	private CartDao cartDao;
	
	@RequestMapping(value = command)
	public String cartGet(HttpSession session, Model model) {
		
		MemberBean memberBean = (MemberBean) session.getAttribute("loginInfo");
		
			List<CartBean> cartList = cartDao.getUserList(memberBean.getMember_id());
			model.addAttribute("cartList", cartList);
		
		return viewPage;
	}
	
}
