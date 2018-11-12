package com.spring.altaltal.mypage;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.altaltal.freeboard.FreeboardDAO;
import com.spring.altaltal.freeboard.FreeboardVO;
import com.spring.altaltal.freeboard.PageInfo;
import com.spring.altaltal.hotplace.HotplaceVO;
import com.spring.altaltal.makguli.MakguliVO;
import com.spring.altaltal.member.MemberDAO;
import com.spring.altaltal.member.MemberVO;

@Controller
public class MypageController {
	
	@Autowired
	private MypageDAO mypageDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private FreeboardDAO freeboardDAO;
	
	@RequestMapping(value="/MypageInfoAction.my")
	public String MypageDetailAction(MemberVO vo, HttpSession session, HttpServletRequest request, Model model) throws Exception {
		String email=(String)session.getAttribute("email");		
		if(email==null){
			return "./main";
		}
		
		vo = mypageDAO.getMember(email);
		model.addAttribute("vo", vo);
		return "./mypage/mypage_info";
	}
	
	@RequestMapping(value="/MypageUpdateAction.my")
	public String MypageUpdateAction(MemberVO vo, MultipartHttpServletRequest multiRequest, HttpServletResponse response) throws Exception {
		MultipartFile mf = multiRequest.getFile("profile_img");
		String uploadPath = "C:\\BigDeep\\altaltal\\profile\\";
		String storedFileName ="";
		if(mf.getSize() != 0) {
		String originalFileExtension = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
		String serial = getRamdomPassword();
		storedFileName = serial + originalFileExtension;
			//mf.transferTo(new File(uploadPath+ "/" + mf.getOriginalFilename()));
			mf.transferTo(new File(uploadPath + storedFileName));
		}
		vo.setMember_picture(storedFileName);
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		int res = mypageDAO.updateMember(vo);
		if(res == 1) {
			out.println("<script>");
			out.println("alert('회원수정 완료')");
			out.println("location.href='./MypageInfoAction.my'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('회원수정 실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return null;
	}
	
	@RequestMapping(value="/MypageDeleteAction.my")
	public String MypageDeleteAction(MemberVO vo, HttpServletResponse response, HttpSession session) throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		int check = memberDAO.userCheck(vo);
		if(check == 1) {
			int res = mypageDAO.deleteMember(vo.getMember_email());
			if(res == 1) {
				session.invalidate();
				out.println("<script>");
				out.println("alert('회원탈퇴 완료')");
				out.println("location.href='./main.me'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('회원탈퇴 실패')");
				out.println("history.back();");
				out.println("</script>");
			}
		}else {
			out.println("<script>");
			out.println("alert('비밀번호가 일치하지 않습니다. 다시 로그인해주세요.');");
			out.println("history.go(-1);");
			out.println("</script>");
		}
		return null;
	}
	
	@RequestMapping(value="/MypageNICKNAMECheckAction.me")
	public String MypageNICKNAMECheckAction(HttpServletRequest request, Model model) {
		String nickname=request.getParameter("member_nickname");
		int check=mypageDAO.confirmNickname(nickname);	
		request.setAttribute("nickname", nickname);
		request.setAttribute("check", check);
		
		return "./mypage/mypage_nicknamechk";
	}
	
	@RequestMapping(value="/mypageFreeboardList.my")
	public String MypageFreeboardList(HttpSession session, HttpServletRequest request, Model model) {
		String nickname = (String)session.getAttribute("nickname");		
		int page = 1;
		int limit = 10;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		System.out.println(page);
		ArrayList<FreeboardVO> boardList = mypageDAO.getMemberBoardList(page, limit, nickname);
		int listCount = mypageDAO.getCountMemberBoard(nickname);
		
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
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("boardList", boardList);
		
		return "./mypage/mypage_freeboardlist";
	}
	
	@RequestMapping(value="/mypageGetArticle.my")
	public String mypageGetArticle(HttpServletRequest request, Model model) {
		int free_num = Integer.parseInt(request.getParameter("free_num"));
		String page = request.getParameter("page");
		String article_num = request.getParameter("article_num");
		System.out.println("free_num : " + free_num);
		System.out.println("page : " + page);
		System.out.println("article_num : " + article_num);
		
		FreeboardVO vo = mypageDAO.getBoard(free_num);
		model.addAttribute("article", vo);
		model.addAttribute("page", page);
		model.addAttribute("article_num", article_num);
		
		return "./mypage/mypage_freearticle";
	}
	
	@RequestMapping(value="/mypageArticleDelete.my")
	public String mypageArticleDelete(FreeboardVO vo, HttpServletRequest request, HttpSession session, HttpServletResponse response, Model model) throws Exception{
		String page = request.getParameter("page");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
	
			int res = freeboardDAO.deleteArticle(vo);
			if(res == 1) {
				out.println("<script>");
				out.println("alert('해당글을 삭제하였습니다.')");
				out.println("location.href='./mypageFreeboardList.my?page="+ page +"';");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('게시글 삭제실패')");
				out.println("history.back();");
				out.println("</script>");
			}
		return null;
	}
	
	@RequestMapping(value="/mypageArticleSearch.my")
	public String mypageArticleSearch(HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		request.setCharacterEncoding("UTF-8");
		String nickname = (String)session.getAttribute("nickname");
		String topic = request.getParameter("topic");
		String keyword = request.getParameter("keyword");
		System.out.println("mypage search메소드 keyowrd : " + keyword);
		
		int page = 1;
		int limit = 10;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		ArrayList<FreeboardVO> boardList = mypageDAO.searchArticles(page, limit, nickname, topic, keyword);
		int listCount = mypageDAO.getCountSearchArticle(nickname, topic, keyword);
		
		int maxPage = (int)((double)listCount/limit + 0.95);
		int startPage = (((int)((double)page / 10 +0.9)) -1)*10+1;
		int endPage = startPage+10-1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		System.out.println("articleSearch listCount : " + listCount);
		
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
		
		return "./mypage/mypage_freeboardlist";
		
	}
	

	@RequestMapping(value="/mypageMakguliList.ma")
	public String mypageMakguliList(HttpSession session, HttpServletRequest request, Model model) {
		String email = (String)session.getAttribute("email");
		
		String keyword = "";
		String topic = "";
		int page = 1;
		int limit = 10;
		int listCount = 0;
		
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
		ArrayList<MakguliVO> makguliList = mypageDAO.mypageMakguliList(page, limit, email, topic, keyword);
		if(makguliList != null) {
			listCount = mypageDAO.getCountMyMakguli(email, topic, keyword);
		}
		
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
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("makguliList", makguliList);
		
		return "./mypage/mypage_maklist";
	}
	
	@RequestMapping(value="/mypagePlaceList.my")
	public String mypagePlaceList(HttpSession session, HttpServletRequest request, Model model) {
		String email = (String)session.getAttribute("email");
		
		String keyword = "";
		String topic = "";
		int page = 1;
		int limit = 10;
		int listCount = 0;
		
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
		ArrayList<HotplaceVO> placeList = mypageDAO.mypagePlaceList(page, limit, email, topic, keyword);
		if(placeList != null) {
			listCount = mypageDAO.getCountMyPlace(email, topic, keyword);
		}
		
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
		model.addAttribute("placeList", placeList);
		
		return "./mypage/mypage_placelist";
	}
	
	@RequestMapping(value="/myMakguliCommentList.my")
	public String myMakguliCommentList(HttpSession session, HttpServletRequest request, Model model) {
		String nickname = (String)session.getAttribute("nickname");
		
		String keyword = "";
		String topic = "";
		int page = 1;
		int limit = 10;
		int listCount = 0;
		
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
		ArrayList<HashMap<String, Object>> commentList = mypageDAO.myMakguliCommentList(page, limit, nickname, topic, keyword);
		if(commentList != null) {
			listCount = mypageDAO.getCountCommntMakguli(nickname, topic, keyword);
		}
		
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
		model.addAttribute("commentList", commentList);
		
		return "./mypage/mypage_makcommentlist";
	}
	
	@RequestMapping(value="/myPlaceCommentList.my")
	public String myPlaceCommentList(HttpSession session, HttpServletRequest request, Model model) {
		String nickname = (String)session.getAttribute("nickname");
		
		String keyword = "";
		String topic = "";
		int page = 1;
		int limit = 10;
		int listCount = 0;
		
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
		ArrayList<HashMap<String, Object>> commentList = mypageDAO.myPlaceCommentList(page, limit, nickname, topic, keyword);
		if(commentList != null) {
			listCount = mypageDAO.getCountCommntPlace(nickname, topic, keyword);
		}
		
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
		model.addAttribute("commentList", commentList);
		
		return "./mypage/mypage_placommentlist";
	}
	
	public String getRamdomPassword() {
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' }; 
	    int idx = 0; 
	    StringBuffer sb = new StringBuffer();  
	    
	    for (int i = 0; i < 10; i++){ 
	    	idx = (int) (charSet.length * Math.random());
	    	sb.append(charSet[idx]); 
	    } 
	    System.out.println("난수 만들기 : " + sb);
	    
	    return sb.toString();
	}
}
