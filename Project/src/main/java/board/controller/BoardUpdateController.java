package board.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import board.model.BoardBean;
import board.model.BoardDao;

@Controller
public class BoardUpdateController {

	private final String command = "/update.board";
	private final String viewPage = "boardUpdate";
	
	@Autowired
	private BoardDao boardDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String updateGet(@RequestParam("board_number") int board_number, Model model) {
		BoardBean boardBean = boardDao.getBoardByNum(board_number);
		model.addAttribute("boardBean", boardBean);
		return viewPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public void updatePost(BoardBean boardBean, HttpServletResponse response, HttpServletRequest request) throws IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		Timestamp currentTime = new Timestamp(new Date().getTime());
        boardBean.setWrite_date(currentTime);
		
        boardDao.updateBoard(boardBean);
		
        out.println("<script>alert('수정이 완료되었습니다.'); location.href='" + request.getContextPath()
		+ "/product.board';</script>");
        out.flush();
		
	}
}
