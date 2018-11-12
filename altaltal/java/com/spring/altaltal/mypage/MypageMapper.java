package com.spring.altaltal.mypage;

import java.util.ArrayList;
import java.util.HashMap;

import com.spring.altaltal.freeboard.FreeboardVO;
import com.spring.altaltal.hotplace.HotplaceVO;
import com.spring.altaltal.makguli.MakguliVO;
import com.spring.altaltal.member.MemberVO;

public interface MypageMapper {
	MemberVO getMember(String email);
	int updateMember(MemberVO vo);
	int deleteMember(String email);
	int confirmNickname(String nickname);
	ArrayList<FreeboardVO> getMemberBoardList(HashMap<String, Object> map);
	int getCountMemberBoard(String email);
	FreeboardVO getBoard(int free_num);
	ArrayList<FreeboardVO> getSearchArticles(HashMap<String, Object> map);
	int getCountSearchArticle(HashMap<String, Object> map);
	String getMakguliList(String email);
	ArrayList<MakguliVO> mypageMakguliList(HashMap<String, Object> map);
	int getCountMyMakguli(HashMap<String, Object> map);
	String getPlaceList(String email);
	ArrayList<HotplaceVO> mypagePlaceList(HashMap<String, Object> map);
	int getCountMyPlace(HashMap<String, Object> map);
	ArrayList<HashMap<String, Object>> myMakguliCommentList(HashMap<String, Object> map);
	int getCountCommntMakguli(HashMap<String, String> map);
	ArrayList<HashMap<String, Object>> myPlaceCommentList(HashMap<String, Object> map);
	int getCountCommntPlace(HashMap<String, String> map);
}
