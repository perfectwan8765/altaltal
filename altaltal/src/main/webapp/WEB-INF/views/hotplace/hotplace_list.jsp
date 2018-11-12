<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.altaltal.hotplace.HotplaceVO"%>
<%@ page import="com.spring.altaltal.freeboard.PageInfo"%>
   <%
	ArrayList<HotplaceVO> placeList = (ArrayList<HotplaceVO>) request.getAttribute("placeList");
	double latSum = 0;
	double lngSum = 0;

	for(int i=0; i<placeList.size(); i++){
		latSum += placeList.get(i).getPlace_maplat();
		lngSum +=placeList.get(i).getPlace_maplng();
	}
	
	double latAvg = latSum/placeList.size();
	double lngAvg = lngSum/placeList.size();
	
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
	
	String area = (String)request.getAttribute("place_area");
	String keyword = (String)request.getAttribute("keyword");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpoint" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<title>Document</title>
<style>
		body {
            min-height: 100%;
        }
        .all_body_content {
            padding-bottom: 130px;
            margin-bottom: 10px;
            height: 750px;
            border : none;
        }
        .place-value{
        	margin-bottom: 15px;
        	border: none;
        }
         .index-place {
           margin-top : 20px;
           border: none;
           height: 78%;
        }
        
        .topsubmenu {
            background-attachment: fixed;
            margin: 16px 16px;
        }

        .mglist {
            border: none;
            border-left: none;
            border-right: none;
            border-bottom: none;
            padding: 0px 24px 0px 24px !important;
            height: 100%;
        }

        .subrow {
           border-top:1px solid #ccc;
            border-left:none;
            border-right:none;
            border-bottom:none;
            height: 100%;
            position: relative;
        }

        .listrow {
            border: 1px solid #ecebef;
            border-radius: 6px;
        }

        .listrow:hover {
            box-shadow: 2px 2px 2px 1px #ccc;
        }

        .button {
            -moz-box-shadow: inset 0px 1px 0px 0px #ffffff;
            -webkit-box-shadow: inset 0px 1px 0px 0px #ffffff;
            box-shadow: inset 0px 1px 0px 0px #ffffff;
            background-color: #ffffff;
            -moz-border-radius: 6px;
            -webkit-border-radius: 6px;
            border-radius: 6px;
            border: 1px solid #dcdcdc;
            display: inline-block;
            cursor: pointer;
            color: #666666;
            font-family: Arial;
            font-size: 12px;
            font-weight: bold;
            padding: 12px 15px;
            text-decoration: none !important;
            text-shadow: 0px 1px 0px #ffffff;
        }

        .button:hover {
            background-color: #f6f6f6;
        }

        .button:active {
            position: relative;
            top: 1px;
        }
 		#map {
            border: none;
            right: 20px;
            width: 95%;
            height: 480px;
            margin-right: 10px;
            margin-top: 50px;
        }
        .div_pagenation{
        	border : none;
        	text-align: center;
        }
		.post-module {
		  position: relative;
		  z-index: 1;
		  display: block;
		  background: #FFFFFF;
		  min-width: 230px;
		  height: 230px;
		  -webkit-box-shadow: 0px 1px 2px 0px rgba(0, 0, 0, 0.15);
		  -moz-box-shadow: 0px 1px 2px 0px rgba(0, 0, 0, 0.15);
		  box-shadow: 0px 1px 2px 0px rgba(0, 0, 0, 0.15);
		  -webkit-transition: all 0.3s linear 0s;
		  -moz-transition: all 0.3s linear 0s;
		  -ms-transition: all 0.3s linear 0s;
		  -o-transition: all 0.3s linear 0s;
		  transition: all 0.3s linear 0s;
		}
.post-module:hover,
.hover {
  -webkit-box-shadow: 0px 1px 35px 0px rgba(0, 0, 0, 0.3);
  -moz-box-shadow: 0px 1px 35px 0px rgba(0, 0, 0, 0.3);
  box-shadow: 0px 1px 35px 0px rgba(0, 0, 0, 0.3);
}
.post-module:hover .thumbnail img,
.hover .thumbnail img {
  -webkit-transform: scale(1.1);
  -moz-transform: scale(1.1);
  transform: scale(1.1);
  opacity: .6;
}
.post-module .thumbnail {
  background: #000000;
  height: 230px;
  overflow: hidden;padding: 0;
}
.post-module .thumbnail .date {
  position: absolute;
  top: 20px;
  right: 20px;
  z-index: 1;
  background: #f2b202;
  width: 55px;
  height: 55px;
  padding: 12.5px 0;
  -webkit-border-radius: 100%;
  -moz-border-radius: 100%;
  border-radius: 100%;
  color: #FFFFFF;
  font-weight: 700;
  text-align: center;
  -webkti-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}
