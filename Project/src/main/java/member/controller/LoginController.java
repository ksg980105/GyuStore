package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class LoginController {

	private final String command = "/login.member";
	private final String viewPage = "loginForm";
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String loginGet() {
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public String loginPost(@RequestParam("member_id") String member_id, @RequestParam("password") String password,
							HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		MemberBean memberBean = memberDao.findwithId(member_id);
		
		if(memberBean == null) { //회원정보가 없을 때
			out.println("<script>alert('아이디나 비밀번호가 틀렸습니다.'); location.href='" + request.getContextPath() + "/login.member';</script>");
		
		}else { //회원정보가 있을 때
			if(memberBean.getPassword().equals(password)) {  //비밀번호가 일치할 때
				session.setAttribute("loginInfo", memberBean);
				out.println("<script>alert('로그인되었습니다.'); location.href='" + request.getContextPath() + "/view.main';</script>");
			
			}else { //비밀번호가 일치하지 않을 때
				out.println("<script>alert('비밀번호가 일치하지 않습니다.'); location.href='" + request.getContextPath() + "/login.member';</script>");
			}
		}
		return null;
	}
}
