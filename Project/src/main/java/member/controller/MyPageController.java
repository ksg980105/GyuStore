package member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyPageController {

	private final String command = "/mypage.member";
	private final String viewPage = "mypage";
	
	@RequestMapping(value = command)
	public String mypageGet() {
		
		return viewPage;
	}
}
