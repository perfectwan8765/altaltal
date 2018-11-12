package com.spring.user.controller;

import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.spring.user.domain.UserDTO;
import com.spring.user.domain.UserVO;
import com.spring.user.service.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Inject
	private UserService service;
	
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping(value="/find", method=RequestMethod.GET)
	public void find() {
	}
	
	@RequestMapping(value="/find", method=RequestMethod.POST)
	public String find(String email, RedirectAttributes rttr) throws Exception{
		int check = service.checkEmail(email);
		
		if(check == 1) {
			rttr.addAttribute("email", email);
			return "/user/findOk";
		}else if(check == -1) {
			rttr.addFlashAttribute("msg", "Try again!");
			return "/user/find";
		}
		
		rttr.addFlashAttribute("msg", "This email not exist");
		return "/user/find";
	}
	
	@RequestMapping(value="/emailChk", method=RequestMethod.GET)
	public void emailChk(@ModelAttribute("email") String email, Model model) throws Exception{
		model.addAttribute("check", service.checkEmail(email));
	}
	
	@RequestMapping(value="/unameChk", method=RequestMethod.GET)
	public void unameChk(@ModelAttribute("uname") String uname, Model model) throws Exception{
		model.addAttribute("check", service.checkUname(uname));
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public void login(UserDTO dto, HttpSession session, HttpServletResponse response, RedirectAttributes rttr) throws Exception{
		int check = service.checkUser(dto);
		if(check == 1) {
			UserVO vo = service.login(dto);
			
			if(vo != null) {
				logger.info("new login success!");
				session.setAttribute("login", vo);
				
				if(dto.isUseCookie() != false) {
					logger.info("User select AutoLogin");
					Cookie loginCookie = new Cookie("loginCookie", session.getId());
					loginCookie.setPath("/");
					loginCookie.setMaxAge(60*60*24*7);
					response.addCookie(loginCookie);
				}
			}
			
			if(dto.isUseCookie()) {
				
				int amount = 60*60*24*7;
				Date sessiondate = new Date(System.currentTimeMillis() + (1000*amount));
				
				vo.setSessionkey(session.getId());
				vo.setSessiondate(sessiondate);
				
				service.keepLogin(vo);				
			}
			
		}else if(check == -1) {
			logger.info("Wrong Password");
			rttr.addFlashAttribute("msg", "Wrong Password");
		}else {
			logger.info("Wrong Email");
			rttr.addFlashAttribute("msg", "Wrong Email");
		}
		
		Object dest = session.getAttribute("dest");
		logger.info("dest:" + dest);
		response.sendRedirect(dest != null ? (String)dest : "/");		
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String join(UserVO vo, RedirectAttributes rttr) throws Exception{
		logger.info("join check: " + vo.toString());
		
		int check = service.join(vo);
		if(check == 1) {
			rttr.addFlashAttribute("msg", "Join Success, Weclome!");
		}else {
			rttr.addFlashAttribute("msg", "Join Failure, Try again!");
		}
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		Object obj = session.getAttribute("login");
		
		if(obj != null) {
			UserVO vo = (UserVO) obj;
			
			session.removeAttribute("login");
			session.invalidate();
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			if(loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				vo.setSessionkey(session.getId());
				vo.setSessiondate(new Date());
				service.keepLogin(vo);
			}
			
		}
		
		return "redirect:/";
	}
}
