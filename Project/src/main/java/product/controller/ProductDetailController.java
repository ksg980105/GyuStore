package product.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import product.model.ProductBean;
import product.model.ProductDao;
import review.model.ReviewBean;
import review.model.ReviewDao;

@Controller
public class ProductDetailController {

	private final String command = "/detail.product";
	private final String viewPage = "productDetail";
	
	@Autowired
	private ProductDao productDao;

	@Autowired
	private ReviewDao reviewDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String detailGet(int pnum, Model model,
							@RequestParam(value = "pageNumber", required = false) String pageNumber) {
	
		ProductBean productBean = productDao.getProductByNum(pnum);
		model.addAttribute("productBean", productBean);
		model.addAttribute("pageNumber", pageNumber);
		
		//상품평 출력부분
		List<ReviewBean> reviewList = reviewDao.getAllReviewByPnum(pnum);
		model.addAttribute("reviewList", reviewList);
		
		return viewPage;
	}
}
