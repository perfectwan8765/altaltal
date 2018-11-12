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
	if(session.getAttribute("email") != null){
		email =(String)session.getAttribute("email");
	}

 	String keyword = (String)request.getAttribute("keyword");
 	int nowPage = Integer.parseInt(request.getAttribute("page").toString());
 	MakguliVO makguli = (MakguliVO)request.getAttribute("makguli");
 	
 	ArrayList<HashMap<String, Object>> mboardList = (ArrayList<HashMap<String, Object>>)request.getAttribute("mboardList");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount = pageInfo.getListCount();
	int commentPage = pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
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
	
	if(mboardList.size() != 0){
		for(int i=0; i<mboardList.size(); i++){
			sweatSum += Integer.parseInt(mboardList.get(i).get("mboard_sweat").toString());
			sourSum += Integer.parseInt(mboardList.get(i).get("mboard_sour").toString());
			bodySum += Integer.parseInt(mboardList.get(i).get("mboard_body").toString());
			sparkSum += Integer.parseInt(mboardList.get(i).get("mboard_spark").toString());
			popularSum += Integer.parseInt(mboardList.get(i).get("mboard_popular").toString());
		}
		
		sweatAve = sweatSum/mboardList.size();
		sourAve = sourSum/mboardList.size();
		bodyAve = bodySum/mboardList.size();
		sparkAve = sparkSum/mboardList.size();
		popularAve = popularSum/mboardList.size();
	}
%>   
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpoint" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src= "https://cdn.zingchart.com/zingchart.min.js"></script>
	<script>
		zingchart.MODULESDIR = "https://cdn.zingchart.com/modules/";
		ZC.LICENSE = ["569d52cefae586f634c54f86dc99e6a9","ee6b7db5b51705a13dc2339db3edaf6d"];
	</script>
	
<title>막걸리리스트</title>      
<style>
 .all_body_content {
            margin-top: 30px;
            margin-bottom: 150px;
            min-height: 100%;
            margin-left: auto;
            margin-right: auto;
            width: 1060px;
        }

        .mg-mginfo {
            border: none;
        }

        /*막걸리 타이틀 평점*/
        .mg-list {
            border-bottom: 1px solid #dbdbdb;
        }

        .mg-title {
            font-size: 36px;
            height: 100px;
            padding: 20px;
        }

        .mg-title .mg-area {
            font-size: 19px;
            margin-left: 12px;
        }

        .mg-ratings {
            text-align: center;
            font-size: 22px;
            padding: 33px 20px 20px 20px;
            height: 100px;
           
        }
     
        /*막걸리 설명*/
        .mg-info {
            height: 100%;
            min-height: 650px;
            margin: 20px -15px;
            padding: 0 20px;
            font-size: 20px;
        }
         .mg-line{
            margin-bottom: 25px;
        }
        /*설명 부분 글씨크기 일괄 조정*/
       .allfont{
           font-size: 17px;
           color: rgb(143, 139, 139);
       }
        /*막걸리 이미지*/
        .mg-img {
            height: 300px;
            width: 200px;
            margin-top: 85px;
            margin-left: 40px;
        }

		.mg-details img{
			width: 28px;
			height:28px;
		}
        .mg-img img {
            width: 100%;
            height: 100%;
        }

        /*목록가기버튼*/
       #btn-list{
           float: right;
           position:absolute;top:25px;right:150px;z-index:100;
       }
       #btn-comment{
           float: right;
           position:absolute;top:25px;right:100px;z-index:100;
       }
       #btn-like{
           float: right;
           position:absolute;top:25px;right:30px;z-index:100;
       }
        /*막걸리 다이어그램*/
        .mg-diagram {
            height: 340px;
            width: 400px;
            padding-bottom: 20px;
        }
       
        /*막걸리 한줄평가*/
        .mg-comment {
            border: none;
            margin-top: 20px;
        }


