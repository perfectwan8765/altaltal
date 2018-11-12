package com.spring.altaltal.travel;

import java.util.ArrayList;
import java.util.HashMap;


public interface TravelMapper {
	ArrayList<CourseVO> courseList(HashMap<String, Object> map);
	int getCountCourse(String course_area);
	ArrayList<SiteVO> siteList(HashMap<String, Object> map);
	ArrayList<SiteVO> siteListNum(int course_num);

}
