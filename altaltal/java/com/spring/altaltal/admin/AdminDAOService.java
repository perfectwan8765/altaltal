package com.spring.altaltal.admin;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.altaltal.hotplace.HotplaceVO;
import com.spring.altaltal.makguli.MakguliVO;
import com.spring.altaltal.member.MemberVO;
import com.spring.altaltal.travel.CourseVO;
import com.spring.altaltal.travel.SiteVO;

@Service
public class AdminDAOService implements AdminDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<MemberVO> membersList(int page, int limit, String topic, String keyword) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("topic", topic);
		map.put("keyword", keyword);
		ArrayList<MemberVO> memberslist = adminMapper.membersList(map);
		System.out.println("admin List() : " + memberslist.size());
		
		return memberslist;
	}
	
	@Override
	public int getCountMember(String topic, String keyword) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("topic", topic);
		map.put("keyword", keyword);
		int res = adminMapper.getCountMember(map);
		System.out.println("admin memberCount() : " + res);
		
		return res;
	}
	
	@Override
	public ArrayList<MakguliVO> adminMakguliList(int page, int limit, String topic, String keyword) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("topic", topic);
		map.put("keyword", keyword);
		ArrayList<MakguliVO> makguliList = adminMapper.adminMakguliList(map);
		System.out.println("admin makguliList() : " + makguliList.size());
		
		return makguliList;
	}
	
	@Override
	public int getCountMakguli(String topic, String keyword) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("topic", topic);
		map.put("keyword", keyword);
		int res = adminMapper.getCountMakguli(map);
		System.out.println("admin getCountMakguli() : " + res);
		
		return res;
	}
	
	@Override
	public int insertMakguli(MakguliVO vo) {
		if(vo.getMakguli_picture() == null) {
			vo.setMakguli_picture("");
		}
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int max = adminMapper.getMaxMakguliNum();
		vo.setMakguli_num(max+1);
		int res = adminMapper.insertMakguli(vo);
		System.out.println("admin insertMakguli() : " + res);
		
		return res;
	}
	
	@Override
	public ArrayList<HotplaceVO> adminPlaceList(int page, int limit, String topic, String keyword) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("topic", topic);
		map.put("keyword", keyword);
		ArrayList<HotplaceVO> placeList = adminMapper.adminPlaceList(map);
		System.out.println("admin adminPlaceList() : " + placeList.size());
		
		return placeList;
	}
	
	@Override
	public int getCountPlace(String topic, String keyword) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("topic", topic);
		map.put("keyword", keyword);
		int res = adminMapper.getCountPlace(map);
		System.out.println("admin getCountPlace() : " + res);
		
		return res;
	}
	
	@Override
	public int insertPlace(HotplaceVO vo) {
		if(vo.getPlace_picture().equals("//")) {
			vo.setPlace_picture("");
		}
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int max = adminMapper.getMaxPlaceNum();
		vo.setPlace_num(max+1);
		int res = adminMapper.insertPlace(vo);
		System.out.println("admin insertPlace() : " + res);
		
		return res;
	}
	
	@Override
	public ArrayList<CourseVO> adminCourseList(int page, int limit, String topic, String keyword) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("topic", topic);
		map.put("keyword", keyword);
		ArrayList<CourseVO> courseList = adminMapper.adminCourseList(map);
		System.out.println("adminCourseList() : " + courseList.size());
		
		return courseList;
	}
	
	@Override
	public int getCountCourse(String topic, String keyword) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("topic", topic);
		map.put("keyword", keyword);
		int res = adminMapper.getCountCourse(map);
		System.out.println("admin getCountCourse() : " + res);
		
		return res;
	}
	
	@Override
	public int insertCourse(CourseVO vo) {
		if(vo.getCourse_picture() == null){
			vo.setCourse_picture("");
		}
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int max = adminMapper.getMaxCourseNum();
		vo.setCourse_num(max+1);
		int res = adminMapper.insertCourse(vo);
		System.out.println("admin insertCourse() : " + res);
		
		return res;
	}
	
	@Override
	public ArrayList<SiteVO> getSiteList(int course_num) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		ArrayList<SiteVO> siteList = adminMapper.getSiteList(course_num);
		System.out.println("Admin getSiteList() : " + siteList.size());
		
		return siteList;
	}
	
	@Override
	public CourseVO getCourse(int course_num) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		CourseVO vo = adminMapper.getCourse(course_num);
		System.out.println("Admin getCourse() : " + vo.toString());
		
		return vo;
	}
	
	@Override
	public int insertSite(SiteVO vo) {
		if(vo.getSite_picture() == null){
			vo.setSite_picture("");
		}
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int max = adminMapper.getMaxSiteNum();
		vo.setSite_num(max+1);
		int res = adminMapper.insertSite(vo);
		System.out.println("admin insertSite() : " + res);
		
		return res;
	}
	
	@Override
	public SiteVO getSite(int site_num) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		SiteVO vo = adminMapper.getSite(site_num);
		System.out.println("Admin getSite() : " + vo.toString());
		
		return vo;
	}
	
	@Override
	public MakguliVO getMakguli(int makguli_num) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		MakguliVO vo = adminMapper.getMakguli(makguli_num);
		System.out.println("Admin getMakguli() : " + vo.toString());
		
		return vo;
	}
	
	@Override
	public int updateMakguli(MakguliVO vo) {
		if(vo.getMakguli_picture() == null){
			vo.setMakguli_picture("");
		}
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int res = adminMapper.updateMakguli(vo);
		System.out.println("admin updateMakguli() : " + res);
		
		return res;
	}
	
	@Override
	public int makguliDelete(int makguli_num) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int res = adminMapper.makguliDelete(makguli_num);
		System.out.println("admin makguliDelete() : " + res);
		
		return res;
	}
	
	@Override
	public HotplaceVO getPlace(int place_num) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		HotplaceVO vo = adminMapper.getPlace(place_num);
		System.out.println("Admin getPlace() : " + vo.toString());
		
		return vo;
	}
	
	@Override
	public int updatePlace(HotplaceVO vo) {
		if(vo.getPlace_picture() == null){
			vo.setPlace_picture("");
		}
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int res = adminMapper.updatePlace(vo);
		System.out.println("admin updatePlace() : " + res);
		
		return res;
	}
	
	@Override
	public int deletePlace(int place_num) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int res = adminMapper.deletePlace(place_num);
		System.out.println("admin deletePlace() : " + res);
		
		return res;
	}
	
	@Override
	public int updateSite(SiteVO vo) {
		if(vo.getSite_picture() == null){
			vo.setSite_picture("");
		}
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int res = adminMapper.updateSite(vo);
		System.out.println("admin updateSite() : " + res);
		
		return res;
	}
	
	@Override
	public int siteDelete(int site_num) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int res = adminMapper.siteDelete(site_num);
		System.out.println("admin siteDelete() : " + res);
		
		return res;
	}
	
	@Override
	public int deleteCourse(int course_num) {
		AdminMapper adminMapper = sqlSession.getMapper(AdminMapper.class);
		int res = adminMapper.deleteCourse(course_num);
		System.out.println("admin deleteCourse() : " + res);
		
		return res;
	}
}
