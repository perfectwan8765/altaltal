package com.spring.altaltal.freeboard;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FreeboardDAOService implements FreeboardDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<FreeboardVO> getMainBoardList(int page, int limit, String topic, String keyword) {
		FreeboardMapper freeboardMapper = sqlSession.getMapper(FreeboardMapper.class);
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("topic", topic);
		map.put("keyword", keyword);
		System.out.println(startrow);
		System.out.println(endrow);
		ArrayList<FreeboardVO> MainboardList = freeboardMapper.getMainBoardList(map);
		return MainboardList;
	}
	
	@Override
	public int getCountMainBoard(String topic, String keyword) {
		FreeboardMapper freeboardMapper = sqlSession.getMapper(FreeboardMapper.class);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("topic", topic);
		map.put("keyword", keyword);
		int res = freeboardMapper.getCountMainBoard(map);
		return res;
	}

	@Override
	public ArrayList<HashMap<String, Object>> getReplyBoardList(int free_num) {
		FreeboardMapper freeboardMapper = sqlSession.getMapper(FreeboardMapper.class);
		ArrayList<HashMap<String, Object>> articleList = freeboardMapper.getReplyBoardList(free_num);
		System.out.println("DAO 메소드 : " +  articleList.size());
		return articleList;
	}

	@Override
	public FreeboardVO getBoard(int free_num) {
		FreeboardMapper freeboardMapper = sqlSession.getMapper(FreeboardMapper.class);
		freeboardMapper.upReadCountBoard(free_num);
		FreeboardVO vo = freeboardMapper.getBoard(free_num);
		return vo;
	}

	@Override
	public int insertBoard(FreeboardVO vo) {
		FreeboardMapper freeboardMapper = sqlSession.getMapper(FreeboardMapper.class);
		int num = freeboardMapper.getMaxNumBoard();
		num+=1;
		vo.setFree_num(num);
		
		if(vo.getFree_ref() != 0) {
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			map.put("free_ref", vo.getFree_ref());
			map.put("free_ref_seq", vo.getFree_ref_seq());
			int res = freeboardMapper.insertReply(map);
			System.out.println("insertReply : " + res);
			int free_ref_seq = vo.getFree_ref_seq()+1;
			int free_ref_level = vo.getFree_ref_level()+1;
			vo.setFree_ref_seq(free_ref_seq);
			vo.setFree_ref_level(free_ref_level);
			int res2 = freeboardMapper.insertBoard(vo);
			return res2;
		}
		
		vo.setFree_ref(num);
		int res1 = freeboardMapper.insertBoard(vo);
		return res1;
	}

	@Override
	public int updateBoard(FreeboardVO vo) {
		FreeboardMapper freeboardMapper = sqlSession.getMapper(FreeboardMapper.class);
		int res = freeboardMapper.updateBoard(vo);
		
		return res;
	}

	@Override
	public int deleteArticle(FreeboardVO vo) {
		FreeboardMapper freeboardMapper = sqlSession.getMapper(FreeboardMapper.class);
		int res = freeboardMapper.deleteArticle(vo);
		
		return res;
	}
	
	@Override
	public int deleteComment(FreeboardVO vo) {
		FreeboardMapper freeboardMapper = sqlSession.getMapper(FreeboardMapper.class);
		int res = freeboardMapper.deleteComment(vo);
		
		return res;
	}
	
	@Override
	public int updateComment(FreeboardVO vo) {
		FreeboardMapper freeboardMapper = sqlSession.getMapper(FreeboardMapper.class);
		int res = freeboardMapper.updateComment(vo);
		
		return res;
	}

}
