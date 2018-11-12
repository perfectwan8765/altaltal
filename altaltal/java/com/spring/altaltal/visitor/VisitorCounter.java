package com.spring.altaltal.visitor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.FrameworkServlet;

@Component
public class VisitorCounter implements HttpSessionListener {
	
	@Override
	public void sessionCreated(HttpSessionEvent arg0) {
		HttpSession session = arg0.getSession();
		System.out.println("sessionCreated : " + session);
		WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext(), FrameworkServlet.SERVLET_CONTEXT_PREFIX + "appServlet");
		System.out.println(context.toString());
		VisitorDAOService vds = (VisitorDAOService)context.getBean("visitorDAOService");
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		System.out.println(request.getHeader("User-Agent"));
		vds.insertVisitor(request.getHeader("User-Agent"));
	}
	
	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {
		HttpSession session = arg0.getSession();
		System.out.println("sessionDestroyed : " + session);
	}
}
