package board.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import board.model.BoardBean;
import board.model.BoardDao;

@Controller
public class BoardWriteController {

	private final String command = "/write.board";
	private final String viewPage = "boardWrite";
	
	@Autowired
	private BoardDao boardDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String writeGet() {
		
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public void writePost(BoardBean boardBean, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		Timestamp currentTime = new Timestamp(new Date().getTime());
        boardBean.setWrite_date(currentTime);
        
        int cnt = boardDao.insertBoard(boardBean);
		
        out.println("<script>alert('문의등록이 완료되었습니다.'); location.href='" + request.getContextPath()
		+ "/product.board';</script>");
        out.flush();
	}
}
