package board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import board.model.BoardBean;
import board.model.BoardDao;
import utility.Paging;

@Controller
public class BoardListController {

	private final String command = "/product.board";
	private final String viewPage = "boardList";

	@Autowired
	private BoardDao boardDao;

	@RequestMapping(value = command, method = RequestMethod.GET)
	public String list(@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "pageNumber", required = false) String pageNumber, HttpServletRequest request,
			HttpSession session, Model model) {

		Map<String, String> map = new HashMap<String, String>();
		map.put("whatColumn", whatColumn);
		map.put("keyword", "%" + keyword + "%");

		int totalCount = boardDao.getTotalCount(map);
		System.out.println("totalCount:" + totalCount);
		String url = request.getContextPath() + command;

		Paging pageInfo = new Paging(pageNumber, "5", totalCount, url, whatColumn, keyword);

		List<BoardBean> lists = boardDao.getAllBoard(map, pageInfo);

		model.addAttribute("lists", lists);
		model.addAttribute("pageInfo", pageInfo);

		return viewPage;
	}
}
