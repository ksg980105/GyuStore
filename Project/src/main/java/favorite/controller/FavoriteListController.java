package favorite.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import favorite.model.FavoriteDao;
import member.model.MemberBean;
import product.model.ProductBean;
import product.model.ProductDao;

@Controller
public class FavoriteListController {

	private final String command = "/list.favorite";
	private final String viewPage = "favoriteList";
	
	@Autowired
	private FavoriteDao favoriteDao;
	
	@Autowired
	private ProductDao productDao;
	
	@RequestMapping(value = command)
	public String listGet(HttpSession session, Model model) {
		
		MemberBean memberBean = (MemberBean) session.getAttribute("loginInfo");
		
		//회원아이디로 즐겨찾기 목록 가져오기
		List<Integer> favoritePnums = favoriteDao.getAllFavorite(memberBean.getMember_id());
		
		// 즐겨찾기한 상품들의 정보를 가져오기
        List<ProductBean> favoriteProducts = new ArrayList<ProductBean>();
        for (Integer pnum : favoritePnums) {
            ProductBean productBean = productDao.getProductByNum(pnum);
            favoriteProducts.add(productBean);
        }
		
		model.addAttribute("favoriteProducts", favoriteProducts);
				
		return viewPage;
	}
}