figure.snip0078 {
  font-family: 'Raleway', Arial, sans-serif;
  color: #fff;
  position: relative;
  float: left;
  margin: 10px;
  min-width: 220px;
  max-width: 350px;
  max-height: 350px;
  width: 350px;
  height: 350px;
  padding-right: 10px;
  text-align: center;
}
figure.snip0078 * {
  -webkit-box-sizing: padding-box;
  box-sizing: padding-box;
}
figure.snip0078 img {
  opacity: 1;
  max-width: 100%;
  border: 10px solid white;
  -webkit-transition: all 0.3s;
  transition: all 0.3s;
  -webkit-transform: scale(0.85);
  transform: scale(0.85);
  -webkit-transform-origin: 0 0;
  transform-origin: 0 0;
}
figure.snip0078 figcaption {
  bottom: 0;
  width: 45%;
  right: -10px;
  position: absolute;
  background: #b5b5b5;
  padding: 10px;
  -webkit-transition: all 0.3s;
  transition: all 0.3s;
  -webkit-transform: translateY(0);
  transform: translateY(0);
  box-shadow: 0 0px 10px -10px #000000;
  border-radius: 5px;
}
figure.snip0078 figcaption h2,
figure.snip0078 figcaption p {
  font-weight: 500;
  margin: 0;
  color: #ffffff;
}
figure.snip0078 figcaption h2 span {
  font-weight: 800;
}
figure.snip0078 a {
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
  position: absolute;
  z-index: 1;
}
figure.snip0078.blue figcaption {
  background: #b5b5b5;  /* 박스색깔 */
}
figure.snip0078.blue img {
  border: 5px solid white;
}

