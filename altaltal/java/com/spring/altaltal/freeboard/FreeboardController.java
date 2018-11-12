package com.spring.altaltal.freeboard;

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

@Controller
public class FreeboardController {
	
	@Autowired
	private FreeboardDAO freeboardDAO;
	
	/*@RequestMapping(value="/mainBoardList.fr")
	public String mainBoardList() {
		return "freeBoardList";
	}
	*/
	@RequestMapping(value="/getMainBoardList.fr")
	public String getMainBoardList(HttpServletRequest request, Model model) {
		String topic ="";
		String keyword = "";
		
		int page = 1;
		int limit = 10;
		
		if(request.getParameter("topic") != null) {
			topic = request.getParameter("topic");
		}
		if(request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		System.out.println(page);
		ArrayList<FreeboardVO> boardList = freeboardDAO.getMainBoardList(page, limit, topic, keyword);
		int listCount = freeboardDAO.getCountMainBoard(topic, keyword);
		
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
		model.addAttribute("boardList", boardList);
		
		return "./freeboard/freeboard_list";
	}
	
	@RequestMapping(value="/getBoardArticle.fr")
	public String getBoardArticle(HttpServletRequest request, Model model) {
		
		int free_num = Integer.parseInt(request.getParameter("free_num"));
		String page = request.getParameter("page");
		String article_num = request.getParameter("article_num");
		System.out.println("free_num : " + free_num);
		System.out.println("page : " + page);
		System.out.println("article_num : " + article_num);
		
		FreeboardVO vo = freeboardDAO.getBoard(free_num);
		model.addAttribute("article", vo);
		model.addAttribute("page", page);
		model.addAttribute("article_num", article_num);
		
		return "./freeboard/freeboard_article";
	}
	
	@RequestMapping(value="/boardWriteForm.fr")
	public String boardWriteForm(HttpServletRequest request, Model model) {
		String page = request.getParameter("page");
		model.addAttribute("page", page);
		
		return "./freeboard/freeboard_write";
	}
	
	@RequestMapping(value="/boardWrite.fr")
	public String boardWrite(FreeboardVO vo, HttpServletResponse response, Model model) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		int check = vo.getFree_ref();
		System.out.println("check : " + check);
		int res = freeboardDAO.insertBoard(vo);
		if(res == 1) {
			if(check != 0) {
				out.println("<script>");
				out.println("alert('게시글 등록완료')");
				out.println("history.back();");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('게시글 등록완료')");
				out.println("location.href='./getMainBoardList.fr';");
				out.println("</script>");
			}		
		}else {
			out.println("<script>");
			out.println("alert('게시글 등록실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return null;
	}
	
	@RequestMapping(value="/getReplyArticle.fr", method= RequestMethod.POST,
			produces="application/json;charset=UTF-8")
	@ResponseBody
	public String getPeopleJSONGET(FreeboardVO vo) {
		System.out.println("ajax relpy : " + vo.getFree_num());
		String str = "";
		try {
		ArrayList<HashMap<String, Object>> articleList = freeboardDAO.getReplyBoardList(vo.getFree_num());
		ObjectMapper mapper = new ObjectMapper(); //JSON형식으로 데이터를 반환하기 위해 사용(pom.xml 편집)
		
			str = mapper.writeValueAsString(articleList);
		} catch (Exception e) {
			System.out.println("first() mapper : " + e.getMessage());
		}
		return str;
	}
	
	@RequestMapping(value="/articleDelete.fr")
	public String articleDelete(FreeboardVO vo, HttpServletRequest request, HttpSession session, HttpServletResponse response, Model model) throws Exception{
		String page = request.getParameter("page");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
	
		int res = freeboardDAO.deleteArticle(vo);
		if(res >= 1) {
			out.println("<script>");
			out.println("alert('해당글을 삭제하였습니다.')");
			out.println("location.href='./getMainBoardList.fr?page="+ page +"';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('게시글 삭제실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return null;
	}
	
	@RequestMapping(value="/commentDelete.fr")
	public String commentDelete(FreeboardVO vo, HttpServletRequest request, HttpSession session, HttpServletResponse response, Model model) throws Exception{
		String page = request.getParameter("page");
		int free_num = Integer.parseInt(request.getParameter("main_num"));
		int article_num = Integer.parseInt(request.getParameter("article_num"));
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
	
		int res = freeboardDAO.deleteComment(vo);
		if(res == 1) {
			out.println("<script>");
			out.println("alert('해당댓글을 삭제하였습니다.')");
			out.println("location.href='./getBoardArticle.fr?free_num="+ free_num + "&page="+ page +"&article_num="+ article_num+ "';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('댓글 삭제실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return null;
	}
	
	@RequestMapping(value="/articleUpdateForm.fr")
	public String articleUpdateForm(FreeboardVO vo, HttpServletRequest request, Model model) throws Exception{
		String page = request.getParameter("page");
		String article_num = request.getParameter("article_num");
		FreeboardVO vo2 = freeboardDAO.getBoard(vo.getFree_num());
		model.addAttribute("article", vo2);
		model.addAttribute("page", page);
		model.addAttribute("article_num", article_num);
		
		return "./freeboard/freeboard_updateForm";
	}
	
	@RequestMapping(value="/articleUpdate.fr")
	public String articleUpdate(FreeboardVO vo, HttpServletResponse response, HttpServletRequest request) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String page = request.getParameter("page");
		int res = freeboardDAO.updateBoard(vo);
		if(res == 1) {
			out.println("<script>");
			out.println("alert('해당글을 수정하였습니다.')");
			out.println("location.href='./getMainBoardList.fr?page="+ page +"';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('해당글 수정실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return null;
	}
	
	@RequestMapping(value="/updateComment.fr")
	public String updateComment(FreeboardVO vo, HttpServletResponse response, HttpServletRequest request) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		System.out.println("확인 comment : " + vo.getFree_content());
		PrintWriter out = response.getWriter();
		String page = request.getParameter("page");
		int free_num = Integer.parseInt(request.getParameter("main_num"));
		int article_num = Integer.parseInt(request.getParameter("article_num"));
		int res = freeboardDAO.updateComment(vo);
		if(res == 1) {
			out.println("<script>");
			out.println("alert('해당 댓글을 수정하였습니다.')");
			out.println("location.href='./getBoardArticle.fr?free_num="+ free_num + "&page="+ page +"&article_num="+ article_num +"';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('해당글 수정실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return null;
	}
}
