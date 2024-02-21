package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class FindPwController {
	
	private final String command = "/findPw.member";
	private final String viewPage = "findPwForm";
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String findPwGet() {
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public void findPwPost(@RequestParam("member_id") String member_id, @RequestParam("phone") String phone,
								@RequestParam("email") String email, HttpServletResponse response,
								HttpServletRequest request) throws IOException {
		
		PrintWriter out;
		out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		MemberBean memberBean = memberDao.findwithId(member_id);
		
		if(memberBean == null) { //회원정보가 없을때
			out.println("<script>alert('회원정보가 없습니다.'); location.href='" + request.getContextPath() + "/findPw.member';</script>");
			out.flush();
		
		}else { //회원정보가 있을때
			if(phone.equals(memberBean.getPhone())) { //전화번호가 일치할때
				if(email.equals(memberBean.getEmail())) { //이메일주소가 일치할때
					String mempassword = memberBean.getPassword();
					
					response.sendRedirect("sendEmail.member?mempassword=" + mempassword + "&email=" + email);
					
				}else { 
					out.println("<script>alert('이메일주소가 일치하지 않습니다.'); location.href='" + request.getContextPath() + "/findPw.member';");
					out.flush();
				}
				
			}else { //전화번호 일치 안할때
				out.println("<script>alert('휴대폰번호가 일치하지 않습니다.'); location.href='" + request.getContextPath() + "/findPw.member';</script>");
				out.flush();
			}
		}
	}
}
