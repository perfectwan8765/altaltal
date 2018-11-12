package com.spring.altaltal;

import java.util.ArrayList;

public interface FeedbackDAO {
	
	int insertFeedback(FeedbackVO vo);
	ArrayList<FeedbackVO> getFeedbackList(int page, int limit);
	int getCountFeedback();
	FeedbackVO getFeedback(int feedback_num);
	int updateFeedback(int feedback_num, String status);
	int deleteFeedback(int feedback_num);	
}
