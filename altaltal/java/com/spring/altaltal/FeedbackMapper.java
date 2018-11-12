package com.spring.altaltal;

import java.util.ArrayList;
import java.util.HashMap;

public interface FeedbackMapper {

	int insertFeedback(FeedbackVO vo);
	int getMaxFeedbackNum();
	ArrayList<FeedbackVO> getFeedbackList(HashMap<String, Integer> map);
	int getCountFeedback();
	FeedbackVO getFeedback(int feedback_num);
	int updateFeedback(HashMap<String, Object> map);
	int deleteFeedback(int feedback_num);
}
