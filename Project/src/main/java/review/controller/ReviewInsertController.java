package review.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import product.model.ProductDao;
import review.model.ReviewBean;
import review.model.ReviewDao;

@Controller
public class ReviewInsertController {

	private final String command = "/insert.review";
	private final String viewPage = "reviewInsert";
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private ReviewDao reviewDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String insertGet(String pname, String member_id, Model model) {
		
		int pnum = productDao.getpnumByPname(pname);
		
		model.addAttribute("pnum", pnum);
		model.addAttribute("pname", pname);
		model.addAttribute("member_id",member_id);
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String insertPost(ReviewBean reviewBean) {
		
		reviewDao.insertReview(reviewBean);
		
		return viewPage;
	}
}
