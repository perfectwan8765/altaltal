package com.spring.altaltal.makguli;

import java.util.ArrayList;
import java.util.HashMap;

public interface MakguliMapper {
	
	ArrayList<MakguliVO> getMakguliList(HashMap<String, Object> map);
	int getCountMakguli(String makguli_area);
	MakguliVO getMakguli(int makguli_num);
	int upCountMakguli(int makguli_num);
	ArrayList<HashMap<String, Object>> getCommentList(HashMap<String, Integer> map);
	int getCountComment(int makguli_num);
	int insertMakguliComment(MakguliboardVO vo);
	int getCountMaxComment();
	String getUserLikes(String member_email);
	int updateUserLike(HashMap<String, String> map);
	int upLikeCount(int makguli_num);
	int downLikeCount(int makguli_num);
	int getMaguliLike(int makguli_num);
	int updateMakguliComment(MakguliboardVO vo);
	int deleteMakguliComment(MakguliboardVO vo);
}
