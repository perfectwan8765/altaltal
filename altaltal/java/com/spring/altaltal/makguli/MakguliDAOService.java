package com.spring.altaltal.makguli;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class MakguliDAOService implements MakguliDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<MakguliVO> getMakguliList(int page, int limit, String makguli_area, String keyword) {
		if(keyword == null) {
			keyword = "";
		}
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("makguli_area", makguli_area);
		map.put("keyword", keyword);
		MakguliMapper makguliMapper = sqlSession.getMapper(MakguliMapper.class);
		ArrayList<MakguliVO> makguliList = makguliMapper.getMakguliList(map);
		System.out.println("getMakguliList : " + makguliList.size());
		
		return makguliList;
	}
	
	@Override
	public int getCountMakguli(String makguli_area) {
		MakguliMapper makguliMapper = sqlSession.getMapper(MakguliMapper.class);
		int res = makguliMapper.getCountMakguli(makguli_area);
		System.out.println("getCountMakguli : " + res);
		
		return res;
	}
	
	@Override
	public MakguliVO getMakguli(int makguli_num) {
		MakguliMapper makguliMapper = sqlSession.getMapper(MakguliMapper.class);
		int check = makguliMapper.upCountMakguli(makguli_num);
		System.out.println("upCountMakguli : " + check);
		MakguliVO vo = makguliMapper.getMakguli(makguli_num);
		System.out.println("getMakguli : " + vo.toString());
		
		return vo;
	}
	
	@Override
	public ArrayList<HashMap<String, Object>> getCommentList(int page, int limit, int makguli_num) {
		MakguliMapper makguliMapper = sqlSession.getMapper(MakguliMapper.class);
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("makguli_num", makguli_num);
		ArrayList<HashMap<String, Object>> commentList = makguliMapper.getCommentList(map);
		System.out.println("getCommentList : " + commentList.size());

		return commentList;
	}
	
	@Override
	public int getCountComment(int makguli_num) {
		MakguliMapper makguliMapper = sqlSession.getMapper(MakguliMapper.class);
		int res  = makguliMapper.getCountComment(makguli_num);
		System.out.println("makguli getCountComment : " + res);
		
		return res;
	}
	
	@Override
	public int insertMakguliComment(MakguliboardVO vo) {
		MakguliMapper makguliMapper = sqlSession.getMapper(MakguliMapper.class);
		int max = makguliMapper.getCountMaxComment();
		vo.setMboard_num(max+1);
		int res = makguliMapper.insertMakguliComment(vo);
		System.out.println("insertMakguliComment : " + res);

		return res;
	}

	@Override
	public String userLikeCheck(String member_email, int makguli_num){
		MakguliMapper makguliMapper = sqlSession.getMapper(MakguliMapper.class);
		String userLikes = makguliMapper.getUserLikes(member_email);
		if(userLikes.equals("not")) {
			return "n";
		}else {
			String[] userLikesArray = userLikes.split("/");
			for(String like : userLikesArray) {
				if(Integer.parseInt(like) == makguli_num) {
					return "y";
				}	
			}
			return "n";
		}
	}
	
	@Override
	public HashMap<String, Object> userLikeUpdate(String member_email, int makguli_num, String userLike){
		MakguliMapper makguliMapper = sqlSession.getMapper(MakguliMapper.class);
		String userLikes = makguliMapper.getUserLikes(member_email);
		HashMap<String, String> map = new HashMap<String, String>();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String newUserLikes = "";
		String makguli_num_string = String.valueOf(makguli_num);
		System.out.println("userLikes : " + userLikes);
		System.out.println("userLike : " + userLike);
		if(userLikes.equals("not")) {	
			map.put("member_email", member_email);
			map.put("member_makguli", makguli_num_string+"/");
			makguliMapper.updateUserLike(map);
			makguliMapper.upLikeCount(makguli_num);
			int res = makguliMapper.getMaguliLike(makguli_num);
			resultMap.put("status", "y");
			resultMap.put("likecount", res);
			
			return resultMap;
		}else {
			if(userLike.equals("y")) {
				String[] userLikesArray = userLikes.split("/");
				for(String like : userLikesArray) {
					if(Integer.parseInt(like) == makguli_num) {
						continue;
					}	
					newUserLikes += like +"/";
				}
				map.put("member_email", member_email);
				map.put("member_makguli", newUserLikes);
				makguliMapper.updateUserLike(map);
				makguliMapper.downLikeCount(makguli_num);
				int res = makguliMapper.getMaguliLike(makguli_num);
				resultMap.put("status", "n");
				resultMap.put("likecount", res);
				
				return resultMap;
			}else {
				newUserLikes =userLikes+makguli_num_string+"/";
				map.put("member_email", member_email);
				map.put("member_makguli", newUserLikes);
				makguliMapper.updateUserLike(map);
				makguliMapper.upLikeCount(makguli_num);
				int res = makguliMapper.getMaguliLike(makguli_num);
				resultMap.put("status", "y");
				resultMap.put("likecount", res);
				
				return resultMap;
			}
		}
	}
	
	@Override
	public int updateMakguliComment(MakguliboardVO vo) {
		MakguliMapper makguliMapper = sqlSession.getMapper(MakguliMapper.class);
		int res = makguliMapper.updateMakguliComment(vo);
		System.out.println("updateMakguliComment : " + res);
		return res;
	}
	
	@Override
	public int deleteMakguliComment(MakguliboardVO vo) {
		MakguliMapper makguliMapper = sqlSession.getMapper(MakguliMapper.class);
		int res = makguliMapper.deleteMakguliComment(vo);
		System.out.println("deleteMakguliComment : " + res);
		return res;
	}
}
