package review.controller;

import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import product.model.ProductDao;

@Controller
public class ReviewCartInsertController {

	private final String command = "/cartInsert.review";
	private final String viewPage = "cartReviewInsert";
	
	@Autowired
	private ProductDao productDao;
	
	@RequestMapping(value = command)
	public String cartReviewGet(String pname, String member_id, String order_id, Model model) {
	    Map<Integer, String> pnumToPnameMap = new LinkedHashMap<Integer, String>(); // 순서를 유지하는 맵 생성
	    // 장바구니에 담아서 물품을 구매했을 경우
	    String[] pnameArr = pname.split(",");

	    // 분리된 각 상품명에 대해 반복 처리
	    for (String singlePname : pnameArr) {
	        // 공백 제거
	        singlePname = singlePname.trim();

	        // 각 상품명에 해당하는 pnum 찾기
	        int pnum = productDao.getpnumByPname(singlePname);

	        // 찾은 pnum과 pname을 맵에 추가
	        pnumToPnameMap.put(pnum, singlePname);
	    }

	    model.addAttribute("pnumToPnameMap", pnumToPnameMap);
	    model.addAttribute("member_id", member_id);
	    model.addAttribute("order_id", order_id);
	    return viewPage;
	}

}
