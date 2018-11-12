<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.spring.altaltal.hotplace.PlaceboardVO"%>
<%@ page import="com.spring.altaltal.hotplace.HotplaceVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page import="com.spring.altaltal.freeboard.PageInfo"%>
<%
	
 	String keyword = (String)request.getAttribute("keyword");
 	int nowPage = Integer.parseInt(request.getAttribute("page").toString());
 	HotplaceVO place = (HotplaceVO)request.getAttribute("place");
 	String blog_number = (String)request.getAttribute("blog_number");
 	String[] pictures = place.getPlace_picture().split("/");
 
 	String email = "";
	if(session.getAttribute("email") != null){
		email =(String)session.getAttribute("email");
	}
	
	String nickname = "";
	if(session.getAttribute("nickname") != null){
		nickname =(String)session.getAttribute("nickname");
	}
	
	ArrayList<HashMap<String, Object>> pboardList = (ArrayList<HashMap<String, Object>>)request.getAttribute("pboardList");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount = pageInfo.getListCount();
	int commentPage = pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
	int tasteSum = 0;
	int priceSum = 0;
	int serviceSum = 0;
	double tasteAve = 0;
	double priceAve = 0;
	double serviceAve = 0;
	
	if(pboardList.size() != 0){
		for(int i=0; i<pboardList.size(); i++){
			tasteSum += Integer.parseInt(pboardList.get(i).get("pboard_taste").toString());
			priceSum += Integer.parseInt(pboardList.get(i).get("pboard_price").toString());
			serviceSum += Integer.parseInt(pboardList.get(i).get("pboard_service").toString());
		}
		
		tasteAve = tasteSum/pboardList.size();
		priceAve = priceSum/pboardList.size();
		serviceAve = serviceSum/pboardList.size();
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

    <title>Document</title>

<style>
.wrap {
            padding-bottom: 150px;
            position: relative;
        }
.all_body_content {
            min-height: 100%;
        }

        /*이름과 조회수 ,  좋아요, 평가하기 버튼 */

        #item1 {
            margin-bottom: 20px;
            background-color: rgba(245, 245, 245, 0.45);
            width: auto;
            height: 152px;

        }
        .item1-header {
            width: 100%;
        }

        #item1-header-top {
            padding-top: 12px;
            padding-bottom: 12px;
            font-size: 36px;
            text-align: left;
            font-weight: 300;
        }

        #item1-header-bottom {
            padding-top: 12px;
            padding-bottom: 12px;
            width: 100%;
            display: flex;

        }

        #item1-header-left {
            width: 70%;
        }

        #item1-header-right {
            width: 30%;
        }

        #item1-header-divider {
            float: left;
            width: 100%;
            border-bottom: 1px solid #E5E0E0;
            opacity: 1;
        }
        #item1-stats {
            float: left;
            width: 100%;
        }

        .item1-stats {
            display: inline-block;
            text-align: left;
            height: 61px;
            margin-right: 30px;
        }
        .item1-stats-count {
            color: #9D9A9A;
            font-size: 22px;
            line-height: 27px;
            font-weight: 300;
        }
        .item1-stats-title {
            color: #9D9A9A;
            font-size: 15px;
            line-height: 19px;
            font-weight: 100;
        }
        #item1-header-right {
            width: 30%;
        }

        .item1-button-review {
            display: inline-block;
            text-align: left;
        }

        #review-icon {
            float: left;
            display: inline-block;
            width: 24px;
            height: 22px;
            background: url("./resources/image/write-review.png") center no-repeat;
            background-size: cover;
        }

        #review-text {
            display: inline-block;
            color: #9D9A9A;
            font-size: 15px;
            height: 22px;
            line-height: 22px;
        }

        #review-text:hover {
            color: #9D9A9A;
        }

        .item1-button-like {
            display: inline-block;
            width: 60px;
            text-align: left;
        }

        .item1-button-review img {
            height: 22px;
        }


        #favorite_btn #fvr-icon {
            float: left;
            display: inline-block;
            width: 24px;
            height: 22px;
            margin-left: 25px;
            background: url(./resources/image/heart.png) center no-repeat;
            background-size: cover;
        }

        #favorite_btn.active #fvr-icon {
            float: left;
            display: inline-block;
            width: 24px;
            height: 22px;
            margin-left: 25px;
            background: url(./resources/image/heart_active.png) center no-repeat;
            background-size: cover;
        }

        #favorite_btn #fvr-text {
            display: inline-block;
            color: #fff;
            font-size: 15px;
            line-height: 22px;
        }

        #favorite_btn #fvr-text:hover {
            color: #fff;
        }

        /*이름과 조회수  좋아요, 평가하기 버튼 */

        /*본문 과 다이어그램*/

        .item2-body {
            border: noen;
            width: 100%;
            height: 300px;
            padding: 0px;
        }
        #map {
            border: none;
            width: 100%;
            height: 350px;
        }

        .item2-row {
            width: 100%;
            margin: 0;
        }

        .item2-body-content {
            width: 50%;
            height: 300px;
            border: none;
            padding: 12px;
        }

        .item2-information {
            display: flex;
            display: -webkit-flex;
            margin-bottom: 28px;
        }

        .item2-information-icon img {
            width: 22px;
            height: 22px;
        }

        .item2-information-text {
            height: 19px;
            font-size: 15px;
            font-weight: normal;
            font-style: normal;
            font-stretch: normal;
            color: #4a4a4a;
            margin-left: 10px;
            flex: 1;
            text-align: left;
        }

        .item2-information-text a {
            margin-left: 2px;
            color: inherit !important;
            font-size: inherit !important;
        }

        .item2-information-text a:hover {
            text-decoration: underline;
        }

        .item2-information-divider {
            width: 100%;
            margin: 19px 0;
            border: none;
            opacity: 0.5;
        }

        #item2-tel {
            margin-bottom: 7px;
        }

        #item2-action-bar {
            float: left;
            width: 100%;
        }
        .item2-diagram {
            border: none;
            width: 100%;
            height: 82%;
            padding: 0 12px 12px 12px;
        }
        .item2-diagram-content {
            width: 50%;
            height: 300px;
            border: none;
            padding: 12px;
            
        }
        .diagram-text-item2{
        	display: flex;
            display: -webkit-flex;
        	margin-bottom: 0px;
        }

        /*본문 과 다이어그램*/

        /*사진 슬라이드*/

        .item3 {
            border: 1px solid none;
            width: 100%;
            min-height: 250px;
            margin-bottom: 15px;
        }
        .row-carousel{
        margin: 0 20px !important;
        }
      .thumbnail{
            width:300px;
            height:250px;
            padding: 20px;
            border: none !important;
        }
       
        /* The controlsy */
        .carousel-control {
            height: 20px;
            width: 20px;
            margin-top: 130px;
            background-image: none !important;
        }
     	 .carousel-control.left{
          left: -85px !important;
          }
        .carousel-control.right {
            right: -85px !important;
        }
        .btn-circle.btn-lg {
		  width: 50px;
		  height: 50px;
		  padding: 9px 8px 7px 6px;
		  font-size: 18px;
		  line-height: 1.5;
		  border-radius: 25px;
		}
		
		.carousel .item{
		width:100%;
		}
		.carousel .item img{
		width:100%;
		height:100%;
		margin:auto;
		}
        /*사진 슬라이드*/

