package com.spring.altaltal;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FeedbackDAOService implements FeedbackDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insertFeedback(FeedbackVO vo) {
		FeedbackMapper feedbackMapper = sqlSession.getMapper(FeedbackMapper.class);
		int max = feedbackMapper.getMaxFeedbackNum();
		vo.setFeedback_num(max+1);
		int res = feedbackMapper.insertFeedback(vo);
		
		return res;
	}
	
	@Override
	public ArrayList<FeedbackVO> getFeedbackList(int page, int limit) {
		FeedbackMapper feedbackMapper = sqlSession.getMapper(FeedbackMapper.class);
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		ArrayList<FeedbackVO> feedbackList = feedbackMapper.getFeedbackList(map);
		System.out.println("getFeedbackList() : " + feedbackList.size());

		return feedbackList;
	}
	
	@Override
	public int getCountFeedback() {
		FeedbackMapper feedbackMapper = sqlSession.getMapper(FeedbackMapper.class);
		int res = feedbackMapper.getCountFeedback();
		System.out.println("getCountFeedback() :  " + res);
		
		return res;
	}
	
	@Override
	public FeedbackVO getFeedback(int feedback_num) {
		FeedbackMapper feedbackMapper = sqlSession.getMapper(FeedbackMapper.class);
		FeedbackVO vo = feedbackMapper.getFeedback(feedback_num);
		System.out.println("getFeedback() :  " + vo);
		
		return vo;
	}
	
	@Override
	public int updateFeedback(int feedback_num, String status) {
		FeedbackMapper feedbackMapper = sqlSession.getMapper(FeedbackMapper.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("feedback_num", feedback_num);
		map.put("status", status);
		int res = feedbackMapper.updateFeedback(map);
		System.out.println("updateFeedback() :  " + res);
		
		return res;
	}
	
	@Override
	public int deleteFeedback(int feedback_num) {
		FeedbackMapper feedbackMapper = sqlSession.getMapper(FeedbackMapper.class);
		int res = feedbackMapper.deleteFeedback(feedback_num);
		System.out.println("deleteFeedback() :  " + res);
		
		return res;
	}
}
