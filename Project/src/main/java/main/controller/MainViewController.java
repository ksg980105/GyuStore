package main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainViewController {

	private final String command = "view.main";
	private final String viewPage = "main";
	
	@RequestMapping(value = command)
	public String main() {
		
		return viewPage;
	}
}
