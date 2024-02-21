package member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class FindIdController {

	private final String command = "/findId.member";
	private final String viewPage = "findIdForm";
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String findIdGet() {
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public void findIdPost(@RequestParam("name") String name, @RequestParam("phone") String phone,
							HttpServletResponse response, HttpServletRequest request) throws IOException {
		
		PrintWriter out;
		out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("name", name);
		map.put("phone", phone);
		MemberBean memberBean = memberDao.getInfoByNameAndPhone(map);
		
		if(memberBean == null) {
			out.println("<script>alert('회원정보가 없습니다.'); location.href='" + request.getContextPath() + "/findId.member';</script>");
			out.flush();
		}else {
			String memberId = memberBean.getMember_id();
			String alertMessage = "아이디는 [" + memberId + "] 입니다. 로그인페이지로 이동합니다.";
			
			out.println("<script>alert('" + alertMessage + "'); location.href='" + request.getContextPath() + "/login.member';</script>");
			out.flush();
		}
		
	}
}