.post-module .thumbnail .date .day {
 font-size: 18px;
    line-height: 31px;
    color: #fff;
}
.post-module .thumbnail .date .month {
  font-size: 12px;
  text-transform: uppercase;
}
.post-module .thumbnail img {
  display: block;
  width: 120%;
  -webkit-transition: all 0.3s linear 0s;
  -moz-transition: all 0.3s linear 0s;
  -ms-transition: all 0.3s linear 0s;
  -o-transition: all 0.3s linear 0s;
  transition: all 0.3s linear 0s;
}
.post-module .post-content {
  position: absolute;
  bottom: 0;
  background: #FFFFFF;
  width: 100%;
    padding: 0 30px 0 0;
  -webkti-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  -webkit-transition: all 0.3s cubic-bezier(0.37, 0.75, 0.61, 1.05) 0s;
  -moz-transition: all 0.3s cubic-bezier(0.37, 0.75, 0.61, 1.05) 0s;
  -ms-transition: all 0.3s cubic-bezier(0.37, 0.75, 0.61, 1.05) 0s;
  -o-transition: all 0.3s cubic-bezier(0.37, 0.75, 0.61, 1.05) 0s;
  transition: all 0.3s cubic-bezier(0.37, 0.75, 0.61, 1.05) 0s;
}
.post-module .post-content .category {
  position: absolute;
  top: -20px;
  left: 0;
  background: #b5b5b5;
  padding: 10px 10px;
  color: #FFFFFF;
  font-size: 14px;
  font-weight: 600;
  text-transform: uppercase;
  border-radius: 5px;
}
.post-module .post-content .title {
  margin: 0;
  padding: 0 0 10px;
  color: #222 !important;
  font-size: 24px !important;
  font-weight: 700;    margin: 20px 0 0 !important;
}
.post-module .post-content .sub_title {
  margin: 0;
  padding: 0 0 20px;
  color: #f2b202;
  font-size: 20px;
  font-weight: 400;
  text-align: right;
}
.post-module .post-content .description {
  display: none;
  color: #666666;
  font-size: 14px;
  line-height: 1.8em;
}
.post-module .post-content .post-meta {
  margin: 0px 0px 10px;
  color: #999999;
}
.post-module .post-content .post-meta .timestamp {
  margin: 0 16px 0 0;
}
.post-module .post-content .post-meta a {
  color: #999999;
  text-decoration: none;
}
.hover .post-content .description {
  display: block !important;
  height: auto !important;
  opacity: 1 !important;
}

.container .column {
     width: 100%;
    /* padding: 0 25px; */
    -webkti-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    float: left;
}
.container .column .demo-title {
  margin: 0 0 15px;
  color: #666666;
  font-size: 18px;
  font-weight: bold;
  text-transform: uppercase;
}
.container .info {
  width: 300px;
  margin: 50px auto;
  text-align: center;
}
.container .info h1 {
  margin: 0 0 15px;
  padding: 0;
  font-size: 20px;
  font-weight: bold;
  color: #333333;
}
.container .info span {
  color: #666666;
  font-size: 10px;
}
.container .info span a {
  color: #000000;
  text-decoration: none;
}
.container .info span .fa {
  color: #f2b202;
}
.main-content{
	text-align: right;
}
</style>
<script>
$(document).ready(function(){
	$(".column").mouseover(function(){
		$(".place-value").css("cursor", "pointer");
	}).mouseout(function(){
		$(".place-value").css("cursor", "default");
	});
});
</script>
</head>

<body>
    <jsp:include page="../menubar.jsp" flush="true" />
        <div class="topsubmenu">
            <button type="button" class="button" onclick="location.href='getHotplaceList.ho?place_area=<%=area %>&keyword=read';" >조회수</button>
            <button type="button" class="button" onclick="location.href='getHotplaceList.ho?place_area=<%=area %>&keyword=like';" >좋아요</button>
            <button type="button" class="button" onclick="location.href='getHotplaceList.ho?place_area=<%=area %>&keyword=abc';" >가나다순</button>
        </div>

