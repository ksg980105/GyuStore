package favorite.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FavoriteListController {

	private final String command = "/list.favorite";
	private final String viewPage = "";
	
	@RequestMapping(value = command)
	public String favorite() {
		
		return viewPage;
	}
}
