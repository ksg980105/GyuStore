package review.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ReviewListController {

	private final String command = "/list.review";
	private final String viewPage = "reviewList";
	
	@RequestMapping(value = command)
	public String listGet() {
		
		return viewPage;
	}
}