<div class="container-fluid all_body_content">
        <div class="row subrow">
       
            <div class="col-md-7 mglist">
                <h1> <blockquote><strong><%=area %>지역 맛집</strong></blockquote></h1>
                <div class="row index-place">
                
 <%
               for(int i=0; i<placeList.size(); i++){
            	   String[] hotplaces = placeList.get(i).getPlace_picture().split("/");
            	   
 %>
	  <div class="col-md-4 place-value" onclick="location.href='gethotplace.ho?place_num=<%=placeList.get(i).getPlace_num() %>&page=<%=nowPage %>&keyword=<%=keyword %>';" >
        <div class="column"> 
          <!-- Post-->
          <div class="post-module"> 
            <!-- Thumbnail-->
            <div class="thumbnail">
              <img src="/altaltal/image/place/<%=hotplaces[0] %>" class="img-responsive" alt=""> 
            </div>
            <!-- Post Content-->
            <div class="post-content">
              <div class="category">
              <span class="glyphicon glyphicon-heart"></span>&nbsp;&nbsp;<%=placeList.get(i).getPlace_likecount() %>&nbsp;&nbsp;
              <span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;<%=placeList.get(i).getPlace_readcount() %>
              </div>
              	<div class="main-content">
	              <h1 class="title"><%=placeList.get(i).getPlace_name() %></h1>
	              <div class="post-meta"><%=placeList.get(i).getPlace_juso() %></div>
	           	</div>
            </div><!-- Post Content-->
          </div><!-- Post-->
        </div>  
      </div>
      
  <%
               }
  %>              
            </div>
            <div class="row div_pagenation">
                <div class="col-xs-12">
                    <ul class="pagination">
                        
                        <%if(nowPage<=1){ %>
                        <li class="page-item">
                            <a aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                            </li>
                        <%}else{ %>
                        <li class="page-item">
                        	<a href="getHotplaceList.ho?place_area=<%=area %>&page=<%=nowPage-1 %>&keyword=<%=keyword %>" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                            </li>
                        <%} %>
                        <%for(int a=startPage;a<=endPage;a++){
							if(a==nowPage){%>
                            <li class="page-item">
                                <a class="page-link" ><%=a %></a>
                            </li>
                        <%}else{ %>
                            <li class="page-item">
                                <a class="page-link" href="getHotplaceList.ho?place_area=<%=area %>&page=<%=a %>&keyword=<%=keyword %>" ><%=a %></a>
                            </li>
                           		<%} %>
						<%} %>
						
						<%if(nowPage>=maxPage){ %>
                            <li class="page-item">
                                <a aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                         <%}else{ %>
                            <li class="page-item">
                                <a href="getHotplaceList.ho?place_area=<%=area %>&page=<%=nowPage+1 %>&keyword=<%=keyword %>" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                          <%} %>
                    </ul>
                    </div>
                </div> <!-- pagination -->
            </div>
            
            <br/>
            <div class="col-md-5">
                <div id="map"></div>
            </div>

        </div>
       </div>
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
<script>  
      function initMap() {
    	var markers = new Array();
		var pre_infors = new Array();
    	var inforWindows = new Array();
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 12,
          center: {lat: <%=latAvg%>, lng: <%=lngAvg%>}
        });

<%
     	for(int i=0; i<placeList.size(); i++){
     		String[] pictures = placeList.get(i).getPlace_picture().split("/");
     		
%>	
			markers[<%=i%>] = new google.maps.Marker({
		   	 	position: new google.maps.LatLng(<%=placeList.get(i).getPlace_maplat() %>, <%=placeList.get(i).getPlace_maplng() %>),
		   	 	label : '<%=placeList.get(i).getPlace_name() %>',
		   		title : '<%=placeList.get(i).getPlace_name() %>',
		   		icon: './resources/image/marker1.png',
		   		map: map
			});
			
			inforWindows[<%=i%>] = new google.maps.InfoWindow({
					content: '<div id="<%=placeList.get(i).getPlace_name() %>" class="carousel slide" data-ride="carousel"><ol class="carousel-indicators">'
					+ '<li data-target="#<%=placeList.get(i).getPlace_name() %>" data-slide-to="0" class="active"></li> <li data-target="#myCarousel" data-slide-to="1"></li>'
					+ '<li data-target="#<%=placeList.get(i).getPlace_name() %>" data-slide-to="2"></li></ol><div class="carousel-inner">'
					+ '<div class="item active"><img src="/altaltal/image/place/<%=pictures[1]%>" width="200" height="200" /></div>'
					+ '<div class="item"><img src="/altaltal/image/place/<%=pictures[2]%>" width="200" height="200" /></div>'
					+ '<div class="item"><img src="/altaltal/image/place/<%=pictures[3]%>" width="200" height="200" /></div></div>'
					+ '<a class="left carousel-control" href="#<%=placeList.get(i).getPlace_name() %>" data-slide="prev">'
					+ '<span class="glyphicon glyphicon-chevron-left"></span><span class="sr-only">Previous</span></a>'
					+ '<a class="right carousel-control" href="#<%=placeList.get(i).getPlace_name() %>" data-slide="next">'
					+ '<span class="glyphicon glyphicon-chevron-right"></span><span class="sr-only">Next</span></a></div>'
			});
     		  
			pre_infors[<%=i%>] = true;
			
			markers[<%=i%>].addListener('click', function(){
				if(pre_infors[<%=i%>]){
					inforWindows[<%=i%>].open(map, this); 
					pre_infors[<%=i%>] = false;
				}else{
					inforWindows[<%=i%>].close(map, this); 
					pre_infors[<%=i%>] = true;
				}
			});
			
     		 <%
     	}
     		 %>

		        
		 google.maps.event.addListener(map, 'tilesloaded', function () {
	                document.getElementById('map').style.position = 'absolute';
	     });
      }

    </script>
<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
</script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAXLWZuztJOAvb2wZpL7ebcXaxHv65paaA&callback=initMap">
</script>
</body>
</html>