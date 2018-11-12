package com.spring.altaltal.travel;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.altaltal.freeboard.PageInfo;

@Controller
public class TravelController {
	
	@Autowired
	private TravelDAO travelDAO;
	
	@RequestMapping(value="/courseList.tr")
	public String courseList(HttpServletRequest request, Model model) throws Exception {
		String course_area = "서울";
		if(request.getParameter("course_area") != null) {
			course_area = request.getParameter("course_area");
		}
		
		String keyword ="";
		if(request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
		int page = 1;
		int limit = 3;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		ArrayList<CourseVO> courseList = travelDAO.courseList(page, limit, course_area, keyword);
		ArrayList<Integer> numList = new ArrayList<Integer>();
		for(CourseVO vo : courseList) {
			numList.add(vo.getCourse_num());
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("numList", numList);
		ArrayList<SiteVO> siteList = travelDAO.siteList(map);
		int listCount = travelDAO.getCountCourse(course_area);
		
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
		
		model.addAttribute("course_area", course_area);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("courseList", courseList);
		model.addAttribute("siteList", siteList);
		
		return "./travel/course_list";
	}	
}
