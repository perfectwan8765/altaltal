<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page import="com.spring.altaltal.makguli.MakguliVO"%>
<%@ page import="com.spring.altaltal.makguli.MakguliboardVO"%>
<%@ page import="com.spring.altaltal.freeboard.PageInfo"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	String email = "";
	if (session.getAttribute("email") != null) {
		email = (String) session.getAttribute("email");
	}
	
	String nickname = "";
	if (session.getAttribute("nickname") != null) {
		nickname = (String) session.getAttribute("nickname");
	}

	String keyword = (String) request.getAttribute("keyword");
	int nowPage = Integer.parseInt(request.getAttribute("page").toString());
	MakguliVO makguli = (MakguliVO) request.getAttribute("makguli");

	ArrayList<HashMap<String, Object>> mboardList = (ArrayList<HashMap<String, Object>>) request.getAttribute("mboardList");
	PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
	int listCount = pageInfo.getListCount();
	int commentPage = pageInfo.getPage();
	int maxPage = pageInfo.getMaxPage();
	int startPage = pageInfo.getStartPage();
	int endPage = pageInfo.getEndPage();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
	int sweatSum = 0;
	int sourSum = 0;
	int bodySum = 0;
	int sparkSum = 0;
	int popularSum = 0;
	double sweatAve = 0;
	double sourAve = 0;
	double bodyAve = 0;
	double sparkAve = 0;
	double popularAve = 0;

	if (mboardList.size() != 0) {
		for (int i = 0; i < mboardList.size(); i++) {
			sweatSum += Integer.parseInt(mboardList.get(i).get("mboard_sweat").toString());
			sourSum += Integer.parseInt(mboardList.get(i).get("mboard_sour").toString());
			bodySum += Integer.parseInt(mboardList.get(i).get("mboard_body").toString());
			sparkSum += Integer.parseInt(mboardList.get(i).get("mboard_spark").toString());
			popularSum += Integer.parseInt(mboardList.get(i).get("mboard_popular").toString());
		}

		sweatAve = sweatSum / mboardList.size();
		sourAve = sourSum / mboardList.size();
		bodyAve = bodySum / mboardList.size();
		sparkAve = sparkSum / mboardList.size();
		popularAve = popularSum / mboardList.size();
	}
%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpoint" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://cdn.zingchart.com/zingchart.min.js"></script>
<script>
		zingchart.MODULESDIR = "https://cdn.zingchart.com/modules/";
		ZC.LICENSE = ["569d52cefae586f634c54f86dc99e6a9","ee6b7db5b51705a13dc2339db3edaf6d"];
</script>

<title>Project Altaltal</title>
<style>
.all_body_content { 
   margin-bottom: 150px;
   min-height: 100%;
   margin-left: auto;
   margin-right: auto;
   width: 1060px;
}

.mg-mginfo {
   border: none;
   margin-bottom: 20px;
}

/*막걸리 타이틀 평점*/
.mg-list {
   height: 200px;
   border-bottom: 1px solid #dbdbdb;
}

.mg-title-roww{
 border-bottom: 1px solid #dbdbdb; 
 height: 80px;
 width: 100% !important;
}
.mg-title-header {
   height: 100%;
   padding-top : 20px;
   font-size: 33px;
}

.mg-title {
   font-size: 36px;
   height: 100%;
   padding: 10px 0;
}
.icons{
   font-size:18px;
}
.glyphicon-heart{
   color:red;
}
.mg-area {
   font-size: 17px;
   margin-left: 5px;
}

.mg-ratings {
   display: flex;
   font-size: 22px;
   height: 100%;
}

/*막걸리 설명*/
.mg-info {
   height: 100%;
   min-height: 210px;
   padding: 20px 30px 0 0;
   font-size: 15px;
}
.mg-line {
   margin-bottom: 20px;
}
/*설명 부분 글씨크기 일괄 조정*/
.allfont {
   font-size: 15px;
   color: rgb(143, 139, 139);
   height: 100%;
}

.mg-see {
   height: 100%;
   width: 100%;
}
/*막걸리 이미지*/
.mg-img {
   height: 350px;
   width: 100%
}
.mg-details{
	font-size: 15px;
	vertical-align: middle;
}

.mg-details img {
   width:25px;
   height:25px; 
}

.mg-img img {
   text-align: center;
   width: 100%;
   height: 100%;
   width: 100%;
}

/*목록가기버튼*/
#btn-list {
   float: right;
   position: absolute;
   top: 22px;
   right: 130px;
   z-index: 100;
}
.mg-content{
	padding-right:8px !important;
}
#btn-comment {
   float: right;
   position: absolute;
   top: 18px;
   right: 72px;
   z-index: 100;
}

#btn-like {
   float: right;
   position: absolute;
   top: 20px;
   right: 25px;
   z-index: 100;
}
/*막걸리 다이어그램*/
#myChart {
   height: 330px;
   width: 400px;
}

/*막걸리 한줄평가*/
.mg-comment {
   border: none;
   margin-top: 20px;
}
.comment-makguli-list {
   margin-left: -50px !important;
}

.comment-image-list {
   margin-left: -30px !important;
}

.panel-default {
   width: 95% !important;
}

