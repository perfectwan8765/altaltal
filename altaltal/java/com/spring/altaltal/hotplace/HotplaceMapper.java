package com.spring.altaltal.hotplace;

import java.util.ArrayList;
import java.util.HashMap;

public interface HotplaceMapper {

	ArrayList<HotplaceVO> getPlaceList(HashMap<String, Object> map);
	HotplaceVO getPlace(int place_num);
	int getCountHotplace(String place_area);
	ArrayList<HashMap<String, Object>> getCommentList(HashMap<String, Integer> map);
	int getCountComment(int place_num);
	int insertPlaceComment(PlaceboardVO vo);
	int deletePlaceComment(int pboard_num);
	int updatePlaceComment(PlaceboardVO vo);
	int upCountPlace(int place_num);
	String likecheck(String email);
	int getLikeCount(int place_num);
	int getCountMaxComment();
	int memberLikeUp(HashMap<String, String> map);
	HashMap<String, Double> evaluatePlace(int place_num);
	String getPlaceUrl(int place_num);
	String getPlaceLikes(String member_email);
	int updatePlaceLike(HashMap<String, String> map);
	int upPlaceLikeCount(int place_num);
	int downPlaceLikeCount(int place_num);
	int getPlaceLike(int place_num);
}
