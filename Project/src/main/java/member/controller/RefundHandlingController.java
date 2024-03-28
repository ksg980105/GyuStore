package member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import member.model.RefundBean;
import member.model.RefundDao;

@Controller
public class RefundHandlingController {

	private final String command = "/refundHandle.member";
	private final String viewPage = "refundHandlingForm";
	
	@Autowired
	private RefundDao refundDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String handleGet(Model model) {
		
		int standard_state = 1;
		List<RefundBean> refundList = refundDao.getAllRefund(standard_state);
		
		model.addAttribute("refundList", refundList);
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String handlePost(String order_id) {
		
		refundDao.updateState(order_id);
		
		return viewPage;
	}
}
