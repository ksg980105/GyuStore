package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import member.model.RefundDao;

@Controller
public class CancelRequestController {

	private final String command = "/cancel.member";
	private final String viewPage = "mypage";
	
	@Autowired
	private RefundDao refundDao;
	
	@RequestMapping(value = command)
	public String cancel(String order_id) {
		
		refundDao.updateCancelState(order_id);
		
		return viewPage;
	}
}
