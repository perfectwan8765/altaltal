package com.spring.altaltal.admin;

import java.util.ArrayList;
import java.util.HashMap;

import com.spring.altaltal.hotplace.HotplaceVO;
import com.spring.altaltal.makguli.MakguliVO;
import com.spring.altaltal.member.MemberVO;
import com.spring.altaltal.travel.CourseVO;
import com.spring.altaltal.travel.SiteVO;

public interface AdminMapper {
	ArrayList<MemberVO> membersList(HashMap<String, Object> map);
	int getCountMember(HashMap<String, String> map);
	ArrayList<MakguliVO> adminMakguliList(HashMap<String, Object> map);
	int getCountMakguli(HashMap<String, String> map);
	int getMaxMakguliNum();
	int insertMakguli(MakguliVO vo);
	ArrayList<HotplaceVO> adminPlaceList(HashMap<String, Object> map);
	int getCountPlace(HashMap<String, String> map);
	int getMaxPlaceNum();
	int insertPlace(HotplaceVO vo);
	ArrayList<CourseVO> adminCourseList(HashMap<String, Object> map);
	int getCountCourse(HashMap<String, String> map);
	int getMaxCourseNum();
	int insertCourse(CourseVO vo);
	ArrayList<SiteVO> getSiteList(int course_num);
	CourseVO getCourse(int course_num);
	int insertSite(SiteVO vo);
	SiteVO getSite(int site_num);
	MakguliVO getMakguli(int makguli_num);
	int updateMakguli(MakguliVO vo);
	int makguliDelete(int makguli_num);
	HotplaceVO getPlace(int place_num);
	int updatePlace(HotplaceVO vo);
	int deletePlace(int place_num);
	int updateSite(SiteVO vo);
	int siteDelete(int site_num);
	int getMaxSiteNum();
	int deleteCourse(int course_num);
}
