package com.spring.altaltal.travel;

import java.util.ArrayList;
import java.util.HashMap;

public interface TravelDAO {

	ArrayList<CourseVO> courseList(int page, int limit, String course_area, String keyword);
	int getCountCourse(String course_area);
	ArrayList<SiteVO> siteList(HashMap<String, Object> map);
	ArrayList<SiteVO> siteListNum(int course_num);
}
