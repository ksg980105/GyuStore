package board.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import board.model.BoardDao;

@Controller
public class BoardDeleteController {

	private final String command = "/delete.board";
	
	@Autowired
	private BoardDao boardDao;
	
	@RequestMapping(value = command)
	public void delete(@RequestParam("board_number") int board_number, 
						HttpServletResponse response, HttpServletRequest request) throws IOException {
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		boardDao.deleteBoard(board_number);
		
		out.println("<script>alert('삭제가 완료되었습니다.'); location.href='" + request.getContextPath()
		+ "/product.board';</script>");
        out.flush();
	}
}
