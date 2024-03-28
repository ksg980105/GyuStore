package member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import member.model.RefundBean;
import member.model.RefundDao;

@Controller
public class RefundCheckController {

	private final String command = "/refundCheck.member";
	
	@Autowired
	private RefundDao refundDao;
	
	@RequestMapping(value = command)
	@ResponseBody
	public String check(String order_id) {
		
		//주문 아이디로 환불정보 가져오기
		RefundBean refundBean = refundDao.getAllByOrderId(order_id);
		
		if (refundBean != null) {
	        return String.valueOf(refundBean.getState());
	    } else {
	        // 환불정보가 null일 경우, No refund 메시지로 넘김
	        return "No refund";
	    }
		
	}
}