/*평가css */
        .item4 {
            border: 1px solid powderblue;
            width: 960px;
            height: 300px;
        }
        .comment-star-div{
        	margin-bottom: 10px;
        	vertical-align: center;
        }
/*평가css*/


/* 블로그css*/
        .item5 {
        	margin-top: 20px;
            border: none;
            width: 960px;
            height: 300px;
        }
/* 블로그css*/

.ds-btn li{ list-style:none; float:left; padding:5px;}
.ds-btn li a span{width:100%;display:inline-block; text-align:center;}
.ds-btn li a span small{width:100%; display:inline-block; text-align:left; padding-left:15px;}

/* 탭(평가, 블로그 리뷰) */
.nav-tabs { border-bottom: 2px solid #DDD; }
.nav-tabs > li.active > a, .nav-tabs > li.active > a:focus, .nav-tabs > li.active > a:hover { border-width: 0; }
.nav-tabs > li > a { border: none; color: #666; }
.nav-tabs > li.active > a, .nav-tabs > li > a:hover { border: none; color: #4285F4 !important; background: transparent; } /* 눌렀을때 글자색깔 */
.nav-tabs > li > a::after { content: ""; background: #6a6463; height: 2px; position: absolute; width: 100%; left: 0px; bottom: -1px; transition: all 250ms ease 0s; transform: scale(0); } /* 눌렀을때 선색깔 */
.nav-tabs > li.active > a::after, .nav-tabs > li:hover > a::after { transform: scale(1); }
.tab-nav > li > a::after { background: #21527d none repeat scroll 0% 0%; color: #fff; }
.tab-pane { padding: 5px 0; }
.tab-content{padding:5px; margin-top: 15px;}
/* 탭(평가, 블로그 리뷰) */

/* 평가부분 */
.comment-list .row {
  margin-bottom: 0px;
}
.comment-list .panel .panel-heading {

  position: absolute;
  border:none;
  /*Panel-heading border radius*/
  border-top-right-radius:0px;
  top: 1px;
}
.comment-list .panel .panel-heading.right {
  border-right-width: 0px;
  /*Panel-heading border radius*/
  border-top-left-radius:0px;
  right: 16px;
}
.comment-list .panel .panel-heading .panel-body {
  padding-top: 6px;
}
.comment-list figcaption {
  /*For wrapping text in thumbnail*/
  word-wrap: break-word;
}
/* Portrait tablets and medium desktops */
@media (min-width: 768px) {
  .comment-list .arrow:after, .comment-list .arrow:before {
    content: "";
    position: absolute;
    width: 0;
    height: 0;
    border-style: solid;
    border-color: transparent;
  }
  .comment-list .panel.arrow.left:after, .comment-list .panel.arrow.left:before {
    border-left: 0;
  }
  /*****Left Arrow*****/
  /*Outline effect style*/
  .comment-list .panel.arrow.left:before {
    left: 0px;
    top: 30px;
    /*Use boarder color of panel*/
    border-right-color: inherit;
    border-width: 16px;
  }
  /*Background color effect*/
  .comment-list .panel.arrow.left:after {
    left: 1px;
    top: 31px;
    /*Change for different outline color*/
    border-right-color: #FFFFFF;
    border-width: 15px;
  }
  /*****Right Arrow*****/
  /*Outline effect style*/
  .comment-list .panel.arrow.right:before {
    right: -16px;
    top: 30px;
    /*Use boarder color of panel*/
    border-left-color: inherit;
    border-width: 16px;
  }
  /*Background color effect*/
  .comment-list .panel.arrow.right:after {
    right: -14px;
    top: 31px;
    /*Change for different outline color*/
    border-left-color: #FFFFFF;
    border-width: 15px;
  }
}
.comment-list .comment-post {
  margin-top: 6px;
}
.commentReply{
	display: none;
}
.thumbnail-comment{
margin: auto;
text-align: center;
}
.panel-default{
	width: 97% !important;
}
.comment-updateform-article{
	display: none;
}
</style>
<script>
	$(document).ready(function(){
		
		function selectData(){
			
			$('#crolling-output').empty();
			
			$.ajax({
				url: '/altaltal/croling.ho',
				type: 'POST',
				data: {"place_num" : <%=place.getPlace_num()%>},
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				success: function(data){
					$.each(data, function(index, item){
						var output = '';
						output +='<div><blockquote><a href="' + item.url + '" target="_blank" >';
						output +='<strong><span style="color:black" data-toggle="popover" data-placement="right" data-trigger="hover" data-content="클릭하면 해당 블로그로 이동합니다." >'+ item.title + '</span></strong></a></blockquote></div>';
						output +='<div>' + item.content + '</div><br/>';
						$('#crolling-output').append(output);
						$('[data-toggle="popover"]').popover();
					});	
				},
				error: function() {alert('ajax 통신실패');}
			});
		}

		 var likeCheck = "n";
		  
		  function placeLikeCheck(){
			  $.ajax({
					url: '/altaltal/placeLikeCheck.ho',
					type: 'POST',
					data: { "member_email" : '<%=email %>',
								"place_num" : '<%=place.getPlace_num() %>'	},
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
		  
		  function placeLikeUpdate(){
			  $.ajax({
					url: '/altaltal/placeLikeUpdate.ho',
					type: 'POST',
					data: { "member_email" : '<%=email %>',
								"place_num" : '<%=place.getPlace_num() %>',
								"userLike" : likeCheck	},
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
					success: function(data){
						if('n' === data.status){
							likeCheck= 'n';
							$('#like-div').empty();
							$('#like-div').html('<img src="./resources/image/like_no.png" width="50" height="50" id="btn-like">');
						}else{
							likeCheck= 'y';
							$('#like-div').empty();
							$('#like-div').html('<img src="./resources/image/like_yes.png" width="50" height="50" id="btn-like">');
						}
						
						$('#place-like-count').empty();
						$('#place-like-count').text(data.likecount);
						likeButtonApply();
					},
					error: function(request, status, error) {alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);}
				});
			  
		  }
		
		if('<%=email%>' != ""){
			placeLikeCheck();
		}else{
			  $('#like-div').html('<img src="./resources/image/like_no.png" width="50" height="50" id="btn-like" />');
			  likeButtonApply();
		}
		
		function likeButtonApply(){
			  $("#btn-like").click(function(){
				  if('<%=email%>' != ""){  
					  placeLikeUpdate();
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
			  $('[data-toggle="popover"]').popover();
		  }
		
		
		$("#btn-list").mouseover(function(){
			  $("#btn-list").css("cursor", "pointer");
		 }).mouseout(function(){
			  $("#btn-list").css("cursor", "default");
		 });
		
		$("#btn-comment").mouseover(function(){
			  $("#btn-comment").css("cursor", "pointer");
		 }).mouseout(function(){
			  $("#btn-comment").css("cursor", "default");
		 });
		
		$(".starset").mouseover(function(){
			  $(".starset").css("cursor", "pointer");
		 }).mouseout(function(){
			  $(".starset").css("cursor", "default");
		 });
		
		$(".starUpdate").mouseover(function(){
			  $(".starUpdate").css("cursor", "pointer");
		 }).mouseout(function(){
			  $(".starUpdate").css("cursor", "default");
		 });
		
		 $(".starset").click(function(){
			 switch($(this).attr("id")){
			 	case "taste-star5" : {
			 		for(var i=1; i<=5; i++){
						 $('#taste-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
					 $('#pboard_taste').val("5");
			 	}
			 	break;
			 	case "taste-star4" : {
			 		for(var i=1; i<=4; i++){
						 $('#taste-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		$('#taste-star5').attr("src", "./resources/image/star_no.png");
					 $('#pboard_taste').val("4");
			 	}
			 	break;
			 	case "taste-star3" : {
			 		for(var i=1; i<=3; i++){
						 $('#taste-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=4; i<=5; i++){
						 $('#taste-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#pboard_taste').val("3");
			 	}
			 	break;
			 	case "taste-star2" : {
			 		for(var i=1; i<=2; i++){
						 $('#taste-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=3; i<=5; i++){
						 $('#taste-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#pboard_taste').val("2");
			 	}
			 	break;
			 	case "taste-star1" : {
						 $('#taste-star1').attr("src", "./resources/image/star_yes.png");
			 		for(var i=2; i<=5; i++){
						 $('#taste-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#pboard_taste').val("1");
			 	}
			 	break;	
			 	case "price-star5" : {
			 		for(var i=1; i<=5; i++){
						 $('#price-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
					 $('#pboard_price').val("5");
			 	}
			 	break;
			 	case "price-star4" : {
			 		for(var i=1; i<=4; i++){
						 $('#price-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		$('#price-star5').attr("src", "./resources/image/star_no.png");
					 $('#pboard_price').val("4");
			 	}
			 	break;
			 	case "price-star3" : {
			 		for(var i=1; i<=3; i++){
						 $('#price-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=4; i<=5; i++){
						 $('#price-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#pboard_price').val("3");
			 	}
			 	break;
			 	case "price-star2" : {
			 		for(var i=1; i<=2; i++){
						 $('#price-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=3; i<=5; i++){
						 $('#price-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#pboard_price').val("2");
			 	}
			 	break;
			 	case "price-star1" : {
						 $('#taste-star1').attr("src", "./resources/image/star_yes.png");
			 		for(var i=2; i<=5; i++){
						 $('#price-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#pboard_price').val("1");
			 	}
			 	break;
			 	case "service-star5" : {
			 		for(var i=1; i<=5; i++){
						 $('#service-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
					 $('#pboard_service').val("5");
			 	}
			 	break;
			 	case "service-star4" : {
			 		for(var i=1; i<=4; i++){
						 $('#service-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		$('#service-star5').attr("src", "./resources/image/star_no.png");
					 $('#pboard_service').val("4");
			 	}
			 	break;
			 	case "service-star3" : {
			 		for(var i=1; i<=3; i++){
						 $('#service-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=4; i<=5; i++){
						 $('#service-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#pboard_service').val("3");
			 	}
			 	break;
			 	case "service-star2" : {
			 		for(var i=1; i<=2; i++){
						 $('#service-star'+i).attr("src", "./resources/image/star_yes.png");
					  }
			 		for(var i=3; i<=5; i++){
						 $('#service-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#pboard_service').val("2");
			 	}
			 	break;
			 	case "service-star1" : {
						 $('#service-star1').attr("src", "./resources/image/star_yes.png");
			 		for(var i=2; i<=5; i++){
						 $('#service-star'+i).attr("src", "./resources/image/star_no.png");
					}
					 $('#pboard_service').val("1");
			 	}
			 	break;	 
			 } /* switch구문 끝! */
		  }); /* 클릭구문 끝! */
		
		$('[data-toggle="popover"]').popover();
		
		selectData();
	});
	
	function commentCheck(){
		if('<%=email%>' == ""){  
			alert('회원만 코멘트를 남길 수 있습니다.');
			return false;
		}
		  
		if($('#pboard_content').val() == null || $('#pboard_content').val() === ""){
			alert('평가코멘트를 남겨주세요.');
			$('#pboard_content').focus();
			return false;
		}
		
		if($('#pboard_price').val() == null || $('#pboard_price').val() === "0"){
			alert('가격 점수를 메겨주세요.');
			$('#pboard_price').focus();
			return false;
		}
		
		if($('#pboard_taste').val() == null || $('#pboard_taste').val() === "0"){
			alert('맛 점수를 메겨주세요.');
			$('#pboard_taste').focus();
			return false;
		}
		
		if($('#pboard_service').val() == null || $('#pboard_service').val() === "0"){
			alert('서비스 점수를 메겨주세요.');
			$('#pboard_service').focus();
			return false;
		}
		 
		return true;
	}
	
	function changeComment(pboard_num, writer){
		if('<%=nickname%>' !== writer){  
			alert('작성자만 수정 가능합니다.');
			return false;
		}else{
			if($('#'+pboard_num+'_div').css('display') == 'block'){
				$('#'+pboard_num+'_div').css('display', 'none');
				$('#'+pboard_num+'_update').css('display', 'block');
			}else{
				$('#'+pboard_num+'_div').css('display', 'block');
				$('#'+pboard_num+'_update').css('display', 'none');
			}
		}
	}
	function deleteComment(pboard_num, writer){
		if('<%=nickname%>' !== writer){  
			alert('작성자만 삭제 가능합니다.');
			return false;
		}else{
			if(confirm("해당 댓글을 삭제하시겠습니까?")){
				location.href="./deletePlaceComment.ho?place_num=<%=place.getPlace_num() %>&pboard_num="+ pboard_num + "&page=<%=nowPage%>&commentPage=<%=commentPage%>";
			}
		}
	}
	
	function cancelComment(pboard_num){
		if($('#'+pboard_num+'_div').css('display') == 'block'){
			$('#'+pboard_num+'_div').css('display', 'none');
			$('#'+pboard_num+'_update').css('display', 'block');
		}else{
			$('#'+pboard_num+'_div').css('display', 'block');
			$('#'+pboard_num+'_update').css('display', 'none');
		}
	}
	
	function starClick(pboard_num, obj){
		switch(obj.id){
		 	case ("taste-"+ pboard_num + "5") : {
		 		for(var i=1; i<=5; i++){
					 $('#taste-'+pboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
				 $('#'+pboard_num+'_taste').val("5");
		 	}
		 	break;
		 	case ("taste-"+ pboard_num + "4") : {
		 		for(var i=1; i<=4; i++){
					 $('#taste-'+pboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		$('#taste-'+ pboard_num +'5').attr("src", "./resources/image/star_no.png");
				 $('#'+pboard_num+'_taste').val("4");
		 	}
		 	break;
		 	case ("taste-"+ pboard_num + "3") : {
		 		for(var i=1; i<=3; i++){
					 $('#taste-'+pboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=4; i<=5; i++){
					 $('#taste-'+pboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+pboard_num+'_taste').val("3");
		 	}
		 	break;
		 	case ("taste-"+ pboard_num + "2") : {
		 		for(var i=1; i<=2; i++){
					 $('#taste-'+pboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=3; i<=5; i++){
					 $('#taste-'+pboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+pboard_num+'_taste').val("2");
		 	}
		 	break;
		 	case ("taste-"+ pboard_num + "1") : {
					 $('#taste-'+pboard_num+'1').attr("src", "./resources/image/star_yes.png");
		 		for(var i=2; i<=5; i++){
					 $('#taste-'+pboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+pboard_num+'_taste').val("1");
		 	}
		 	break;	
		 	case ("price-"+ pboard_num + "5") : {
		 		for(var i=1; i<=5; i++){
					 $('#price-'+pboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
				 $('#'+pboard_num+'_price').val("5");
		 	}
		 	break;
		 	case ("price-"+ pboard_num + "4") : {
		 		for(var i=1; i<=4; i++){
					 $('#price-'+pboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		$('#price-'+pboard_num+'5').attr("src", "./resources/image/star_no.png");
				 $('#'+pboard_num+'_price').val("4");
		 	}
		 	break;
		 	case ("price-"+ pboard_num + "3") : {
		 		for(var i=1; i<=3; i++){
					 $('#price-'+pboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=4; i<=5; i++){
					 $('#price-'+pboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+pboard_num+'_price').val("3");
		 	}
		 	break;
		 	case ("price-"+ pboard_num + "2") : {
		 		for(var i=1; i<=2; i++){
					 $('#price-'+pboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=3; i<=5; i++){
					 $('#price-'+pboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+pboard_num+'_price').val("2");
		 	}
		 	break;
		 	case ("price-"+ pboard_num + "1") : {
					 $('#price-'+pboard_num+'1').attr("src", "./resources/image/star_yes.png");
		 		for(var i=2; i<=5; i++){
					 $('#price-'+pboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+pboard_num+'_price').val("1");
		 	}
		 	break;
		 	case ("service-"+ pboard_num + "5") : {
		 		for(var i=1; i<=5; i++){
					 $('#service-'+pboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
				 $('#'+pboard_num+'_service').val("5");
		 	}
		 	break;
		 	case ("service-"+ pboard_num + "4") : {
		 		for(var i=1; i<=4; i++){
					 $('#service-'+pboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		$('#service-'+pboard_num+'5').attr("src", "./resources/image/star_no.png");
				 $('#'+pboard_num+'_service').val("4");
		 	}
		 	break;
		 	case ("service-"+ pboard_num + "3") : {
		 		for(var i=1; i<=3; i++){
					 $('#service-'+pboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=4; i<=5; i++){
					 $('#service-'+pboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+pboard_num+'_service').val("3");
		 	}
		 	break;
		 	case ("service-"+ pboard_num + "2") : {
		 		for(var i=1; i<=2; i++){
					 $('#service-'+pboard_num+i).attr("src", "./resources/image/star_yes.png");
				  }
		 		for(var i=3; i<=5; i++){
					 $('#service-'+pboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+pboard_num+'_service').val("2");
		 	}
		 	break;
		 	case ("service-"+ pboard_num + "1") : {
					 $('#service-'+pboard_num+'1').attr("src", "./resources/image/star_yes.png");
		 		for(var i=2; i<=5; i++){
					 $('#service-'+pboard_num+i).attr("src", "./resources/image/star_no.png");
				}
				 $('#'+pboard_num+'_service').val("1");
		 	}
		 	break;	 
			}  /* switch 끝 */
	} /* function 끝 */
	
	function commentSubmit(this_form){
		if(this_form.pboard_content == "" || this_form.pboard_content == null){
			alert("댓글란을 작성해주세요.");
			this_form.pboard_content.focus();
			return false;
		}
		if(this_form.pboard_serive == "0"){
			alert("서비스 점수를 매겨주세요.");
			return false;
		}
		if(this_form.pboard_taste == "0"){
			alert("맛 점수를 매겨주세요.");
			return false;
		}
		if(this_form.pboard_price == "0"){
			alert("가격 점수를 매겨주세요.");
			return false;
		}
		this_form.submit();
	}
</script> <!-- 크롤링 -->
</head>

<body>
<jsp:include page="../menubar.jsp" flush="true" />
    <div class="wrap">

<section>
            <div id="map"></div>
            
            <div class="all_body_content">
                <div id="item1">
                    <div class="row">
                        <div class="item1-header container">
                            <div id="item1-header-top">
                                <%=place.getPlace_name() %>
                            </div>
                            <div id="item1-header-divider"></div>

                            <div id="item1-header-bottom">
                                <div id="item1-header-left">
                                    <div id="item1-stats">
                                        <div class="item1-stats">
                                            <div class="item1-stats-count" style="text-align:center;" ><%=place.getPlace_readcount() %></div>
                                            <div class="item1-stats-title">조회수</div>
                                        </div>
                                        <div class="item1-stats">
                                            <div class="item1-stats-count" id="place-like-count" style="text-align:center;"><%=place.getPlace_likecount() %></div>
                                            <div class="item1-stats-title">좋아요</div>
                                        </div>
                                        <div class="item1-stats">
                                                <div class="item1-stats-count" style="text-align:center;" ><%=pboardList.size() %></div>
                                                <div class="item1-stats-title">평가</div>
                                        </div>
                                        <div class="item1-stats">       
                                                <div class="item1-stats-count" style="text-align:center;" ><%=blog_number %></div>
                                                <div class="item1-stats-title">블로그</div> 
                                        </div>
                                    </div>
                                </div>
                                <div id='item1-header-right'>
                                    <div class='pull-right'>
                                    	<div class='item1-button-like'>
                                    	<img src="./resources/image/movelist.png" width="50" height="50"
					                        onclick="location.href='getHotplaceList.ho?place_area=<%=place.getPlace_area() %>&page=<%=nowPage %>&keyword=<%=keyword %>'"
					                        id="btn-list" data-toggle="popover" data-placement="left" data-trigger="hover" data-content="맛집 목록" />
                                        </div>
                                        <div class='item1-button-like'>
                                            <img src="./resources/image/pencil.png" width="50" height="50"
                                             onclick="$('#my-tabs-place a:first').tab('show'); location.href='#comment-div-content';" 
                                             id="btn-comment" data-toggle="popover" data-placement="bottom" data-trigger="hover" data-content="평가하기" />
                                        </div>
                                        <div class='item1-button-like' id="like-div">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container item2-body">
                    <div class="row item2-row">
                        <div class="item2-body-content col-xs-6">
                            <div class="item2-information">
                                <div class="item2-information-icon">
                                    <img src="./resources/image/tag.png">
                                </div>
                                <div class="item2-information-text"><%=place.getPlace_content() %></div>
                            </div>
                            <div class="item2-information">
                                <div class="item2-information-icon">
                                    <img src="./resources/image/address.png">
                                </div>
                                <div class="item2-information-text"><%=place.getPlace_juso() %></div>
                            </div>
                            <div class="item2-information" id="item-tel">
                                <div class="item2-information-icon">
                                    <img src="./resources/image/call.png">
                                </div>
                                <div class="item2-information-text"><%=place.getPlace_phone() %></div>
                            </div>

                            <div class="item2-information" id="item-tel">
                                <div class="item2-information-icon">
                                    <img src="./resources/image/menu.png">
                                </div>
                                <div class="item2-information-text"><%=place.getPlace_menu() %></div>
                            </div>

                            <div class="item2-information" id="item-tel">
                                <div class="item2-information-icon">
                                    <img src="./resources/image/11.png">
                                </div>
                                <div class="item2-information-text">평균 가격대 : 
                                <%if(place.getPlace_price().equals("9choen")){ %>1만원 이하<%}%>
								<%if(place.getPlace_price().equals("1man")){ %>1만원 ~ 2만원<%}%>
								<%if(place.getPlace_price().equals("2man")){ %>2만원 ~ 3만원<%} %>
								<%if(place.getPlace_price().equals("3man")){ %>3만원 ~ 4만원<%}%>
								<%if(place.getPlace_price().equals("4man")){ %>4만원 ~ 5만원<%} %>
								<%if(place.getPlace_price().equals("4man")){ %>5만원 이상<%} %></div>
                            </div>
                        </div>
                        
 						<div class=" col-xs-6 item2-diagram-content">
 						<div class="diagram-text-item2" id="item-tel">
                                <div class="item2-information-icon">
                                    <img src="./resources/image/menu.png">
                                </div>
                                <div class="item2-information-text" >평가항목</div>
                          </div>
                        <div id="myChart" class="item2-diagram" ></div> <!-- 다이어그램 -->
						</div>
                    </div>
                </div>


                <div class="container item3">
                    <div class="row row-carousel">
                        <div class="col-md-12">
                            <div id="Carousel" class="carousel slide">
                                <!-- Carousel items -->
                                <div class="carousel-inner">
                                    <div class="item active">
                                        <div class="row row-carousel">
                                            <div class="col-md-4">
                                                <a class="thumbnail">
                                                    <img class="img" src="/altaltal/image/place/<%=pictures[0] %>" alt="Image" />
                                                </a>					
                                            </div>
                                            <div class="col-md-4">
                                                <a class="thumbnail">
                                                    <img class="img" src="/altaltal/image/place/<%=pictures[1] %>" alt="Image"/>
                                                </a>
                                            </div>
                                            <div class="col-md-4">
                                                <a class="thumbnail">
                                                    <img class="img" src="/altaltal/image/place/<%=pictures[2] %>" alt="Image"  />
                                                </a>
                                            </div>

                                        </div>
                                        <!--.row-->
                                    </div>
                                    <!--.item-->

                                    <div class="item">
                                        <div class="row row-carousel">
                                            <div class="col-md-4">
                                                <a class="thumbnail">
                                                    <img class="img" src="/altaltal/image/place/<%=pictures[3] %>" alt="Image" />
                                                </a>
                                            </div>
                                            <div class="col-md-4">
                                                <a class="thumbnail">
                                                    <img class="img" src="/altaltal/image/place/<%=pictures[4] %>" alt="Image"/>
                                                </a>
                                            </div>
                                            <div class="col-md-4">
                                                <a class="thumbnail">
                                                    <img class="img" src="/altaltal/image/place/<%=pictures[5] %>" alt="Image"/>
                                                </a>
                                            </div>
                                        </div>
                                        <!--.row-->
                                    </div>
                                    <!--.item-->
                                </div>
                                <!--.carousel-inner-->
                                
                                <!-- 좌우 컨트롤 버튼 -->  
                                <a class="left carousel-control" href="#Carousel" data-slide="prev">
                                    <i class="glyphicon glyphicon-chevron-left"></i>
                                </a>
                                <a class="right carousel-control" href="#Carousel" data-slide="next">
                                    <i class="glyphicon glyphicon-chevron-right"></i>
                                </a>
                            </div>
                            <!--.Carousel-->
                        </div>
                    </div>
                </div> <!-- 사진 끝-->
                
                <!-- 평가, 블로그 리뷰 -->
			     <div class="container">
					  <ul class="nav nav-tabs " id="my-tabs-place">
					    <li><a data-toggle="tab" href="#comment-div-content"><i class="glyphicon glyphicon-pencil"></i>&nbsp;&nbsp;맛집 평가</a></li>
					    <li><a data-toggle="tab" href="#crolling-output"><i class="glyphicon glyphicon-bold"></i>&nbsp;블로그 리뷰</a></li>	
					  </ul>
					
					  <div class="tab-content">
					  	<!--  한줄 평가 -->
					    <div id="comment-div-content" class="tab-pane fade">
							<div class="row comment_div">
					       			<section class="comment-list">
					       					
					       		<!-- 해당글 댓글 입력하는 공간 --> 
					       		
					       		<form action="insertPlaceComment.ho" id="commentForm" name="commentForm" method='post' onsubmit="return commentCheck();">		
					       		<input type="hidden" name="place_num" value="<%=place.getPlace_num() %>" />
					       		<article class="row">
					       		<div class="col-md-1 col-sm-1"></div>
					           	<div class="col-md-1 col-sm-1 hidden-xs">
					              <figure class="thumbnail-comment">
					              <%if(session.getAttribute("profile") == null){ %>
						               <img class="img-responsive" src="./resources/image/guest.png" width="60" height="60" /> 
						          <%}else{%> 
						        		<img class="img-responsive" src="<spring:url value='/image/profile/${sessionScope.profile }' />" width="60" height="60" />
						          <% } %>
					              </figure>
					            </div>
					            <div class="col-md-8 col-sm-8">
					              <div class="panel panel-default arrow left">
					                <div class="panel-body">
					                  <div class="comment-post">
						                  <div class="comment-star-div">
						                   		맛 :&nbsp;
								             <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="taste-star1" >
										     <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="taste-star2" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="taste-star3" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="taste-star4" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="taste-star5" >
						                   		&nbsp;&nbsp;&nbsp;가격 :&nbsp;
								             <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="price-star1" >
										     <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="price-star2" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="price-star3" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="price-star4" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="price-star5" >
						                   		&nbsp;&nbsp;&nbsp;서비스 :&nbsp;
								             <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="service-star1" >
										     <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="service-star2" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="service-star3" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="service-star4" >
											 <img class="starset" src="./resources/image/star_no.png" width="20" height="20" id="service-star5" >
											 <input type="hidden" id="pboard_taste" name="pboard_taste" value="0" />
											 <input type="hidden" id="pboard_price" name="pboard_price" value="0" />
											 <input type="hidden" id="pboard_service" name="pboard_service" value="0" />
										  </div>
					                    <p>
					                     <textarea id='pboard_content' rows="2" cols="95" name="pboard_content" placeholder="comment here..." ></textarea>
					                    </p>
					                  </div>
					                  <p class="text-right">
						             	<button  style="margin-right:5px;" type="submit" class="btn btn-default btn-sm" ><i class="glyphicon glyphicon-share-alt"></i> reply</button><br/>
									  </p>
					                </div>
					              </div>
					            </div>
					          </article>
					          </form>	<!-- 해당글 댓글 입력하는 공간 --> 
					       	<div  id="reply-list" >
					<%if(pboardList != null || pboardList.size() !=0){
					   		for(int i = 0; i<pboardList.size(); i++){
					   
					%>    	
					       	<article class="row" id="<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>_div" >
					       		<div class="col-md-1 col-sm-1"></div>
					           	<div class="col-md-1 col-sm-1 hidden-xs">
					              <figure class="thumbnail-comment">
						        		<img class="img-responsive" src="/altaltal/image/profile/<%=pboardList.get(i).get("member_picture").toString() %>" width="60" height="60" />	
					              </figure>
					            </div>
					            <div class="col-md-8 col-sm-8">
					              <div class="panel panel-default arrow left">
					                <div class="panel-body">
					                  <div class="comment-post">
					                  <div style="margin-bottom: 5px;">
					                  <i class='glyphicon glyphicon-user'></i> <%= pboardList.get(i).get("member_nickname").toString()%>&nbsp;&nbsp;
					                  <i class='glyphicon glyphicon-time'></i> <%= sdf.format((Date)pboardList.get(i).get("pboard_date"))%>
					                  </div> 
						                  <div class="comment-star-div">
						                   		맛 :&nbsp;
						            <% 
						                  	switch(Integer.parseInt(pboardList.get(i).get("pboard_taste").toString())){
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
						                   		&nbsp;&nbsp;&nbsp;가격 :&nbsp;
									<% 
						                  	switch(Integer.parseInt(pboardList.get(i).get("pboard_price").toString())){
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
						                   		&nbsp;&nbsp;&nbsp;서비스 :&nbsp;
<% 
						                  	switch(Integer.parseInt(pboardList.get(i).get("pboard_service").toString())){
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
					                    <p>
					                     <textarea rows="2" cols="95" name="pboard_content" readonly="readonly" >&nbsp;<%=pboardList.get(i).get("pboard_content").toString() %></textarea>
					                    </p>
					                    <div style="text-align: right; padding-right:5px;">
					                    <button type='button' 
					                    onclick="changeComment('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', '<%= pboardList.get(i).get("member_nickname").toString()%>');"
					                    class='btn btn-default btn-sm' ><i class='glyphicon glyphicon-scissors'></i> modify</button>
					                    &nbsp;&nbsp;
					                    <button type='button' 
					                    onclick="deleteComment('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', '<%= pboardList.get(i).get("member_nickname").toString()%>');"
					                    class='btn btn-default btn-sm' ><i class='glyphicon glyphicon-trash'></i> delete</button>
					                    </div>
					                  </div>
					                </div>
					              </div>
					            </div>
					          </article>
					          
					          <!--  댓글 수정란 -->
					          <form action="updatePlaceComment.ho" method="post" >
					          <input type="hidden" name="pboard_num" value="<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>" />
					          <input type="hidden" name="place_num" value="<%=place.getPlace_num() %>" />
					          <input type="hidden" name="page" value="<%=nowPage %>" />
					          <input type="hidden" name="commentPage" value="<%=commentPage %>" />
					          <article class="row comment-updateform-article" id="<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>_update" >
					       		<div class="col-md-1 col-sm-1"></div>
					           	<div class="col-md-1 col-sm-1 hidden-xs">
					              <figure class="thumbnail-comment">
						        		<img class="img-responsive" src="/altaltal/image/profile/<%=pboardList.get(i).get("member_picture").toString() %>" width="60" height="60" />	
					              </figure>
					            </div>
					            <div class="col-md-8 col-sm-8">
					              <div class="panel panel-default arrow left">
					                <div class="panel-body">
					                  <div class="comment-post">
					                  <div style="margin-bottom: 5px;">
					                  <i class='glyphicon glyphicon-user'></i> <%= pboardList.get(i).get("member_nickname").toString()%>&nbsp;&nbsp;
					                  <i class='glyphicon glyphicon-time'></i> <%= sdf.format((Date)pboardList.get(i).get("pboard_date"))%>
					                  </div> 
						                  <div class="comment-star-div">
						                   		맛 :&nbsp;
								             <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="taste-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>1" >
										     <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="taste-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>2" >
											 <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="taste-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>3" >
											 <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="taste-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>4" >
											 <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="taste-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>5" >
						                   		&nbsp;&nbsp;&nbsp;가격 :&nbsp;
								             <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="price-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>1" >
										     <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="price-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>2" >
											 <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="price-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>3" >
											 <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="price-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>4" >
											 <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="price-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>5" >
						                   		&nbsp;&nbsp;&nbsp;서비스 :&nbsp;
								             <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="service-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>1" >
										     <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="service-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>2" >
											 <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="service-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>3" >
											 <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="service-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>4" >
											 <img onclick="starClick('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>', this);" class="starUpdate" src="./resources/image/star_no.png" width="20" height="20" id="service-<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>5" >
											 <input type="hidden" id="<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString()) %>_taste" name="pboard_taste" value="<%=Integer.parseInt(pboardList.get(i).get("pboard_taste").toString()) %>" />
											 <input type="hidden" id="<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString()) %>_price" name="pboard_price" value="<%=Integer.parseInt(pboardList.get(i).get("pboard_price").toString()) %>" />
											 <input type="hidden" id="<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString()) %>_service" name="pboard_service" value="<%=Integer.parseInt(pboardList.get(i).get("pboard_service").toString()) %>" />
										  </div>
					                    <p>
					                     <textarea rows="2" cols="95" name="pboard_content" placeholder=" comment here" >&nbsp;<%=pboardList.get(i).get("pboard_content").toString() %></textarea>
					                    </p>
					                    <div style="text-align: right; padding-right:5px;">
					                    <button type='button' onclick="commentSubmit(this.form);" class='btn btn-default btn-sm' ><i class='glyphicon glyphicon-scissors'></i> reply</button>
					                    &nbsp;&nbsp;
					                    <button type='button' onclick="cancelComment('<%=Integer.parseInt(pboardList.get(i).get("pboard_num").toString())%>');"
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
										<li><a href="gethotplace.ho?place_num<%=place.getPlace_num()%>&commentPage=<%=commentPage-1%>&page=<%=nowPage%>&keyword=<%=keyword%>">«</a></li>&nbsp;
										<%} %>
										
										<%for(int a=startPage;a<=endPage;a++){
												if(a==commentPage){%>
										<li><a><%=a %></a></li>
										<%}else{ %>
										<li><a href="gethotplace.ho?place_num<%=place.getPlace_num()%>&commentPage=<%=a%>&page=<%=nowPage%>&keyword=<%=keyword%>"><%=a %>
										</a></li>&nbsp;
										<%} %>
										<%} %>
								
										<%if(commentPage>=maxPage){ %>
										<li><a>»</a></li>
										<%}else{ %>
										<li><a href="gethotplace.ho?place_num<%=place.getPlace_num()%>&commentPage=<%=commentPage+1%>&page=<%=nowPage%>&keyword=<%=keyword%>">»</a></li>
										<%} %>
										</ul>
									</div>
								</section>
					       	</div> <!-- 해당글 댓글 들어가는 공간 -->
							</section>
					  	</div>
					    </div>
					    <!-- 블로그리뷰(크롤링) -->
					    <div id="crolling-output" class="tab-pane fade"></div>
					  </div>
				</div>
			<!-- 평가, 블로그 리뷰 -->

            </div>
            <!--all_body_content끝-->
        </section>
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</div><!--wrap끝-->
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
		    values : '0:2:1',
		    labels : ['맛','가격','서비스'],
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
		      values : [<%=tasteAve%>, <%=priceAve%>, <%=serviceAve%>],
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
<!--google map script-->
<script>
      function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 15,
          center: {lat: <%=place.getPlace_maplat()%>, lng: <%=place.getPlace_maplng()%>}
        });

    	var marker2 = new google.maps.Marker({
    		position: {lat: <%=place.getPlace_maplat()%>, lng: <%=place.getPlace_maplng()%>}, 
    		map: map
    	});
    	
    	 var infowindow1 = new google.maps.InfoWindow({
     		content:  '<a class="btn btn-lg btn-danger" target="_blacnk" href="https://www.google.co.kr/maps/dir//<%=place.getPlace_name()%>+<%=place.getPlace_area()%>">'
     	  	+'<i class="glyphicon glyphicon-search pull-left"></i>&nbsp;<span><%=place.getPlace_area()%>&nbsp;<%=place.getPlace_name()%><br/>'
     	  	+'<small>길찾기</small></span></a>',
     	  	maxWidth: 250,
    	 });

    	infowindow1.open(map, marker2);
    	
  	} //initMap() 끝

 </script>
<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAXLWZuztJOAvb2wZpL7ebcXaxHv65paaA&callback=initMap">
</script>
</body>
</html>