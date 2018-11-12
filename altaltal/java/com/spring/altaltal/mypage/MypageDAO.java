package com.spring.altaltal.mypage;

import java.util.ArrayList;
import java.util.HashMap;

import com.spring.altaltal.freeboard.FreeboardVO;
import com.spring.altaltal.hotplace.HotplaceVO;
import com.spring.altaltal.makguli.MakguliVO;
import com.spring.altaltal.member.MemberVO;

public interface MypageDAO {
	MemberVO getMember(String email);
	int updateMember(MemberVO vo);
	int deleteMember(String email);
	int confirmNickname(String nickname);
	ArrayList<FreeboardVO> getMemberBoardList(int page, int limit, String nickname);
	int getCountMemberBoard(String nickname);
	FreeboardVO getBoard(int free_num);
	ArrayList<FreeboardVO> searchArticles(int page, int limit, String nickname, String topic, String keyword);
	int getCountSearchArticle(String nickname, String topic, String keyword);
	ArrayList<MakguliVO> mypageMakguliList(int page, int limit, String email, String topic, String keyword);
	int getCountMyMakguli(String email, String topic, String keyword);
	ArrayList<HotplaceVO> mypagePlaceList(int page, int limit, String email, String topic, String keyword);
	int getCountMyPlace(String email, String topic, String keyword);
	ArrayList<HashMap<String, Object>> myMakguliCommentList(int page, int limit, String nickname, String topic, String keyword);
	int getCountCommntMakguli(String nickname, String topic, String keyword);
	ArrayList<HashMap<String, Object>> myPlaceCommentList(int page, int limit, String nickname, String topic, String keyword);
	int getCountCommntPlace(String nickname, String topic, String keyword);
}
