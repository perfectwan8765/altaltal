package com.spring.altaltal.freeboard;

import java.util.ArrayList;
import java.util.HashMap;

public interface FreeboardMapper {
		
		ArrayList<FreeboardVO> getMainBoardList(HashMap<String, Object> map);
		ArrayList<HashMap<String, Object>> getReplyBoardList(int free_num);
		FreeboardVO getBoard(int free_num);
		int insertBoard(FreeboardVO vo);
		int insertReply(HashMap<String, Integer> map);
		int updateBoard(FreeboardVO vo);
		int deleteArticle(FreeboardVO vo);
		int deleteComment(FreeboardVO vo);
		int getCountMainBoard(HashMap<String, String> map);
		int getCountReplyBoard(int free_num);
		int upReadCountBoard(int free_num);
		int getMaxNumBoard();
		int updateComment(FreeboardVO vo);
}
