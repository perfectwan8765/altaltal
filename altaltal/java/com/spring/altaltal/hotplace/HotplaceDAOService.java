package com.spring.altaltal.hotplace;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HotplaceDAOService implements HotplaceDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<HotplaceVO> getPlaceList(int page, int limit, String place_area, String keyword) {
		if(keyword == null) {
			keyword = "";
		}
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		
		HotplaceMapper hotplaceMapper = sqlSession.getMapper(HotplaceMapper.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("place_area", place_area);
		map.put("keyword", keyword);
		ArrayList<HotplaceVO> placeList = hotplaceMapper.getPlaceList(map);
		
		return placeList;
	}
	
	@Override
	public int getCountHotplace(String place_area) {
		HotplaceMapper hotplaceMapper = sqlSession.getMapper(HotplaceMapper.class);
		int res = hotplaceMapper.getCountHotplace(place_area);
		System.out.println("hotplace getCount : " + res);
		return res;
	}
	
	@Override
	public HotplaceVO getPlace(HotplaceVO vo) {
		HotplaceMapper hotplaceMapper = sqlSession.getMapper(HotplaceMapper.class);
		int res = hotplaceMapper.upCountPlace(vo.getPlace_num());
		System.out.println("hotplace upCountPlace : " + res);
		HotplaceVO vo2 = hotplaceMapper.getPlace(vo.getPlace_num());
		return vo2;
	}
	
	@Override
	public ArrayList<HashMap<String, Object>> getCommentList(int page, int limit, int place_num) {
		HotplaceMapper hotplaceMapper = sqlSession.getMapper(HotplaceMapper.class);
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("place_num", place_num);
		ArrayList<HashMap<String, Object>> commentList = hotplaceMapper.getCommentList(map);
		System.out.println("hotplace getCommentList : " + commentList.size());
		return commentList;
	}
	
	@Override
	public int getCountComment(int place_num) {
		HotplaceMapper hotplaceMapper = sqlSession.getMapper(HotplaceMapper.class);
		int res  = hotplaceMapper.getCountComment(place_num);
		System.out.println("hotplace getCountComment : " + res);
		
		return res;
	}
	
	@Override
	public int insertPlaceComment(PlaceboardVO vo) {
		HotplaceMapper hotplaceMapper = sqlSession.getMapper(HotplaceMapper.class);
		int max = hotplaceMapper.getCountMaxComment();
		vo.setPboard_num(max+1);
		int res = hotplaceMapper.insertPlaceComment(vo);
		System.out.println("hotplace insertPlaceComment : " + res);
		return res;
	}
	
	@Override
	public int deletePlaceComment(PlaceboardVO vo) {
		HotplaceMapper hotplaceMapper = sqlSession.getMapper(HotplaceMapper.class);
		int res = hotplaceMapper.deletePlaceComment(vo.getPboard_num());
		System.out.println("hotplace deletePlaceComment : " + res);
		return res;
	}
	
	@Override
	public int updatePlaceComment(PlaceboardVO vo) {
		HotplaceMapper hotplaceMapper = sqlSession.getMapper(HotplaceMapper.class);
		int res = hotplaceMapper.updatePlaceComment(vo);
		System.out.println("hotplace updatePlaceComment : " + res);
		return res;
	}
	
	@Override
	public String placeLikeCheck(String member_email, int place_num){
		HotplaceMapper hotplaceMapper = sqlSession.getMapper(HotplaceMapper.class);
		String userLikes = hotplaceMapper.getPlaceLikes(member_email);
		if(userLikes.equals("not")) {
			return "n";
		}else {
			String[] userLikesArray = userLikes.split("/");
			for(String like : userLikesArray) {
				if(Integer.parseInt(like) == place_num) {
					return "y";
				}	
			}
			return "n";
		}
	}
	
	@Override
	public HashMap<String, Object> placeLikeUpdate(String member_email, int place_num, String userLike){
		HotplaceMapper hotplaceMapper = sqlSession.getMapper(HotplaceMapper.class);
		String userLikes = hotplaceMapper.getPlaceLikes(member_email);
		HashMap<String, String> map = new HashMap<String, String>();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String newUserLikes = "";
		String place_num_string = String.valueOf(place_num);
		System.out.println("userLikes : " + userLikes);
		System.out.println("userLike : " + userLike);
		if(userLikes.equals("not")) {	
			map.put("member_email", member_email);
			map.put("member_place", place_num_string+"/");
			hotplaceMapper.updatePlaceLike(map);
			hotplaceMapper.upPlaceLikeCount(place_num);
			int res = hotplaceMapper.getPlaceLike(place_num);
			resultMap.put("status", "y");
			resultMap.put("likecount", res);
			
			return resultMap;
		}else {
			if(userLike.equals("y")) {
				String[] userLikesArray = userLikes.split("/");
				for(String like : userLikesArray) {
					if(Integer.parseInt(like) == place_num) {
						continue;
					}	
					newUserLikes += like +"/";
				}
				map.put("member_email", member_email);
				map.put("member_place", newUserLikes);
				hotplaceMapper.updatePlaceLike(map);
				hotplaceMapper.downPlaceLikeCount(place_num);
				int res = hotplaceMapper.getPlaceLike(place_num);
				resultMap.put("status", "n");
				resultMap.put("likecount", res);
				
				return resultMap;
			}else {
				newUserLikes =userLikes+place_num_string+"/";
				map.put("member_email", member_email);
				map.put("member_place", newUserLikes);
				hotplaceMapper.updatePlaceLike(map);
				hotplaceMapper.upPlaceLikeCount(place_num);
				int res = hotplaceMapper.getPlaceLike(place_num);
				resultMap.put("status", "y");
				resultMap.put("likecount", res);
				
				return resultMap;
			}
		}
	}
	
	@Override
	public HashMap<String, Double> evaluatePlace(int place_num){
		HotplaceMapper hotplaceMapper = sqlSession.getMapper(HotplaceMapper.class);
		HashMap<String, Double> map = hotplaceMapper.evaluatePlace(place_num);
		
		return map;
	}
	
	@Override
	public String getPlaceUrl(int place_num){
		HotplaceMapper hotplaceMapper = sqlSession.getMapper(HotplaceMapper.class);
		String place_url = hotplaceMapper.getPlaceUrl(place_num);
		System.out.println("getPlaceUrl : " + place_url);
		
		return place_url;
	}
	
}