.comment-nickname {
   margin-left: -80px !important;
}
.comment-updateform-article{
	display: none;
}
</style>
<script type="text/javascript">
  jQuery(document).ready(function($){
	  var likeCheck = "n";
	  
	  function userLikeCheck(){
		  $.ajax({
				url: '/altaltal/userLikeCheck.ho',
				type: 'POST',
				data: { "member_email" : '<%=email%>',
							"makguli_num" : '<%=makguli.getMakguli_num()%>'	},
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				success: function(data){
					if('n' === data){
						likeCheck= 'n';
						$('#like-div').empty();
						$('#like-div').html('<img src="./resources/image/like_no.png" width="50" height="50" id="btn-like">');
					}else{
						likeCheck= 'y';
						$('#like-div').empty();
						$('#like-div').html('<img src="./resources/image/like_yes.png" width="50" height="50" id="btn-like">');
					}
					likeButtonApply();
				},
				error: function(request, status, error) {alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);}
			});
		  
	  }
	  
	  function userLikeUpdate(){
		  $.ajax({
				url: '/altaltal/userLikeUpdate.ho',
				type: 'POST',
				data: { "member_email" : '<%=email%>',
						   "makguli_num" : '<%=makguli.getMakguli_num()%>',
							"userLike" : likeCheck	},
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				success: function(data){
					alert("userLikeUpdate : " + data);
					if('n' === data.status){
						likeCheck= 'n';
						$('#like-div').empty();
						$('#like-div').html('<img src="./resources/image/like_no.png" width="50" height="50" id="btn-like">');
					}else{
						likeCheck= 'y';
						$('#like-div').empty();
						$('#like-div').html('<img src="./resources/image/like_yes.png" width="50" height="50" id="btn-like">');
					}
					
					$('#makguli-likecount').empty();
					$('#makguli-likecount').text(data.likecount);
					likeButtonApply();
				},
				error: function(request, status, error) {alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);}
			});
		  
	  }
	
	  
	  $("#btn-list").mouseover(function(){
		  $("#btn-list").css("cursor", "pointer");
	  }).mouseout(function(){
		  $("#btn-list").css("cursor", "default");
	  });
	  
	    
	  if('<%=email%>' != ""){
		  userLikeCheck();
	  }else{
		  $('#like-div').html('<img src="./resources/image/like_no.png" width="50" height="50" id="btn-like" />');
		  likeButtonApply();
	  }

	  $(".starset").mouseover(function(){
		  $(".starset").css("cursor", "pointer");
	  }).mouseout(function(){
		  $(".starset").css("cursor", "default");
	  });
	  
	  $(".starset").click(function(){
			 
			 switch($(this).attr("id")){
			 	case "sweat-star5" : {
			 		for(var i=1; i<=5; i++){
						 $('#sweat-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
					 $('#mboard_sweat').val("5");
			 	}
			 	break;
			 	case "sweat-star4" : {
			 		for(var i=1; i<=4; i++){
						 $('#sweat-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		$('#sweat-star5').attr("src", "./resources/image/star_no.png");
					 $('#mboard_sweat').val("4");
			 	}
			 	break;
			 	case "sweat-star3" : {
			 		for(var i=1; i<=3; i++){
						 $('#sweat-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=4; i<=5; i++){
						 $('#sweat-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_sweat').val("3");
			 	}
			 	break;
			 	case "sweat-star2" : {
			 		for(var i=1; i<=2; i++){
						 $('#sweat-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=3; i<=5; i++){
						 $('#sweat-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_sweat').val("2");
			 	}
			 	break;
			 	case "sweat-star1" : {
						 $('#sweat-star1').attr("src", "./resources/image/star_yes.png");
			 		for(var i=2; i<=5; i++){
						 $('#sweat-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_sweat').val("1");
			 	}
			 	break;	
			 	case "sour-star5" : {
			 		for(var i=1; i<=5; i++){
						 $('#sour-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
					 $('#mboard_sour').val("5");
			 	}
			 	break;
			 	case "sour-star4" : {
			 		for(var i=1; i<=4; i++){
						 $('#sour-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		$('#sour-star5').attr("src", "./resources/image/star_no.png");
					 $('#mboard_sour').val("4");
			 	}
			 	break;
			 	case "sour-star3" : {
			 		for(var i=1; i<=3; i++){
						 $('#sour-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=4; i<=5; i++){
						 $('#sour-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_sour').val("3");
			 	}
			 	break;
			 	case "sour-star2" : {
			 		for(var i=1; i<=2; i++){
						 $('#sour-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=3; i<=5; i++){
						 $('#sour-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_sour').val("2");
			 	}
			 	break;
			 	case "sour-star1" : {
						 $('#sour-star1').attr("src", "./resources/image/star_yes.png");
			 		for(var i=2; i<=5; i++){
						 $('#sour-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_sour').val("1");
			 	}
			 	break;
			 	case "body-star5" : {
			 		for(var i=1; i<=5; i++){
						 $('#body-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
					 $('#mboard_body').val("5");
			 	}
			 	break;
			 	case "body-star4" : {
			 		for(var i=1; i<=4; i++){
						 $('#body-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		$('#body-star5').attr("src", "./resources/image/star_no.png");
					 $('#mboard_body').val("4");
			 	}
			 	break;
			 	case "body-star3" : {
			 		for(var i=1; i<=3; i++){
						 $('#body-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=4; i<=5; i++){
						 $('#body-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_body').val("3");
			 	}
			 	break;
			 	case "body-star2" : {
			 		for(var i=1; i<=2; i++){
						 $('#body-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=3; i<=5; i++){
						 $('#body-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_body').val("2");
			 	}
			 	break;
			 	case "body-star1" : {
						 $('#body-star1').attr("src", "./resources/image/star_yes.png");
			 		for(var i=2; i<=5; i++){
						 $('#body-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_body').val("1");
			 	}
			 	break;
			 	case "spark-star5" : {
			 		for(var i=1; i<=5; i++){
						 $('#spark-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
					 $('#mboard_spark').val("5");
			 	}
			 	break;
			 	case "spark-star4" : {
			 		for(var i=1; i<=4; i++){
						 $('#spark-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		$('#spark-star5').attr("src", "./resources/image/star_no.png");
					 $('#mboard_spark').val("4");
			 	}
			 	break;
			 	case "spark-star3" : {
			 		for(var i=1; i<=3; i++){
						 $('#spark-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=4; i<=5; i++){
						 $('#spark-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_spark').val("3");
			 	}
			 	break;
			 	case "spark-star2" : {
			 		for(var i=1; i<=2; i++){
						 $('#spark-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=3; i<=5; i++){
						 $('#spark-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_spark').val("2");
			 	}
			 	break;
			 	case "spark-star1" : {
						 $('#spark-star1').attr("src", "./resources/image/star_yes.png");
			 		for(var i=2; i<=5; i++){
						 $('#spark-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_spark').val("1");
			 	}
			 	break;
			 	case "popular-star5" : {
			 		for(var i=1; i<=5; i++){
						 $('#popular-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
					 $('#mboard_popular').val("5");
			 	}
			 	break;
			 	case "popular-star4" : {
			 		for(var i=1; i<=4; i++){
						 $('#popular-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		$('#popular-star5').attr("src", "./resources/image/star_no.png");
					 $('#mboard_popular').val("4");
			 	}
			 	break;
			 	case "popular-star3" : {
			 		for(var i=1; i<=3; i++){
						 $('#popular-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=4; i<=5; i++){
						 $('#popular-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_popular').val("3");
			 	}
			 	break;
			 	case "popular-star2" : {
			 		for(var i=1; i<=2; i++){
						 $('#popular-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=3; i<=5; i++){
						 $('#popular-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_popular').val("2");
			 	}
			 	break;
			 	case "popular-star1" : {
						 $('#popular-star1').attr("src", "./resources/image/star_yes.png");
			 		for(var i=2; i<=5; i++){
						 $('#popular-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#mboard_popular').val("1");
			 	}
			 	break;
			 } /* switch구문 끝! */
		  });
	  
	  $("#btn-comment").mouseover(function(){
		  $("#btn-comment").css("cursor", "pointer");
	  }).mouseout(function(){
		  $("#btn-comment").css("cursor", "default");
	  });
	  
	  $(".starUpdate").mouseover(function(){
		  $(".starUpdate").css("cursor", "pointer");
	 }).mouseout(function(){
		  $(".starUpdate").css("cursor", "default");
	 });

	  function likeButtonApply(){
		  $("#btn-like").click(function(){
			  if('<%=email%>' != ""){  
				  userLikeUpdate();
			  }else{
				  alert("회원만 가능합니다.");
			  }
		  });
		  
		  $("#btn-like").mouseover(function(){
			  $("#btn-like").css("cursor", "pointer");
		  }).mouseout(function(){
			  $("#btn-like").css("cursor", "default");
		  });
		  
		  $("#btn-like").attr("data-toggle", "popover");
		  $("#btn-like").attr("data-placement", "right");
		  $("#btn-like").attr("data-trigger", "hover");
		  $("#btn-like").attr("data-content", "좋아요");
	  }
	  
	  $('[data-toggle="popover"]').popover();
	  likeButtonApply();
});
  
  function changeComment(mboard_num, writer){
		if('<%=nickname%>' !== writer){  
			alert('작성자만 수정 가능합니다.');
			return false;
		}else{
			if($('#'+mboard_num+'_div').css('display') == 'block'){
				$('#'+mboard_num+'_div').css('display', 'none');
				$('#'+mboard_num+'_update').css('display', 'block');
			}else{
				$('#'+mboard_num+'_div').css('display', 'block');
				$('#'+mboard_num+'_update').css('display', 'none');
			}
		}
	}
  
  	function deleteComment(mboard_num, writer){
		if('<%=nickname%>' !== writer){  
			alert('작성자만 삭제 가능합니다.');
			return false;
		}else{
			if(confirm("해당 댓글을 삭제하시겠습니까?")){
				location.href="./deleteMakguliComment.ma?makguli_num=<%=makguli.getMakguli_num() %>&mboard_num="+ mboard_num + "&page=<%=nowPage%>&commentPage=<%=commentPage%>";
			}
		}
	}
	
	function cancelComment(mboard_num){
		if($('#'+mboard_num+'_div').css('display') == 'block'){
			$('#'+mboard_num+'_div').css('display', 'none');
			$('#'+mboard_num+'_update').css('display', 'block');
		}else{
			$('#'+mboard_num+'_div').css('display', 'block');
			$('#'+mboard_num+'_update').css('display', 'none');
		}
	}
	
	function commentCheck(){
		if('<%=email%>' == "") {
			alert('회원만 코멘트를 남길 수 있습니다.');
			return false;
		}
		if ($('#mboard_content').val() == null || $('#mboard_content').val() === "") {
			alert('평가코멘트를 남겨주세요.');
			$('#pboard_content').focus();
			return false;
		}

		if ($('#mboard_sweat').val() == null || $('#mboard_sweat').val() === "0") {
			alert('단맛 점수를 메겨주세요.');
			$('#mboard_sweat').focus();
			return false;
		}

		if ($('#mboard_sour').val() == null || $('#mboard_sour').val() === "0") {
			alert('신맛 점수를 메겨주세요.');
			$('#mboard_sour').focus();
			return false;
		}

		if ($('#mboard_body').val() == null || $('#mboard_body').val() === "0") {
			alert('바디감 점수를 메겨주세요.');
			$('#mboard_body').focus();
			return false;
		}

		if ($('#mboard_spark').val() == null || $('#mboard_spark').val() === "0") {
			alert('탄산 점수를 메겨주세요.');
			$('#mboard_spark').focus();
			return false;
		}

		if ($('#mboard_popular').val() == null || $('#mboard_popular').val() === "0") {
			alert('대중성 점수를 메겨주세요.');
			$('#mboard_popular').focus();
			return false;
		}

		return true;
	}
	
	function starClick(mboard_num, obj){
		switch(obj.id){
		 	case ("sweat-"+ mboard_num + "5") : {
		 		for(var i=1; i<=5; i++){
					 $('#sweat-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
				 $('#'+mboard_num+'_sweat').val("5");
		 	}
		 	break;
		 	case ("sweat-"+ mboard_num + "4") : {
		 		for(var i=1; i<=4; i++){
					 $('#sweat-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		$('#sweat-'+ mboard_num +'5').attr("src", "./resources/image/star_no.png");
				 $('#'+mboard_num+'_sweat').val("4");
		 	}
		 	break;
		 	case ("sweat-"+ mboard_num + "3") : {
		 		for(var i=1; i<=3; i++){
					 $('#sweat-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=4; i<=5; i++){
					 $('#sweat-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_sweat').val("3");
		 	}
		 	break;
		 	case ("sweat-"+ mboard_num + "2") : {
		 		for(var i=1; i<=2; i++){
					 $('#sweat-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=3; i<=5; i++){
					 $('#sweat-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_sweat').val("2");
		 	}
		 	break;
		 	case ("sweat-"+ mboard_num + "1") : {
					 $('#sweat-'+mboard_num+'1').attr("src", "./resources/image/star_yes.png");
		 		for(var i=2; i<=5; i++){
					 $('#sweat-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_sweat').val("1");
		 	}
		 	break;	
		 	case ("sour-"+ mboard_num + "5") : {
		 		for(var i=1; i<=5; i++){
					 $('#sour-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
				 $('#'+mboard_num+'_sour').val("5");
		 	}
		 	break;
		 	case ("sour-"+ mboard_num + "4") : {
		 		for(var i=1; i<=4; i++){
					 $('#sour-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		$('#sour-'+mboard_num+'5').attr("src", "./resources/image/star_no.png");
				 $('#'+mboard_num+'_sour').val("4");
		 	}
		 	break;
		 	case ("sour-"+ mboard_num + "3") : {
		 		for(var i=1; i<=3; i++){
					 $('#sour-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=4; i<=5; i++){
					 $('#sour-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_sour').val("3");
		 	}
		 	break;
		 	case ("sour-"+ mboard_num + "2") : {
		 		for(var i=1; i<=2; i++){
					 $('#sour-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=3; i<=5; i++){
					 $('#sour-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_sour').val("2");
		 	}
		 	break;
		 	case ("sour-"+ mboard_num + "1") : {
					 $('#sour-'+mboard_num+'1').attr("src", "./resources/image/star_yes.png");
		 		for(var i=2; i<=5; i++){
					 $('#sour-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_sour').val("1");
		 	}
		 	break;
		 	case ("body-"+ mboard_num + "5") : {
		 		for(var i=1; i<=5; i++){
					 $('#body-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
				 $('#'+mboard_num+'_body').val("5");
		 	}
		 	break;
		 	case ("body-"+ mboard_num + "4") : {
		 		for(var i=1; i<=4; i++){
					 $('#body-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		$('#body-'+mboard_num+'5').attr("src", "./resources/image/star_no.png");
				 $('#'+mboard_num+'_body').val("4");
		 	}
		 	break;
		 	case ("body-"+ mboard_num + "3") : {
		 		for(var i=1; i<=3; i++){
					 $('#body-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=4; i<=5; i++){
					 $('#body-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_body').val("3");
		 	}
		 	break;
		 	case ("body-"+ mboard_num + "2") : {
		 		for(var i=1; i<=2; i++){
					 $('#body-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=3; i<=5; i++){
					 $('#body-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_body').val("2");
		 	}
		 	break;
		 	case ("body-"+ mboard_num + "1") : {
					 $('#body-'+mboard_num+'1').attr("src", "./resources/image/star_yes.png");
		 		for(var i=2; i<=5; i++){
					 $('#body-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_body').val("1");
		 	}
		 	break;	
		 	case ("spark-"+ mboard_num + "5") : {
		 		for(var i=1; i<=5; i++){
					 $('#spark-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
				 $('#'+mboard_num+'_spark').val("5");
		 	}
		 	break;
		 	case ("spark-"+ mboard_num + "4") : {
		 		for(var i=1; i<=4; i++){
					 $('#spark-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		$('#spark-'+mboard_num+'5').attr("src", "./resources/image/star_no.png");
				 $('#'+mboard_num+'_spark').val("4");
		 	}
		 	break;
		 	case ("spark-"+ mboard_num + "3") : {
		 		for(var i=1; i<=3; i++){
					 $('#spark-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=4; i<=5; i++){
					 $('#spark-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_spark').val("3");
		 	}
		 	break;
		 	case ("spark-"+ mboard_num + "2") : {
		 		for(var i=1; i<=2; i++){
					 $('#spark-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=3; i<=5; i++){
					 $('#spark-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_spark').val("2");
		 	}
		 	break;
		 	case ("spark-"+ mboard_num + "1") : {
					 $('#spark-'+mboard_num+'1').attr("src", "./resources/image/star_yes.png");
		 		for(var i=2; i<=5; i++){
					 $('#spark-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_spark').val("1");
		 	}
		 	break;
		 	case ("popular-"+ mboard_num + "5") : {
		 		for(var i=1; i<=5; i++){
					 $('#popular-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
				 $('#'+mboard_num+'_popular').val("5");
		 	}
		 	break;
		 	case ("popular-"+ mboard_num + "4") : {
		 		for(var i=1; i<=4; i++){
					 $('#popular-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		$('#popular-'+mboard_num+'5').attr("src", "./resources/image/star_no.png");
				 $('#'+mboard_num+'_popular').val("4");
		 	}
		 	break;
		 	case ("popular-"+ mboard_num + "3") : {
		 		for(var i=1; i<=3; i++){
					 $('#popular-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=4; i<=5; i++){
					 $('#popular-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_popular').val("3");
		 	}
		 	break;
		 	case ("popular-"+ mboard_num + "2") : {
		 		for(var i=1; i<=2; i++){
					 $('#popular-'+mboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=3; i<=5; i++){
					 $('#popular-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_popular').val("2");
		 	}
		 	break;
		 	case ("popular-"+ mboard_num + "1") : {
					 $('#popular-'+mboard_num+'1').attr("src", "./resources/image/star_yes.png");
		 		for(var i=2; i<=5; i++){
					 $('#popular-'+mboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+mboard_num+'_popular').val("1");
		 	}
		 	break;
			}  /* switch 끝 */
	}
	
	function commentSubmit(this_form){
		if(this_form.mboard_content == "" || this_form.mboard_content == null){
			alert("댓글란을 작성해주세요.");
			this_form.mboard_content.focus();
			return false;
		}
		if(this_form.mboard_sweat == "0"){
			alert("단맛 점수를 매겨주세요.");
			return false;
		}
		if(this_form.mboard_sour == "0"){
			alert("신맛 점수를 매겨주세요.");
			return false;
		}
		if(this_form.mboard_body == "0"){
			alert("바디감 점수를 매겨주세요.");
			return false;
		}
		if(this_form.mboard_spark == "0"){
			alert("탄산 점수를 매겨주세요.");
			return false;
		}
		if(this_form.mboard_popular == "0"){
			alert("대중성 점수를 매겨주세요.");
			return false;
		}
		this_form.submit();
	}
</script>
</head>
<body>
	<jsp:include page="../menubar.jsp" flush="true" />

	<section class="container all_body_content">
		<div class="makguli">
		
			<div class="row mg-title-roww">
				<div class="col-md-6 mg-title-header">
							<%=makguli.getMakguli_name()%>
							<span class="icons"> 
							<i class="glyphicon glyphicon-heart"></i>&nbsp;<span
								id="makguli-likecount"><%=makguli.getMakguli_likecount()%></span>&nbsp;&nbsp;
								<i class="glyphicon glyphicon-eye-open"></i>&nbsp;<%=makguli.getMakguli_readcount()%>
							</span>
				</div>
				<div class="mg-ratings col-md-6">
					<div>
						<img src="./resources/image/movelist.png" width="50" height="50"
							onclick="location.href='getMakguliList.ma?makguli_area=<%=makguli.getMakguli_area()%>&page=<%=nowPage%>&keyword=<%=keyword%>';"
							id="btn-list" data-toggle="popover" data-placement="left"
							data-trigger="hover" data-content="막걸리 목록">
					</div>
					<div>
						<img src="./resources/image/pencil.png" width="53" height="53"
							onclick="$('#my-tabs-place a:first').tab('show'); location.href='#comment-div-content';"
							id="btn-comment" data-toggle="popover" data-placement="bottom"
							data-trigger="hover" data-content="평가하기" />
					</div>
					<span id="like-div"> </span>
				</div>
			</div>
			
			<div class="mg-mginfo">
				<div class="mg-list">
					<div class="row">
					
						<div class="col-md-6">
							<div class="mg-info">
								<div class="row mg-line">
									<div class="mg-details col-xs-4"><img src="./resources/image/brewery.png">&nbsp;제조사/지역</div>
									<div class="mg-make col-xs-8 allfont"><%=makguli.getMakguli_make()%> /<span
											class="mg-area"><%=makguli.getMakguli_area()%></span>
									</div>
								</div>
								<div class="row mg-line">
									<div class="mg-details col-xs-4"><img src="./resources/image/url.png">&nbsp;홈페이지</div>
									<div class="col-xs-8 allfont">
										<a href="<%=makguli.getMakguli_make_url()%>"></a><%=makguli.getMakguli_make_url()%></div>
								</div>
								<div class="row mg-line">
									<div class="mg-details col-xs-4"><img src="./resources/image/diet.png">&nbsp;재료</div>
									<div class="col-xs-8 allfont"><%=makguli.getMakguli_ingre()%></div>
								</div>

								<div class="row mg-line">
									<div class="mg-details col-xs-4"><img src="./resources/image/degree.png">&nbsp;도수</div>
									<div class="col-xs-8 allfont"><%=makguli.getMakguli_degree()%> 도</div>
								</div>
							</div>
						</div>
						
						<div class="col-md-6">
							<div class="mg-info">
								<div class="row mg-line">
									<div class="mg-details col-xs-3"><img src="./resources/image/book.png">&nbsp;설명</div>
									<div class="col-xs-9 allfont"><%=makguli.getMakguli_content()%>
									</div>
								</div>
							</div>
						</div>
						
					</div>
				</div>
			</div>

			<div class="row mg-see">
				<div class="col-md-6">
					<div class="mg-img">
						<img src="<spring:url value='/image/makguli/${makguli.makguli_picture }' />" alt="sampl45" width="200px" height="300px" />
					</div>
				</div>
				<div class="col-md-offset-1 col-md-4">
				<div class="mg-details"><img src="./resources/image/book.png">&nbsp;평가항목</div>
					<div id="myChart">
				</div>
			</div>



			<br />
			<div class="mg-comment">
				<ul class="nav nav-tabs " id="my-tabs-place">
					<li><a data-toggle="tab" href="#comment-div-content"><i
							class="glyphicon glyphicon-pencil"></i>&nbsp;&nbsp;막걸리 평가</a></li>
				</ul>

				<div class="tab-content">
					<!--  한줄 평가 -->
					<div id="comment-div-content" class="container-fulid tab-pane fade">
						<div class="row comment_div">
							<section class="comment-list">
								<!--  댓글 시작 -->

								<!-- 해당글 댓글 입력하는 공간 -->
								<br />
								<form action="insertMakguliComment.ma" id="commentForm"
									name="commentForm" method='post'
									onsubmit="return commentCheck();">
									<input type="hidden" name="makguli_num"
										value="<%=makguli.getMakguli_num()%>" />
									<article class="row">
										<div class="col-md-1 col-sm-1 hidden-xs"></div>
										<div class="col-md-1 col-sm-1 hidden-xs">
											<figure class="thumbnail-comment">
												<%
													if (session.getAttribute("profile") == null) {
												%>
												<img class="img-responsive comment-image-list"
													src="./resources/image/guest.png" width="60" height="60" />
												<%
													} else {
												%>
												<img class="img-responsive comment-image-list"
													src="<spring:url value='/image/profile/${sessionScope.profile }' />"
													width="60" height="60" />
												<%
													}
												%>
											</figure>
										</div>
										<div class="col-md-10 col-sm-10 comment-makguli-list">
											<div class="panel panel-default arrow left ">
												<div class="panel-body">
													<div class="comment-post">
														<div class="comment-star-div">
															단맛 :&nbsp; 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sweat-star1"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sweat-star2"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sweat-star3"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sweat-star4"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sweat-star5"> 
															&nbsp;&nbsp;&nbsp;신맛:&nbsp; 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sour-star1"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sour-star2"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sour-star3"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sour-star4"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sour-star5"> 
															&nbsp;&nbsp;&nbsp;바디감:&nbsp; 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="body-star1"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="body-star2"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="body-star3"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="body-star4"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="body-star5"> 
															&nbsp;&nbsp;&nbsp;탄산:&nbsp; 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="spark-star1"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="spark-star2"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="spark-star3"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="spark-star4"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="spark-star5">
															&nbsp;&nbsp;&nbsp;대중성 :&nbsp; 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="popular-star1"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="popular-star2"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="popular-star3"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="popular-star4"> 
															<img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="popular-star5"> 
															<input type="hidden" id="mboard_sweat" name="mboard_sweat" value="0" /> 
															<input type="hidden" id="mboard_sour" name="mboard_sour" value="0" /> 
															<input type="hidden" id="mboard_body" name="mboard_body" value="0" /> 
															<input type="hidden" id="mboard_spark" name="mboard_spark" value="0" /> 
															<input type="hidden" id="mboard_popular" name="mboard_popular" value="0" />
														</div>
														<br />
														<p>
															<textarea id='mboard_content' rows="2" cols="120" name="mboard_content" placeholder=" comment here..."></textarea>
														</p>
														<p class="text-right button-line">
															<button style="padding-right: 7px;" type="submit" class="btn btn-default btn-sm">
																<i class="glyphicon glyphicon-share-alt"></i> reply
															</button>
															<br />
														</p>
													</div>
												</div>
											</div>
										</div>
									</article>
								</form>
								<!-- 해당글 댓글 입력하는 공간 -->
								<div id="reply-list">
									<%
										if (mboardList != null || mboardList.size() != 0) {
											for (int i = 0; i < mboardList.size(); i++) {
									%>
									<article class="row" id="<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>_div">
										<div class="col-md-1 col-sm-1 hidden-xs"></div>
										<div class="col-md-1 col-sm-1 hidden-xs">
											<figure class="thumbnail-comment">
												<img class="img-responsive comment-image-list" src="/altaltal/image/profile/<%=mboardList.get(i).get("member_picture").toString()%>" width="60" height="60" />
											</figure>
										</div>
										<div class="col-md-10 col-sm-10 comment-makguli-list">
											<div class="panel panel-default arrow left">
												<div class="panel-body">
													<div class="comment-post">
													<div style="margin-bottom: 5px;">
					                  					<i class='glyphicon glyphicon-user'></i> <%= mboardList.get(i).get("member_nickname").toString()%>&nbsp;&nbsp;
					                  					<i class='glyphicon glyphicon-time'></i> <%= sdf.format((Date)mboardList.get(i).get("mboard_date"))%>
					                  				</div>
														<div class="comment-star-div">
						                   		단맛 :&nbsp;
						            <% 
						                  	switch(Integer.parseInt(mboardList.get(i).get("mboard_sweat").toString())){
							                  	case 5 :{
							                  		for(int j=0; j<5; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}
							                  	}
							                  	break;
							                  	case 4 :{
							                  		for(int j=0; j<4; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	} %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% 
							                  	}
							                  	break;
							                  	case 3 :{
							                  		for(int j=0; j<3; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}for(int k=0; k<2; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
							                  	case 2 :{
							                  		for(int j=0; j<2; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}for(int k=0; k<3; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
							                  	case 1 :{
							                  		%><img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%for(int k=0; k<4; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
						                  	} /* switch 끝 */
						             %>
						                   		&nbsp;&nbsp;&nbsp;신맛 :&nbsp;
									<% 
						                  	switch(Integer.parseInt(mboardList.get(i).get("mboard_sour").toString())){
							                  	case 5 :{
							                  		for(int j=0; j<5; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}
							                  	}
							                  	break;
							                  	case 4 :{
							                  		for(int j=0; j<4; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	} %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% 
							                  	}
							                  	break;
							                  	case 3 :{
							                  		for(int j=0; j<3; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}for(int k=0; k<2; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
							                  	case 2 :{
							                  		for(int j=0; j<2; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}for(int k=0; k<3; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
							                  	case 1 :{
							                  		%><img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%for(int k=0; k<4; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
						                  	} /* switch 끝 */
						             %>
						                   		&nbsp;&nbsp;&nbsp;바디감 :&nbsp;
									<% 
						                  	switch(Integer.parseInt(mboardList.get(i).get("mboard_body").toString())){
							                  	case 5 :{
							                  		for(int j=0; j<5; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}
							                  	}
							                  	break;
							                  	case 4 :{
							                  		for(int j=0; j<4; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	} %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% 
							                  	}
							                  	break;
							                  	case 3 :{
							                  		for(int j=0; j<3; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}for(int k=0; k<2; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
							                  	case 2 :{
							                  		for(int j=0; j<2; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}for(int k=0; k<3; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
							                  	case 1 :{
							                  		%><img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%for(int k=0; k<4; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
						                  	} /* switch 끝 */
						             %>
						             &nbsp;&nbsp;&nbsp;탄산 :&nbsp;
									<% 
						                  	switch(Integer.parseInt(mboardList.get(i).get("mboard_spark").toString())){
							                  	case 5 :{
							                  		for(int j=0; j<5; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}
							                  	}
							                  	break;
							                  	case 4 :{
							                  		for(int j=0; j<4; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	} %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% 
							                  	}
							                  	break;
							                  	case 3 :{
							                  		for(int j=0; j<3; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}for(int k=0; k<2; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
							                  	case 2 :{
							                  		for(int j=0; j<2; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}for(int k=0; k<3; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
							                  	case 1 :{
							                  		%><img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%for(int k=0; k<4; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
						                  	} /* switch 끝 */
						             %>
						             &nbsp;&nbsp;&nbsp;대중성 :&nbsp;
									<% 
						                  	switch(Integer.parseInt(mboardList.get(i).get("mboard_popular").toString())){
							                  	case 5 :{
							                  		for(int j=0; j<5; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}
							                  	}
							                  	break;
							                  	case 4 :{
							                  		for(int j=0; j<4; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	} %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% 
							                  	}
							                  	break;
							                  	case 3 :{
							                  		for(int j=0; j<3; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}for(int k=0; k<2; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
							                  	case 2 :{
							                  		for(int j=0; j<2; j++){
							                  		%>
							                  		<img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%	}for(int k=0; k<3; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
							                  	case 1 :{
							                  		%><img src="./resources/image/star_yes.png" width="20" height="20"  >
													<%for(int k=0; k<4; k++){ %>
							                  		<img src="./resources/image/star_no.png" width="20" height="20"  >
							                  		<% }
							                  	}
							                  	break;
						                  	} /* switch 끝 */
						             %>
										  </div>
										  <br/>
					                    <p>
					                     <textarea rows="2" cols="120" name="pboard_content" readonly="readonly" >&nbsp;<%=mboardList.get(i).get("mboard_content").toString() %></textarea>
					                    </p>
					                      <div style="text-align: right; padding-right:5px;">
					                    <button type='button' 
					                    onclick="changeComment('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', '<%= mboardList.get(i).get("member_nickname").toString()%>');"
					                    class='btn btn-default btn-sm' ><i class='glyphicon glyphicon-scissors'></i> modify</button>
					                    &nbsp;&nbsp;
					                    <button type='button' 
					                     onclick="deleteComment('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', '<%= mboardList.get(i).get("member_nickname").toString()%>');"
					                    class='btn btn-default btn-sm' ><i class='glyphicon glyphicon-trash'></i> delete</button>
					                    </div>
					                  </div>
					                </div>
					              </div>
					            </div>
					          </article>
					          
					          <!-- 댓글 수정하는 칸 -->
					          <form action="updateMakguliComment.ma" method="post" >
					          <input type="hidden" name="mboard_num" value="<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>" />
					          <input type="hidden" name="makguli_num" value="<%=makguli.getMakguli_num() %>" />
					          <input type="hidden" name="page" value="<%=nowPage %>" />
					          <input type="hidden" name="commentPage" value="<%=commentPage %>" />
					          <article class="row comment-updateform-article" id="<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>_update">
										<div class="col-md-1 col-sm-1 hidden-xs"></div>
										<div class="col-md-1 col-sm-1 hidden-xs">
											<figure class="thumbnail-comment">
												<img class="img-responsive comment-image-list"
													src="/altaltal/image/profile/<%=mboardList.get(i).get("member_picture").toString()%>"
													width="60" height="60" />
												<div style="text-align: center;" class="comment-nickname"><%=mboardList.get(i).get("member_nickname").toString()%></div>
												<br />
											</figure>
										</div>
										<div class="col-md-10 col-sm-10 comment-makguli-list">
											<div class="panel panel-default arrow left">
												<div class="panel-body">
													<div class="comment-post">
													<div style="margin-bottom: 5px;">
					                  					<i class='glyphicon glyphicon-user'></i> <%= mboardList.get(i).get("member_nickname").toString()%>&nbsp;&nbsp;
					                  					<i class='glyphicon glyphicon-time'></i> <%= sdf.format((Date)mboardList.get(i).get("mboard_date"))%>
					                  				</div> 
														<div class="comment-star-div">
						                 					단맛 :&nbsp; 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="sweat-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>1"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="sweat-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>2"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="sweat-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>3"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="sweat-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>4"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="sweat-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>5"> 
															&nbsp;&nbsp;&nbsp;신맛:&nbsp; 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="sour-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>1"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="sour-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>2"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="sour-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>3"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="sour-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>4"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="sour-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>5"> 
															&nbsp;&nbsp;&nbsp;바디감:&nbsp; 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="body-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>1"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="body-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>2"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="body-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>3"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="body-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>4"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="body-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>5"> 
															&nbsp;&nbsp;&nbsp;탄산:&nbsp; 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="spark-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>1"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="spark-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>2"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="spark-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>3"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="spark-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>4"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="spark-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>5">
															&nbsp;&nbsp;&nbsp;대중성 :&nbsp; 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="popular-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>1"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="popular-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>2"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="popular-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>3"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="popular-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>4"> 
															<img onclick="starClick('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="popular-<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>5"> 
															<input type="hidden" id="<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString()) %>_sweat" 
															name="mboard_sweat" value="<%=Integer.parseInt(mboardList.get(i).get("mboard_sweat").toString()) %>" /> 
															<input type="hidden" id="<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString()) %>_sour" 
															name="mboard_sour" value="<%=Integer.parseInt(mboardList.get(i).get("mboard_sour").toString()) %>" /> 
															<input type="hidden" id="<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString()) %>_body" 
															name="mboard_body" value="<%=Integer.parseInt(mboardList.get(i).get("mboard_body").toString()) %>" /> 
															<input type="hidden" id="<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString()) %>_spark" 
															name="mboard_spark" value="<%=Integer.parseInt(mboardList.get(i).get("mboard_spark").toString()) %>" /> 
															<input type="hidden" id="<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString()) %>_popular" 
															name="mboard_popular" value="<%=Integer.parseInt(mboardList.get(i).get("mboard_popular").toString()) %>" />
										 				 </div>
										  				<br/>
					                    			<p>
					                     		<textarea rows="2" cols="120" name="mboard_content" >&nbsp;<%=mboardList.get(i).get("mboard_content").toString() %></textarea>
					                    			</p>
					                      <div style="text-align: right; padding-right:5px;">
					                    <button type='button' onclick="commentSubmit(this.form);" class='btn btn-default btn-sm' ><i class='glyphicon glyphicon-scissors'></i> reply</button>
					                    &nbsp;&nbsp;
					                    <button type='button' onclick="cancelComment('<%=Integer.parseInt(mboardList.get(i).get("mboard_num").toString())%>');"
					                    class='btn btn-default btn-sm' ><i class='glyphicon glyphicon-trash'></i> cancel</button>
					                    </div>
					                  </div>
					                </div>
					              </div>
					            </div>
					          </article>
					          </form>
									<%
										} /* for문 끝 */
									} /* if문 끝 */
									%>

									<section id="pageList">
									<div class="text-center">
									<ul class="pagination">
										<%if(commentPage<=1){ %>
										<li><a>«</a></li>&nbsp;
										<%}else{ %>
										<li><a href="getMakguli.ma?makguli_num<%=makguli.getMakguli_num()%>&commentPage=<%=commentPage-1%>&page=<%=nowPage%>&keyword=<%=keyword%>">«</a></li>&nbsp;
										<%} %>
										
										<%for(int a=startPage;a<=endPage;a++){
												if(a==commentPage){%>
										<li><a><%=a %></a></li>
										<%}else{ %>
										<li><a href="getMakguli.ma?makguli_num<%=makguli.getMakguli_num()%>&commentPage=<%=a%>&page=<%=nowPage%>&keyword=<%=keyword%>"><%=a %>
										</a></li>&nbsp;
										<%} %>
										<%} %>
								
										<%if(commentPage>=maxPage){ %>
										<li><a>»</a></li>
										<%}else{ %>
										<li><a href="getMakguli.ma?makguli_num<%=makguli.getMakguli_num()%>&commentPage=<%=commentPage+1%>&page=<%=nowPage%>&keyword=<%=keyword%>">»</a></li>
										<%} %>
										</ul>
									</div>
								</section>
								</div>
								<!-- 해당글 댓글 들어가는 공간 -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

<script>
var myConfig = {
		  type : 'radar',
		  plot : {
		    aspect : 'area',
		    animation: {
		      effect:3,
		      sequence:1,
		      speed:700
		    }
		  },
		  scaleV : {
		    visible : false
		  },
		  scaleK : {
		    values : '0:4:1',
		    labels : ['단맛','신맛','바디감','탄산','대중성'],
		    item : {
		      fontColor : '#607D8B',
		      backgroundColor : "white",
		      borderColor : "#aeaeae",
		      borderWidth : 1,
		      padding : '5 10',
		      borderRadius : 10
		    },
		    refLine : {
		      lineColor : '#c10000'
		    },
		    tick : {
		      lineColor : '#59869c',
		      lineWidth : 2,
		      lineStyle : 'dotted',
		      size : 20
		    },
		    guide : {
		      lineColor : "#607D8B",
		      lineStyle : 'solid',
		      alpha : 0.3,
		      backgroundColor : "#c5c5c5 #718eb4"
		    }
		  },
		  series : [
		    {
		      values : [<%=sweatAve%>, <%=sourAve%>, <%=bodyAve%>, <%=sparkAve%>, <%=popularAve%>],
		      lineColor : '#d9534f', /* 색바꾸기 */
		      backgroundColor : '#d9534f' /* 색바꾸기 */
		    }
		  ]
		};
		zingchart.render({ 
			id : 'myChart', 
			data : myConfig, 
			height: '100%', 
			width: '100%' 
		});
</script>
	<jsp:include page="../footer.jsp" flush="true" />
</body>
</html>