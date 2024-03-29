package com.spring.user.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.spring.user.domain.UserVO;
import com.spring.user.service.UserService;

public class AuthInterceptor extends HandlerInterceptorAdapter{
	
		@Inject
		private UserService service;

		private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
		
		private void saveDest(HttpServletRequest req) {
			
			String uri = req.getRequestURI();
			String query = req.getQueryString();
			
			if(query == null || query.equals("null")) {
				query = "";
			}else {
				query = "?" + query;
			}
			
			if(req.getMethod().equals("GET")) {
				logger.info("dest: " + (uri + query));
				req.getSession().setAttribute("dest", (uri+query));
			}
		}
		
		@Override
		public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
				Object handler) throws Exception{
			
			HttpSession session = request.getSession();
			
			if(session.getAttribute("login") == null) {
				logger.info("current user is not logined");
				saveDest(request);
				Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
				
				if(loginCookie != null) {
					
					UserVO vo = service.checkAutoLogin(loginCookie.getValue());
					logger.info("AutoLogin user : " + vo.toString());
					
					if(vo != null) {
						session.setAttribute("login", vo);
						return true;
					}
				}
			
				String old_url = request.getHeader("referer").substring(21);
				response.sendRedirect(old_url);
				
				return false;
			}
			
			return true;
		}
}
