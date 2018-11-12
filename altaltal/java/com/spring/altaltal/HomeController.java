package com.spring.altaltal;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.altaltal.freeboard.PageInfo;


@Controller
public class HomeController {
	
	@Autowired
	private FeedbackDAO feedbackDAO;
	
	@Autowired
	private JavaMailSender mailSender;

	@RequestMapping(value = "/")
	public String home() {
		
		return "intro";
	}
	
	@RequestMapping(value = "/intro_no.in")
	public String member_no() {
		
		return "intro_no";
	}
	
	@RequestMapping(value = "/intro_yes.in")
	public String member_yes() {
		
		return "intro_yes";
	}
	
	@RequestMapping(value = "/main.me")
	public String main() {
		
		return "main";
	}
	
	@RequestMapping(value = "/insertFeedback.ma")
	public String insertFeedback(FeedbackVO vo, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		int res = feedbackDAO.insertFeedback(vo);
		if(res == 1) {
			out.println("<script>");
			out.println("alert('소중한 의견 감사합니다.')");
			out.println("location.href='./main.me'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('의견 전송이 실패하였습니다.')");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return null;
	}
	
	@RequestMapping(value = "/feedbackList.ad")
	public String feedbackList(FeedbackVO vo, Model model, HttpServletRequest request) throws Exception {
		String keyword ="";
		String topic ="";
		int page = 1;
		int limit = 10;
		
		if(request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
		if(request.getParameter("topic") != null) {
			topic = request.getParameter("topic");
		}
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		System.out.println(page);
		ArrayList<FeedbackVO> feedbackList = feedbackDAO.getFeedbackList(page, limit);
		int listCount = feedbackDAO.getCountFeedback();
		
		int maxPage = (int)((double)listCount/limit + 0.95);
		int startPage = (((int)((double)page / 10 +0.9)) -1)*10+1;
		int endPage = startPage+10-1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		System.out.println("listCount : " + listCount);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);
		
		model.addAttribute("topic", topic);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("feedbackList", feedbackList);
		
		return "./admin/feedback/feedback_list";
	}
	
	@RequestMapping(value = "/getFeedback.ad")
	public String getFeedback(FeedbackVO vo, Model model, HttpServletRequest request) throws Exception {
		FeedbackVO feedback = feedbackDAO.getFeedback(vo.getFeedback_num());
		model.addAttribute("feedback", feedback);
		
		return "./admin/feedback/feedback_detail";
	}
	
	@RequestMapping(value = "/updateFeedback.ad")
	public String updateFeedback(FeedbackVO vo, HttpServletResponse response, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String status = request.getParameter("changeStatus");
		int res = feedbackDAO.updateFeedback(vo.getFeedback_num(), status);
		if(res == 1) {
			out.println("<script>");
			out.println("alert('해당 피드백 처리 완료하였습니다.')");
			out.println("location.href='./getFeedback.ad?feedback_num="+ vo.getFeedback_num() + "';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('피드백 처리실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return null;
	}
	
	@RequestMapping(value = "/responseFeedback.ad")
	public String responseFeedback(FeedbackVO vo, HttpServletResponse response, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String response_message = request.getParameter("response_message");
		
		String setfrom = "altaltal337@gmail.com";         
	    String tomail  = vo.getFeedback_email();     // 받는 사람 이메일
	    String title   = "[Project Altaltal] 피드백 답변 보내드립니다.";     // 제목
	    String content= "[project altaltal]입니다. 소중한 피드백을 주셔서 감사합니다. \n"
	    						+ "보내주신 분 : \"" + vo.getFeedback_writer() + "\"\n"
	    						+ "내용 : [ " + vo.getFeedback_message() + " ]\n" 
	    						+ "응답 : [ " + response_message + " ]\n" 
	    						+ "다시 한번 저희 사이트를 방문해 주셔서 감사합니다. 앞으로도 많은 이용 부탁드립니다.";
	    						// 내용
	    try {
	      MimeMessage msg = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper = new MimeMessageHelper(msg, true, "UTF-8");
	 
	      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
	      messageHelper.setTo(tomail);     // 받는사람 이메일
	      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
	      messageHelper.setText(content);  // 메일 내용

	      mailSender.send(msg);
	      
	      feedbackDAO.updateFeedback(vo.getFeedback_num(), "response");
			out.println("<script>");
			out.println("alert('피드백 응답처리를 완료하였습니다.')");
			out.println("location.href='./getFeedback.ad?feedback_num="+ vo.getFeedback_num() + "';");
			out.println("</script>");
	      
	    } catch(Exception e){
	    	System.out.println("error메시지 : " + e.getMessage());
	      	out.println("<script>");
			out.println("alert('피드백 응답 처리실패')");
			out.println("history.back();");
			out.println("</script>");
	    }
	    
		return null;
	}
	
	@RequestMapping(value = "/deleteFeedback.ad")
	public String deleteFeedback(FeedbackVO vo, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		int res = feedbackDAO.deleteFeedback(vo.getFeedback_num());
		if(res == 1) {
			out.println("<script>");
			out.println("alert('해당 피드백 삭제 완료하였습니다.')");
			out.println("location.href='./feedbackList.ad';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('피드백 삭제실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return null;
	}
}
