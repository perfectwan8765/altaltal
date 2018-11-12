package com.spring.altaltal.chat;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatController {

	
	@RequestMapping(value = "/chat_intro.ch")
	public String chat_intro() {
		return "./chat/chat_intro";
	}
	
	@RequestMapping(value ="/chat_team.ch")
	public String chat_team(HttpServletRequest request, Model model) {
		String region = request.getParameter("region");
		System.out.println("home4 region : " + region);
		model.addAttribute("region", region);
		return "./chat/chat_team";
	}
	
	@RequestMapping(value ="/chat_one.ch")
	public String chat_one(HttpServletRequest request, Model model) {
		String userName = request.getParameter("userName");
		model.addAttribute("userName", userName);
		return "./chat/chat_one";
	}
}
