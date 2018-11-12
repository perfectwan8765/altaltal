package com.spring.altaltal.admin;

import java.util.ArrayList;

import com.spring.altaltal.hotplace.HotplaceVO;
import com.spring.altaltal.makguli.MakguliVO;
import com.spring.altaltal.member.MemberVO;
import com.spring.altaltal.travel.CourseVO;
import com.spring.altaltal.travel.SiteVO;

public interface AdminDAO {
	ArrayList<MemberVO> membersList(int page, int limit, String topic, String keyword);
	int getCountMember(String topic, String keyword);
	ArrayList<MakguliVO> adminMakguliList(int page, int limit, String topic, String keyword);
	int getCountMakguli(String topic, String keyword);
	int insertMakguli(MakguliVO vo);
	ArrayList<HotplaceVO> adminPlaceList(int page, int limit, String topic, String keyword);
	int getCountPlace(String topic, String keyword);
	int insertPlace(HotplaceVO vo);
	ArrayList<CourseVO> adminCourseList(int page, int limit, String topic, String keyword);
	int getCountCourse(String topic, String keyword);
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
	int deleteCourse(int course_num);
}
