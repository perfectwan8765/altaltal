package com.spring.altaltal.makguli;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.altaltal.freeboard.PageInfo;
import com.spring.altaltal.member.MemberVO;

@Controller
public class MakguliController {
	
	@Autowired
	private MakguliDAO makguliDAO;
	
	@RequestMapping(value="/getMakguliList.ma")
	public String getMakguliList(HttpServletRequest request, Model model) {
		String keyword = "";
		if(request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
		String makguli_area = "서울";
		if(request.getParameter("makguli_area") != null) {
			makguli_area = request.getParameter("makguli_area");
		}
		
		int page = 1;
		int limit = 8;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		System.out.println(page);
		ArrayList<MakguliVO> makguliList = makguliDAO.getMakguliList(page, limit, makguli_area, keyword);
		int listCount = makguliDAO.getCountMakguli(makguli_area);
		
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
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("makguli_area", makguli_area);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("makguliList", makguliList);
		
		return "./makguli/makguli_list";
	}
	
	@RequestMapping(value="/getMakguli.ma")
	public String getMakguli(MakguliVO vo, HttpServletRequest request, Model model) {
		int page = 1;
		String keyword = "";
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		if(request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
		int commentPage = 1;
		if(request.getParameter("commentPage") != null) {
			commentPage = Integer.parseInt(request.getParameter("commentPage"));
		}
		int limit = 10;
		
		ArrayList<HashMap<String, Object>> mboardList = makguliDAO.getCommentList(commentPage, limit, vo.getMakguli_num());
		int listCount = makguliDAO.getCountComment(vo.getMakguli_num());
		
		int maxPage = (int)((double)listCount/limit + 0.95);
		int startPage = (((int)((double)page / 10 +0.9)) -1)*10+1;
		int endPage = startPage+10-1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(commentPage);
		pageInfo.setStartPage(startPage);
		
		MakguliVO vo2 = makguliDAO.getMakguli(vo.getMakguli_num());
		
		model.addAttribute("makguli", vo2);
		model.addAttribute("page", page);
		model.addAttribute("keyword", keyword);
		model.addAttribute("mboardList", mboardList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "./makguli/makguli_detail";
	}
	
/*	@RequestMapping(value="/getMakguliComments.ma", method= RequestMethod.POST,
			produces="application/json;charset=UTF-8")
	@ResponseBody
	public String getMakguliComments(MakguliVO vo) {
		System.out.println("ajax getMakguliComments : " + vo.getMakguli_num());
		String str = "";
		try {
		ArrayList<MakguliboardVO> commentList = makguliDAO.getCommentList(vo.getMakguli_num());
		ObjectMapper mapper = new ObjectMapper(); //JSON형식으로 데이터를 반환하기 위해 사용(pom.xml 편집)
		
			str = mapper.writeValueAsString(commentList);
		} catch (Exception e) {
			System.out.println("first() mapper : " + e.getMessage());
		}
		return str;
	}*/
	
	@RequestMapping(value="/insertMakguliComment.ma")
	public String insertMakguliComment(MakguliboardVO vo, HttpSession session, HttpServletResponse response)throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		System.out.println("insertmagkulicomment : "+ vo.getMboard_body());
		String nickname = (String)session.getAttribute("nickname");
		vo.setMember_nickname(nickname);
		
		int res = makguliDAO.insertMakguliComment(vo);
		if(res == 1) {
			out.println("<script>");
			out.println("alert('댓글 평가완료')");
			out.println("location.href='./getMakguli.ma?makguli_num="+ vo.getMakguli_num() + "';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('댓글 평가실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return null;
	}
	
	@RequestMapping(value="/userLikeCheck.ho", method= RequestMethod.POST,
			produces="application/json;charset=UTF-8")
	@ResponseBody
	public String userLikeCheck(MemberVO vo, MakguliVO vo2) {
		System.out.println("ajax userLikeCheck : " + vo.getMember_email());
		String str = "";
		try {
			String likeCheck = makguliDAO.userLikeCheck(vo.getMember_email(), vo2.getMakguli_num());
			System.out.println("ajax likeCheck : " + likeCheck);
			ObjectMapper mapper = new ObjectMapper(); //JSON형식으로 데이터를 반환하기 위해 사용(pom.xml 편집)
			str = mapper.writeValueAsString(likeCheck);
		} catch (Exception e) {
			System.out.println("first() mapper : " + e.getMessage());
		}
		return str;
	}
	
	@RequestMapping(value="/userLikeUpdate.ho", method= RequestMethod.POST,
			produces="application/json;charset=UTF-8")
	@ResponseBody
	public String userLikeUpdate(MemberVO vo, MakguliVO vo2, HttpServletRequest request) {
		System.out.println("ajax userLikeUpdate : " + vo.getMember_email());
		String userLike = request.getParameter("userLike");
		String str = "";
		try {
			HashMap<String, Object> map = makguliDAO.userLikeUpdate(vo.getMember_email(), vo2.getMakguli_num(), userLike);
			System.out.println("ajax likeCheck : " + map.size());
			ObjectMapper mapper = new ObjectMapper(); //JSON형식으로 데이터를 반환하기 위해 사용(pom.xml 편집)
			str = mapper.writeValueAsString(map);
		} catch (Exception e) {
			System.out.println("first() mapper : " + e.getMessage());
		}
		return str;
	}
	
	@RequestMapping(value="/updateMakguliComment.ma")
	public String updateMakguliComment(MakguliboardVO vo, HttpServletRequest request, HttpServletResponse response)throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		int page = Integer.parseInt(request.getParameter("page"));
		int commentPage = Integer.parseInt(request.getParameter("commentPage"));
		
		int res = makguliDAO.updateMakguliComment(vo);
		if(res == 1) {
			out.println("<script>");
			out.println("alert('댓글 수정완료')");
			out.println("location.href='./getMakguli.ma?makguli_num="+ vo.getMakguli_num() + "&page="+ page+ "&commentPage="+ commentPage+"';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('댓글 수정실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return null;
	}
	
	@RequestMapping(value="/deleteMakguliComment.ma")
	public String deleteMakguliComment(MakguliboardVO vo, HttpServletRequest request, HttpServletResponse response)throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		int page = Integer.parseInt(request.getParameter("page"));
		int commentPage = Integer.parseInt(request.getParameter("commentPage"));
		
		int res = makguliDAO.deleteMakguliComment(vo);
		if(res == 1) {
			out.println("<script>");
			out.println("alert('댓글 삭제완료')");
			out.println("location.href='./getMakguli.ma?makguli_num="+ vo.getMakguli_num() + "&page="+ page+ "&commentPage="+ commentPage+"';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('댓글 삭제실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return null;
	}
	
}