figure.snip0078:hover figcaption,
figure.snip0078.hover figcaption {
  -webkit-transform: translateY(-8px);
  transform: translateY(-8px);
  box-shadow: 0 15px 15px -15px #000000;
}
figure.snip0078:hover.blue img {
  border: 5px solid gray;
}
.comment-makguli-list{
	margin-left: -50px !important;
}
.comment-image-list{
	margin-left: -30px !important;
}
.panel-default{
	width: 95% !important;
}
.comment-nickname{
	margin-left: -80px !important;
}
</style>
<script type="text/javascript">
  jQuery(document).ready(function($){
	  var likeCheck = "n";
	  
	  function userLikeCheck(){
		  $.ajax({
				url: '/altaltal/userLikeCheck.ho',
				type: 'POST',
				data: { "member_email" : '<%=email %>',
							"makguli_num" : '<%=makguli.getMakguli_num() %>'	},
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				success: function(data){
					alert("userLikeCheck : " + data);
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
				data: { "member_email" : '<%=email %>',
						   "makguli_num" : '<%=makguli.getMakguli_num() %>',
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
					 $('#mboard_body').val("5");
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
  	function commentCheck(){
		if('<%=email%>' == ""){  
			alert('회원만 코멘트를 남길 수 있습니다.');
			return false;
		}
		  
		if($('#mboard_content').val() == null || $('#mboard_content').val() === ""){
			alert('평가코멘트를 남겨주세요.');
			$('#pboard_content').focus();
			return false;
		}
		
		if($('#mboard_sweat').val() == null || $('#mboard_sweat').val() === "0"){
			alert('단맛 점수를 메겨주세요.');
			$('#mboard_sweat').focus();
			return false;
		}
		
		if($('#mboard_sour').val() == null || $('#mboard_sour').val() === "0"){
			alert('신맛 점수를 메겨주세요.');
			$('#mboard_sour').focus();
			return false;
		}
		
		if($('#mboard_body').val() == null || $('#mboard_body').val() === "0"){
			alert('바디감 점수를 메겨주세요.');
			$('#mboard_body').focus();
			return false;
		}
		
		if($('#mboard_spark').val() == null || $('#mboard_spark').val() === "0"){
			alert('탄산 점수를 메겨주세요.');
			$('#mboard_spark').focus();
			return false;
		}
		
		if($('#mboard_popular').val() == null || $('#mboard_popular').val() === "0"){
			alert('대중성 점수를 메겨주세요.');
			$('#mboard_popular').focus();
			return false;
		}
		 
		return true;
	}
</script>
</head>
<body>
<jsp:include page="../menubar.jsp" flush="true" />
    <section class="container all_body_content">
        <div class="makguli">
            <div class="row mg-mginfo">
                <div class="col-md-7">
                    <div class="mg-list">
                        <div class="row">
                            <div class="mg-title col-md-6">
                                <%=makguli.getMakguli_name() %>
                                <span class="mg-area"><%=makguli.getMakguli_area() %></span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mg-info">
                        <div class="row mg-line">
                            <div class="mg-details col-xs-3"><img src="./resources/image/brewery.png">제조사</div>
                            <div class="mg-make col-xs-9 allfont"><%=makguli.getMakguli_make() %></div>
                        </div>
                        <div class="row mg-line">
                            <div class="mg-details col-xs-3"><img src="./resources/image/url.png">홈페이지</div>
                            <div class="mg-url col-xs-9 allfont">
                                <a href="<%=makguli.getMakguli_make_url() %>" target="_blank"><%=makguli.getMakguli_make_url() %></a></div>
                        </div>
                        <div class="row mg-line">
                            <div class="mg-details col-xs-3"><img src="./resources/image/diet.png">재료</div>
                            <div class="mg-ingre col-xs-9 allfont"><%=makguli.getMakguli_ingre() %></div>
                        </div>
                        <div class="row mg-line">
                            <div class="mg-details col-xs-3"><img src="./resources/image/degree.png">도수</div>
                            <div class="mg-degree col-xs-9 allfont"><%=makguli.getMakguli_degree() %>&nbsp;%</div>
                        </div>

                        <div class="row mg-line">
                            <div class="mg-details col-xs-3"><img src="./resources/image/book.png">설명</div>
                            <div class="mg-content col-xs-9 allfont">
								<%=makguli.getMakguli_content() %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-5">
                		<div class='item1-button-like'>
                        <img src="./resources/image/movelist.png" width="50" height="50"
                        onclick="location.href='getMakguliList.ma?makguli_area=<%=makguli.getMakguli_area() %>&page=<%=nowPage %>&keyword=<%=keyword %>';" 
                        id="btn-list" data-toggle="popover" data-placement="left" data-trigger="hover" data-content="막걸리 목록">
                        </div>
                        <div class='item1-button-like'>
                            <img src="./resources/image/pencil.png" width="53" height="53"
                               onclick="$('#my-tabs-place a:first').tab('show'); location.href='#comment-div-content';" 
                                 id="btn-comment" data-toggle="popover" data-placement="bottom" data-trigger="hover" data-content="평가하기" />
                           </div>
                        <span id="like-div">               
                        </span>
	                    <div class="mg-img">
	                    
						<figure class="snip0078 hover blue">
						  <img src="<spring:url value='/image/makguli/${makguli.makguli_picture }' />" alt="sampl45" />
						  <figcaption>
						    <p>
						    	  <i class="glyphicon glyphicon-heart"></i>&nbsp;<span id="makguli-likecount"><%=makguli.getMakguli_likecount()%></span>&nbsp;&nbsp;
						    	  <i class="glyphicon glyphicon-eye-open"></i>&nbsp;<%=makguli.getMakguli_readcount()%>
						    </p>
						  </figcaption>
						</figure>
	                        <%-- <img src="<spring:url value='/image/makguli/${makguli.makguli_picture }' />"> --%>
	                    </div>  <!-- 막걸리 이미지 -->
	                    <div id="myChart" class="mg-diagram">
	                   	평가항목
	                    </div>
                </div>
            </div>
            
    
            	<div class="container mg-comment">
					  <ul class="nav nav-tabs " id="my-tabs-place">
					    <li><a data-toggle="tab" href="#comment-div-content"><i class="glyphicon glyphicon-pencil"></i>&nbsp;&nbsp;막걸리 평가</a></li>
					  </ul>
					
					  <div class="tab-content">
					  	<!--  한줄 평가 -->
					    <div id="comment-div-content" class="container-fulid tab-pane fade">
							<div class="row comment_div"> 
							<section class="comment-list"><!--  댓글 시작 -->
					       					
					       		<!-- 해당글 댓글 입력하는 공간 --> 
					       		<br/>
					       		<form action="insertMakguliComment.ma" id="commentForm" name="commentForm" method='post' onsubmit="return commentCheck();">		
					       		<input type="hidden" name="makguli_num" value="<%=makguli.getMakguli_num() %>" />
					       		<article class="row">
					       		<div class="col-md-1 col-sm-1 hidden-xs"></div>
					           	<div class="col-md-1 col-sm-1 hidden-xs">
					              <figure class="thumbnail-comment">
					              <%if(session.getAttribute("profile") == null){ %>
						               <img class="img-responsive comment-image-list" src="./resources/image/guest.png" width="60" height="60" /> 
						          <%}else{%> 
						        		<img class="img-responsive comment-image-list" src="<spring:url value='/image/profile/${sessionScope.profile }' />" width="60" height="60" />
						          <% } %>
					              </figure>
					            </div>
					            <div class="col-md-10 col-sm-10 comment-makguli-list">
					              <div class="panel panel-default arrow left ">
					                <div class="panel-body">
					                  <div class="comment-post">
						                  <div class="comment-star-div">
						                   		단맛 :&nbsp;
								             <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sweat-star1" >
										     <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sweat-star2" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sweat-star3" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sweat-star4" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sweat-star5" >
						                   		&nbsp;&nbsp;&nbsp;신맛 :&nbsp;
								             <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sour-star1" >
										     <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sour-star2" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sour-star3" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sour-star4" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="sour-star5" >
						                   		&nbsp;&nbsp;&nbsp;바디감 :&nbsp;
								             <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="body-star1" >
										     <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="body-star2" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="body-star3" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="body-star4" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="body-star5" >
											 &nbsp;&nbsp;&nbsp;탄산 :&nbsp;
								             <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="spark-star1" >
										     <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="spark-star2" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="spark-star3" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="spark-star4" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="spark-star5" >
											 &nbsp;&nbsp;&nbsp;대중성 :&nbsp;
								             <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="popular-star1" >
										     <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="popular-star2" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="popular-star3" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="popular-star4" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="popular-star5" >
											 <input type="hidden" id="mboard_sweat" name="mboard_sweat" value="0" />
											 <input type="hidden" id="mboard_sour" name="mboard_sour" value="0" />
											 <input type="hidden" id="mboard_body" name="mboard_body" value="0" />
											 <input type="hidden" id="mboard_spark" name="mboard_spark" value="0" />
											 <input type="hidden" id="mboard_popular" name="mboard_popular" value="0" />
										  </div>
										  <br/>
					                    <p>
					                     <textarea id='mboard_content' rows="2" cols="120" name="mboard_content" placeholder=" comment here..." ></textarea>
					                    </p>
					                    <p class="text-right button-line">
						             		<button style="padding-right: 7px;" type="submit" class="btn btn-default btn-sm" ><i class="glyphicon glyphicon-share-alt"></i> reply</button><br/>
									 	</p>
					                  </div>
					                </div>
					              </div>
					            </div>
					          </article>
					          </form>	<!-- 해당글 댓글 입력하는 공간 --> 
					       	<div  id="reply-list" >
					<%if(mboardList != null || mboardList.size() !=0){
					   		for(int i = 0; i<mboardList.size(); i++){
					   
					%>    	
					       	<article class="row">
					       	<div class="col-md-1 col-sm-1 hidden-xs"></div>
					           	<div class="col-md-1 col-sm-1 hidden-xs">
					              <figure class="thumbnail-comment">
						        		<img class="img-responsive comment-image-list" src="/altaltal/image/profile/<%=mboardList.get(i).get("member_picture").toString() %>" width="60" height="60" />
						        		<div style="text-align:center;" class="comment-nickname"><%= mboardList.get(i).get("member_nickname").toString()%></div><br/>
					              </figure>
					            </div>
					            <div class="col-md-10 col-sm-10 comment-makguli-list">
					              <div class="panel panel-default arrow left">
					                <div class="panel-body">
					                  <div class="comment-post">
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
							                  		for(int j=0; j<1; j++){
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
							                  		for(int j=0; j<1; j++){
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
							                  		for(int j=0; j<1; j++){
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
							                  		for(int j=0; j<1; j++){
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
							                  		for(int j=0; j<1; j++){
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
					                      <div style="text-align:right; padding-right:5px;">작성일시 : <%= sdf.format((Date)mboardList.get(i).get("mboard_date"))%></div>
					                  </div>
					                </div>
					              </div>
					            </div>
					          </article>
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
					       	</div> <!-- 해당글 댓글 들어가는 공간 -->
							</section>
							</div>
    					</div>
            </div>
        </div>
        </div>
    </section> <!--all_body_content   -->
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