package member.controller;

import java.util.HashMap;
import java.util.List;
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
public class RefundHandlingController {

	private final String command = "/refundHandle.member";
	private final String viewPage = "refundHandlingForm";
	
	@Autowired
	private RefundDao refundDao;
	
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String handleGet(Model model) {
		
		int standard_state = 1;
		List<RefundBean> refundList = refundDao.getAllRefund(standard_state);
		
		model.addAttribute("refundList", refundList);
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String handlePost(String order_id, HttpSession session) {
		Map<String, Object> cartmap = new HashMap<String, Object>();
				
		OrderBean orderBean = orderDao.getAllByOrderId(order_id);
		
		//환불 상태 변경 0:결제완료, 1:신청중, 2:환불 완료, 3:구매 확정
		refundDao.updateState(order_id);
		
		//환불완료시 사용한포인트 반환
		memberDao.returnPoint(orderBean);
		
		//환불완료시 적립된 포인트 반환
		memberDao.returnUsingPoint(orderBean);
		
		// 사용자 정보 업데이트를 위해 데이터베이스에서 최신 정보 조회
		MemberBean updatedMemberBean = memberDao.getMemberByEmail(orderBean.getEmail());
		
		// 세션의 loginInfo를 최신 정보로 업데이트
		session.setAttribute("loginInfo", updatedMemberBean);
		
		// 장바구니에 여러 상품 담아서 결제 시 재고 복구
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
	            productDao.updateCartPqty(cartmap);
	        }
	        
	    }else {
	    	//단일상품 재고 복구
			productDao.returnPqty(orderBean);
	    }
		
		return viewPage;
	}
}
