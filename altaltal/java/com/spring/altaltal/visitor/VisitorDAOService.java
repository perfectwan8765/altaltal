package com.spring.altaltal.visitor;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("visitorDAOService")
public class VisitorDAOService implements VisitorDAO{
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void insertVisitor(String agent) {
		VisitorMapper visitorMapper = sqlSession.getMapper(VisitorMapper.class);
		System.out.println("VisitorDAOService");
		
		int res = visitorMapper.insertVisitor(agent);
		System.out.println("inserVisitor check : " + res);
	}
	
	@Override
	public HashMap<String, Object> getMainInfo() {
		VisitorMapper visitorMapper = sqlSession.getMapper(VisitorMapper.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int visitor = visitorMapper.getMaxNum();
		int member = visitorMapper.getCountMember();
		int makguliSum = visitorMapper.getLikeMakguli();
		int placeSum = visitorMapper.getLikePlace();
		int likeCount = makguliSum + placeSum;
		int boardCount = visitorMapper.getCountMakguli() + visitorMapper.getCountPlace()
		+ visitorMapper.getCountSite() + visitorMapper.getCountCourse();
		
		map.put("visitor", visitor);
		map.put("member", member);
		map.put("likecount", likeCount);
		map.put("boardcount", boardCount);
		System.out.println("getMainInfo : " + map.size());
		
		return map;
	}
	
}
