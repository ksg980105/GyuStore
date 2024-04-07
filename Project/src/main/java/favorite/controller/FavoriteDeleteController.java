package favorite.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import favorite.model.FavoriteDao;
import member.model.MemberBean;

@Controller
public class FavoriteDeleteController {

	private final String command = "/delete.favorite";
	
	@Autowired
	private FavoriteDao favoriteDao;
	
	@RequestMapping(value = command)
	@ResponseBody
	public String delete(int pnum, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		MemberBean memberBean = (MemberBean) session.getAttribute("loginInfo");
		map.put("pnum", pnum);
		map.put("member_id", memberBean.getMember_id());
		
		favoriteDao.deleteFavorite(map);
		
		return "성공";
	}
}
