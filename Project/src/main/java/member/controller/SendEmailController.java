package member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.PasswordAuthentication;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class SendEmailController {

	private final String command = "/sendEmail.member";
	private final String gotoPage = "/login.member";
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public void sendEmail(@RequestParam("mempassword") String mempassword,
						  @RequestParam("email") String email, HttpServletRequest request, 
						  HttpServletResponse response) throws AddressException, MessagingException, IOException {
	
		//메일 관련 정보 
		String host = "smtp.naver.com";
		final String username = "username";
		final String password = "password";
		int port=465; //네이버 STMP 포트 번호
		
		//메일 내용
		String recipient = email; //메일을 발송할 이메일 주소
		String subject = "당신을위한 서점 Gyu 문고 비밀번호 알림 메일"; //메일 발송시 제목
		String body = "회원님의 비밀번호는[ " + mempassword + " ]입니다."; //메일 발송시 내용
		
		Properties props = System.getProperties();
		
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator(){
			String un = username;
			String pw = password;
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(un, pw);
			}
		});
		session.setDebug(true);
		
		Message mimeMessage = new MimeMessage(session);
		mimeMessage.setFrom(new InternetAddress("ksg980105@naver.com"));
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
		mimeMessage.setSubject(subject);
		mimeMessage.setText(body);
		Transport.send(mimeMessage);
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		out.println("<script>alert('이메일로 비밀번호가 전송되었습니다.'); location.href='" + request.getContextPath() + "/" + gotoPage + "';</script>");
		out.flush();
	
	}
}
