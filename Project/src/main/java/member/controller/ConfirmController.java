package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import member.model.RefundDao;

@Controller
public class ConfirmController {

	private final String command = "/confirm.member";
	private final String viewPage = "mypage";
	
	@Autowired
	private RefundDao refundDao;
	
	@RequestMapping(value = command)
	public String confirm(String order_id) {
		
		refundDao.updateConfirmState(order_id);
		
		return viewPage;
	}
}
