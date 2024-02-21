package board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import board.model.BoardBean;
import board.model.BoardDao;

@Controller
public class BoardDetailController {

	private final String command = "/detail.board";
	private final String viewPage = "boardDetail";
	
	@Autowired
	private BoardDao boardDao;
	
	@RequestMapping(value = command)
	public String detailGet(@RequestParam("board_number") int board_number, Model model) {
		BoardBean boardBean = boardDao.getBoardByNum(board_number);
		model.addAttribute("boardBean", boardBean);
		return viewPage;
	}
}
