package com.spring.altaltal.makguli;

import java.util.ArrayList;
import java.util.HashMap;

public interface MakguliDAO {
		
	ArrayList<MakguliVO> getMakguliList(int page, int limit, String makguli_area, String keyword);
	int getCountMakguli(String makguli_area);
	MakguliVO getMakguli(int makguli_num);
	ArrayList<HashMap<String, Object>> getCommentList(int page, int limt, int makguli_num);
	int getCountComment(int makguli_num);
	int insertMakguliComment(MakguliboardVO vo);
	String userLikeCheck(String member_email, int makguli_num);
	HashMap<String, Object> userLikeUpdate(String member_email, int makguli_num, String userLike);
	int updateMakguliComment(MakguliboardVO vo);
	int deleteMakguliComment(MakguliboardVO vo);
}
