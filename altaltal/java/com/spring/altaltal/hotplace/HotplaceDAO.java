package com.spring.altaltal.hotplace;

import java.util.ArrayList;
import java.util.HashMap;

public interface HotplaceDAO {
	
	ArrayList<HotplaceVO> getPlaceList(int page, int limit, String place_area, String keyword);
	HotplaceVO getPlace(HotplaceVO vo);
	int getCountHotplace(String place_area);
	ArrayList<HashMap<String, Object>> getCommentList(int page, int limit, int place_num);
	int getCountComment(int place_num);
	int insertPlaceComment(PlaceboardVO vo);
	int deletePlaceComment(PlaceboardVO vo);
	int updatePlaceComment(PlaceboardVO vo);
	HashMap<String, Double> evaluatePlace(int place_num);
	String getPlaceUrl(int place_num);
	String placeLikeCheck(String member_email, int place_num);
	HashMap<String, Object> placeLikeUpdate(String member_email, int place_num, String userLike);

}
