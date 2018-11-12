package com.spring.altaltal.travel;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TravelDAOService implements TravelDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<CourseVO> courseList(int page, int limit, String course_area, String keyword){
		TravelMapper travelMapper = sqlSession.getMapper(TravelMapper.class);
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("course_area", course_area);
		map.put("keyword", keyword);
		ArrayList<CourseVO> courseList = travelMapper.courseList(map);
		System.out.println("courseList : " + courseList.size());
		
		return courseList;
	}
	
	@Override
	public int getCountCourse(String course_area){
		TravelMapper travelMapper = sqlSession.getMapper(TravelMapper.class);
		int res = travelMapper.getCountCourse(course_area);
		System.out.println("getCountCourse : " + res);
		
		return res;
	}
	
	@Override
	public ArrayList<SiteVO> siteList(HashMap<String, Object> map){
		TravelMapper travelMapper = sqlSession.getMapper(TravelMapper.class);
		System.out.println("map : " + map.size());
		ArrayList<SiteVO> siteList = travelMapper.siteList(map);
		System.out.println("siteList : " + siteList.size());
		
		return siteList;
	}
	
	@Override
	public ArrayList<SiteVO> siteListNum(int course_num){
		TravelMapper travelMapper = sqlSession.getMapper(TravelMapper.class);
		ArrayList<SiteVO> siteList = travelMapper.siteListNum(course_num);
		System.out.println("siteList : " + siteList.size());
		
		return siteList;
	}

}
