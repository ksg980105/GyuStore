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

import member.model.MemberBean;
import member.model.MemberDao;

@Controller
public class UpdateController {

	private final String command = "/update.member";
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public void update(MemberBean mb, HttpServletRequest request, HttpServletResponse response,
						HttpSession session) throws IOException {
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		session.setAttribute("loginInfo", mb);
		memberDao.memberUpdate(mb);
		out.println("<script>alert('수정이 완료되었습니다.'); location.href='" + request.getContextPath() + "/mypage.member';</script>");
	}
}
