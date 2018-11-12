package com.spring.altaltal.freeboard;

import java.util.ArrayList;
import java.util.HashMap;

public interface FreeboardDAO {
	
		ArrayList<FreeboardVO> getMainBoardList(int page, int limit, String topic, String keyword);
		int getCountMainBoard(String topic, String keyword);
		ArrayList<HashMap<String, Object>> getReplyBoardList(int free_num);
		FreeboardVO getBoard(int free_num);
		int insertBoard(FreeboardVO vo);
		int updateBoard(FreeboardVO vo);
		int deleteArticle(FreeboardVO vo);
		int deleteComment(FreeboardVO vo);
		int updateComment(FreeboardVO vo);
}
