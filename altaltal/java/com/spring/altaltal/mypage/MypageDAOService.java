package com.spring.altaltal.mypage;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.altaltal.freeboard.FreeboardVO;
import com.spring.altaltal.hotplace.HotplaceVO;
import com.spring.altaltal.makguli.MakguliVO;
import com.spring.altaltal.member.MemberVO;

@Service
public class MypageDAOService implements MypageDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public MemberVO getMember(String email) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		MemberVO vo = mypageMapper.getMember(email);
		
		return vo;
	}
	
	@Override
	public int updateMember(MemberVO vo) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		int res = mypageMapper.updateMember(vo);
	
		return res;
	}
	
	@Override
	public int deleteMember(String email) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		int check = mypageMapper.deleteMember(email);
		
		return check;
	}
	
	@Override
	public int confirmNickname(String nickname) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		int check = mypageMapper.confirmNickname(nickname);
		return check;
	}
	
	@Override
	public ArrayList<FreeboardVO> getMemberBoardList(int page, int limit, String nickname) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("nickname", nickname);
		ArrayList<FreeboardVO> memberboardList = mypageMapper.getMemberBoardList(map);
		return memberboardList;
	}
	
	@Override
	public int getCountMemberBoard(String nickname) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		int res = mypageMapper.getCountMemberBoard(nickname);
		return res;
	}
	
	@Override
	public FreeboardVO getBoard(int free_num) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		FreeboardVO article = mypageMapper.getBoard(free_num);
		return article;
	}
	
	@Override
	public ArrayList<FreeboardVO> searchArticles(int page, int limit, String nickname, String topic, String keyword){
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("keyword", keyword);
		map.put("topic", topic);
		map.put("nickname", nickname);
		ArrayList<FreeboardVO> articleList = mypageMapper.getSearchArticles(map);

		return articleList;
	}
	
	@Override
	public int getCountSearchArticle(String nickname, String topic, String keyword) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		System.out.println("search topic : " + topic);
		map.put("keyword", keyword);
		map.put("topic", topic);
		map.put("nickname", nickname);
		int res = mypageMapper.getCountSearchArticle(map);
		System.out.println("search num : " + res);
		
		return res;
	}
	
	@Override
	public ArrayList<MakguliVO> mypageMakguliList(int page, int limit, String email, String topic, String keyword) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<MakguliVO> myMakguliList = null;
		String userLikes = mypageMapper.getMakguliList(email);
		if(userLikes.equals("not") || userLikes == null) {
			return myMakguliList;
		}
		
		String[] userLikesArray = userLikes.split("/");
		for(String test : userLikesArray) {
			System.out.println("test list : " + test);
		}
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("likeList", userLikesArray);
		map.put("topic", topic);
		map.put("keyword", keyword);
		myMakguliList = mypageMapper.mypageMakguliList(map);
		System.out.println("mypageMakguliList() : " + myMakguliList.size());
		
		
		return myMakguliList;
	}
	
	@Override
	public int  getCountMyMakguli(String email, String topic, String keyword) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String userLikes = mypageMapper.getMakguliList(email);
		String[] userLikesArray = userLikes.split("/");
		map.put("likeList", userLikesArray);
		map.put("topic", topic);
		map.put("keyword", keyword);
		int res  = mypageMapper.getCountMyMakguli(map);
		System.out.println("getCountMyMakguli() : " + res);
			
		return res;
	}
	
	@Override
	public ArrayList<HotplaceVO> mypagePlaceList(int page, int limit, String email, String topic, String keyword) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HotplaceVO> myPlaceList = null;
		String userLikes = mypageMapper.getPlaceList(email);
		if(userLikes.equals("not") || userLikes == null) {
			return myPlaceList;
		}
		
		String[] userLikesArray = userLikes.split("/");
		for(String test : userLikesArray) {
			System.out.println("test list : " + test);
		}
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("likeList", userLikesArray);
		map.put("topic", topic);
		map.put("keyword", keyword);
		myPlaceList = mypageMapper.mypagePlaceList(map);
		System.out.println("mypagePlaceList() : " + myPlaceList.size());
		
		
		return myPlaceList;
	}
	
	@Override
	public int  getCountMyPlace(String email, String topic, String keyword) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String userLikes = mypageMapper.getMakguliList(email);
		String[] userLikesArray = userLikes.split("/");
		map.put("likeList", userLikesArray);
		map.put("topic", topic);
		map.put("keyword", keyword);
		int res  = mypageMapper.getCountMyPlace(map);
		System.out.println("getCountMyPlace() : " + res);
			
		return res;
	}
	
	@Override
	public ArrayList<HashMap<String, Object>> myMakguliCommentList(int page, int limit, String nickname, String topic, String keyword){
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("keyword", keyword);
		map.put("topic", topic);
		map.put("nickname", nickname);
		ArrayList<HashMap<String, Object>> commentList = mypageMapper.myMakguliCommentList(map);
		System.out.println("myMakguliCommentList : " + commentList.size());

		return commentList;
	}
	
	@Override
	public int  getCountCommntMakguli(String nickname, String topic, String keyword) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("nickname", nickname);
		map.put("topic", topic);
		map.put("keyword", keyword);
		int res  = mypageMapper.getCountCommntMakguli(map);
		System.out.println("getCountCommntMakguli() : " + res);
			
		return res;
	}
	
	@Override
	public ArrayList<HashMap<String, Object>> myPlaceCommentList(int page, int limit, String nickname, String topic, String keyword){
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("keyword", keyword);
		map.put("topic", topic);
		map.put("nickname", nickname);
		ArrayList<HashMap<String, Object>> commentList = mypageMapper.myPlaceCommentList(map);
		System.out.println("myPlaceCommentList : " + commentList.size());

		return commentList;
	}
	
	@Override
	public int  getCountCommntPlace(String nickname, String topic, String keyword) {
		MypageMapper mypageMapper = sqlSession.getMapper(MypageMapper.class);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("nickname", nickname);
		map.put("topic", topic);
		map.put("keyword", keyword);
		int res  = mypageMapper.getCountCommntPlace(map);
		System.out.println("getCountCommntPlace() : " + res);
			
		return res;
	}
}
