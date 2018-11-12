package com.spring.altaltal.hotplace;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
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
public class HotplaceController {
	
	@Autowired
	private HotplaceDAO hotplaceDAO;
	
	
	@RequestMapping(value="/getHotplaceList.ho")
	public String getPlaceList(HttpServletRequest request, Model model) {
		String place_area = "제주";
		if(request.getParameter("place_area") != null) {
			place_area = request.getParameter("place_area");
		}
		
		String keyword = "";
		if(request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
		int page = 1;
		int limit = 6;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		System.out.println(page);
		ArrayList<HotplaceVO> placeList = hotplaceDAO.getPlaceList(page, limit, place_area, keyword);
		int listCount = hotplaceDAO.getCountHotplace(place_area);
		
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
		
		model.addAttribute("place_area", place_area);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("placeList", placeList);
		model.addAttribute("keyword", keyword);
		
		return "./hotplace/hotplace_list";
	}
	
	@RequestMapping(value="/gethotplace.ho")
	public String gethotplace(HotplaceVO vo, HttpServletRequest request, Model model) throws IOException {
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
		
		ArrayList<HashMap<String, Object>> pboardList = hotplaceDAO.getCommentList(commentPage, limit, vo.getPlace_num());
		int listCount = hotplaceDAO.getCountComment(vo.getPlace_num());
		
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
		
		HotplaceVO vo2 = hotplaceDAO.getPlace(vo);
		String base_url = "https://store.naver.com/restaurants/detail?id=" + vo2.getPlace_url() + "&tab=fsasReview&tabPage=0";
		String blog_number_content = "";
		String blog_number = "";
		
		 Document naver_reviews = Jsoup.connect(base_url)
				   .header("Accept", "text/html, application/xhtml+xml, image/jxr, */*")
				   .header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko")
				   .header("Accept-Encoding", "gzip, deflate").header("Accept-Language", "ko-KR")
				   .header("Connection", "Keep-Alive").get();
		 
		 Elements div_blogarea  = naver_reviews.select("div.info_inner");
		   for(Element blog_nums : div_blogarea) {
			   Elements blog_numbers = blog_nums.select("a.link");
			   for(Element bb : blog_numbers) {
				   blog_number_content = bb.text();
			   }
		   }
		blog_number = blog_number_content.substring(7);
		
		model.addAttribute("blog_number", blog_number);
		model.addAttribute("keyword", keyword);
		model.addAttribute("place", vo2);
		model.addAttribute("page", page);
		model.addAttribute("pboardList", pboardList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "./hotplace/hotplace_detail";
	}
	
/*	@RequestMapping(value="/getPlaceComments.ho", method= RequestMethod.POST,
			produces="application/json;charset=UTF-8")
	@ResponseBody
	public String getPlaceComments(HotplaceVO vo) {
		System.out.println("ajax PlaceComment : " + vo.getPlace_num());
		String str = "";
		try {
		ArrayList<PlaceboardVO> commentList = hotplaceDAO.getCommentList(vo.getPlace_num());
		ObjectMapper mapper = new ObjectMapper(); //JSON형식으로 데이터를 반환하기 위해 사용(pom.xml 편집)
		
			str = mapper.writeValueAsString(commentList);
		} catch (Exception e) {
			System.out.println("first() mapper : " + e.getMessage());
		}
		return str;
	}*/
	
	@RequestMapping(value="/evaluatePlace.ho", method= RequestMethod.POST,
			produces="application/json;charset=UTF-8")
	@ResponseBody
	public String evaluatePlace(HotplaceVO vo) {
		System.out.println("ajax evaluatePlace : " + vo.getPlace_num());
		String str = "";
		try {
			HashMap<String, Double> map = hotplaceDAO.evaluatePlace(vo.getPlace_num());
			System.out.println("map 확인 key값 : " + map.get("AVG(PBOARD_TASTE"));
			ObjectMapper mapper = new ObjectMapper(); //JSON형식으로 데이터를 반환하기 위해 사용(pom.xml 편집)
			str = mapper.writeValueAsString(map);
		} catch (Exception e) {
			System.out.println("first() mapper : " + e.getMessage());
		}
		return str;
	}
	
	@RequestMapping(value="/placeLikeCheck.ho", method= RequestMethod.POST,
			produces="application/json;charset=UTF-8")
	@ResponseBody
	public String placeLikeCheck(MemberVO vo, HotplaceVO vo2) {
		System.out.println("ajax userLikeCheck : " + vo.getMember_email());
		String str = "";
		try {
			String likeCheck = hotplaceDAO.placeLikeCheck(vo.getMember_email(), vo2.getPlace_num());
			System.out.println("ajax likeCheck : " + likeCheck);
			ObjectMapper mapper = new ObjectMapper(); //JSON형식으로 데이터를 반환하기 위해 사용(pom.xml 편집)
			str = mapper.writeValueAsString(likeCheck);
		} catch (Exception e) {
			System.out.println("first() mapper : " + e.getMessage());
		}
		return str;
	}
	
	@RequestMapping(value="/placeLikeUpdate.ho", method= RequestMethod.POST,
			produces="application/json;charset=UTF-8")
	@ResponseBody
	public String placeLikeUpdate(MemberVO vo, HotplaceVO vo2, HttpServletRequest request) {
		System.out.println("ajax userLikeUpdate : " + vo.getMember_email());
		String userLike = request.getParameter("userLike");
		String str = "";
		try {
			HashMap<String, Object> map = hotplaceDAO.placeLikeUpdate(vo.getMember_email(), vo2.getPlace_num(), userLike);
			System.out.println("ajax likeCheck : " + map.size());
			ObjectMapper mapper = new ObjectMapper(); //JSON형식으로 데이터를 반환하기 위해 사용(pom.xml 편집)
			str = mapper.writeValueAsString(map);
		} catch (Exception e) {
			System.out.println("first() mapper : " + e.getMessage());
		}
		return str;
	}
	
	@RequestMapping(value="/insertPlaceComment.ho")
	public String insertPlaceComment(PlaceboardVO vo, HttpSession session, HttpServletResponse response)throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String nickname = (String)session.getAttribute("nickname");
		vo.setMember_nickname(nickname);
		
		int res = hotplaceDAO.insertPlaceComment(vo);
		if(res == 1) {
			out.println("<script>");
			out.println("alert('댓글 평가완료')");
			out.println("location.href='./gethotplace.ho?place_num="+ vo.getPlace_num() + "';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('댓글 평가실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return null;
	}
	
	@RequestMapping(value="/updatePlaceComment.ho")
	public String updatePlaceComment(PlaceboardVO vo, HttpServletRequest request, HttpServletResponse response)throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		int page = Integer.parseInt(request.getParameter("page"));
		int commentPage = Integer.parseInt(request.getParameter("commentPage"));
		
		int res = hotplaceDAO.updatePlaceComment(vo);
		if(res == 1) {
			out.println("<script>");
			out.println("alert('댓글 수정완료')");
			out.println("location.href='./gethotplace.ho?place_num="+ vo.getPlace_num() + "&page="+ page+ "&commentPage="+ commentPage+"';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('댓글 수정실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return null;
	}
	
	@RequestMapping(value="/deletePlaceComment.ho")
	public String deletePlaceComment(PlaceboardVO vo, HttpServletRequest request, HttpServletResponse response)throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		int page = Integer.parseInt(request.getParameter("page"));
		int commentPage = Integer.parseInt(request.getParameter("commentPage"));
		
		int res = hotplaceDAO.deletePlaceComment(vo);
		if(res == 1) {
			out.println("<script>");
			out.println("alert('댓글 삭제완료')");
			out.println("location.href='./gethotplace.ho?place_num="+ vo.getPlace_num() + "&page="+ page+ "&commentPage="+ commentPage+"';");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('댓글 삭제실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		return null;
	}
	
	@RequestMapping(value="/croling.ho", method= RequestMethod.POST,
			produces="application/json;charset=UTF-8")
	@ResponseBody
	public String croling(HotplaceVO vo) throws IOException {
		Croling cr;
		ArrayList<Croling> crList = new ArrayList<Croling>();
		System.out.println("ajax : " + vo.getPlace_num());
		String place_url = hotplaceDAO.getPlaceUrl(vo.getPlace_num());
		int num=0;
		String base_url = "https://store.naver.com/restaurants/detail?id=" + place_url + "&tab=fsasReview&tabPage=";
		int page = 0;
		String COMPLETE_URL = base_url + page;
		System.out.println("COMPLETE_URL : " + COMPLETE_URL);
		
		   Document naver_reviews = Jsoup.connect(COMPLETE_URL)
		   .header("Accept", "text/html, application/xhtml+xml, image/jxr, */*")
		   .header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko")
		   .header("Accept-Encoding", "gzip, deflate").header("Accept-Language", "ko-KR")
		   .header("Connection", "Keep-Alive").get();
		   
		  Elements div_reviews =naver_reviews.select("div.tit");
		  for(Element div_review : div_reviews) {
			   Elements url_title = div_review.select("a.name");
			   for (Element x : url_title) {
				      String url = x.attr("href");
				      String title = x.text();
				    	  cr = new Croling();
				    	  cr.setUrl(url);
				    	  cr.setTitle(title);
				    	  crList.add(cr);
			   }
		  }
		  
		  Elements div_content =naver_reviews.select("div.txt.ellp2");
		  for(Element x : div_content) {
			 String content = x.text();
			 cr = crList.get(num);
			 cr.setContent(content);
			 crList.set(num, cr);
			 num++;
		  }

		   String str = "";
		   ObjectMapper mapper = new ObjectMapper();
		   str = mapper.writeValueAsString(crList);
		   
		   return str;
	}

}
