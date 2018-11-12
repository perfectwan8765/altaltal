<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spring.altaltal.travel.CourseVO"%>
<%@ page import="com.spring.altaltal.travel.SiteVO"%>
<%@ page import="com.spring.altaltal.freeboard.PageInfo"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	ArrayList<CourseVO> courseList = (ArrayList<CourseVO>) request.getAttribute("courseList");
	ArrayList<SiteVO> siteList = ( ArrayList<SiteVO>)request.getAttribute("siteList");
	String course_area =(String)request.getAttribute("course_area");

	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
	
	double latSum = 0;
	double lngSum = 0;

	for(int i=0; i<siteList.size(); i++){
		latSum += siteList.get(i).getSite_maplat();
		lngSum +=siteList.get(i).getSite_maplng();
	}
	
	double latAvg = latSum/siteList.size();
	double lngAvg = lngSum/siteList.size();
%>
<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpoint" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
<title>여행리스트</title>

<style>
        .all_body_content {
            padding-bottom: 110px;
            margin-bottom: 10px;
            min-height: 700px;
        }

        .topsubmenu {
            background-attachment: fixed;
            margin: 13px 13px;
        }
        .area_subject{
        	margin-left: 20px;
        }

        .mglist {
            border: none;
            border-left: none;
            border-right: none;
            border-bottom: none;
            /*padding-left: 15px;*/	
        }
        .mgimg {
            border-radius: 6px;
            margin-right: -10px;
            border:none;
            padding:0 !important;
        }
   
	    .mgexp{
	        line-height: 200%;
	        margin-left: -50px;
	    }
        .subrow {
            border: none;
            /* height: 100%;*/
            border-top: 1px solid #ccc;
            margin-left: 10px;
        }
        .listrow {
            border: 1px solid #ccc;
            border-radius: 6px;
            height: 140px;
            margin:15px -25px 0 5px !important;
            width: 98%;
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

        .map-travelList {
            border: none;
            right: 20px;
            width: 95%;
            height: 480px;
            margin-right: 10px;
        }
        .img-travel{
        width: 238px; 
        height: 140px;
        border-radius: 10px;
        }
        .div_pagenation{
        	border : none;
        	text-align: center;
        }
     .modal-header-primary {
     text-align: center;
    color:#fff;
    padding:9px 15px;
    border-bottom:1px solid #eee;
    background-color: #d0d0d0;
    -webkit-border-top-left-radius: 5px;
    -webkit-border-top-right-radius: 5px;
    -moz-border-radius-topleft: 5px;
    -moz-border-radius-topright: 5px;
     border-top-left-radius: 5px;
     border-top-right-radius: 5px;
}
.modal-content-wrapper{
 border: none;
}

/* 모달창 안 */
.modal-content-wrapper .mg-posts .posts {
  flex: 1;
  overflow: hidden;
  background: white; 
  width: 570px;
  height: 140px;
  -moz-box-shadow: 0 0 2px 0 rgba(0, 0, 0, 0.2);
  -webkit-box-shadow: 0 0 2px 0 rgba(0, 0, 0, 0.2);
  box-shadow: 0 0 2px 0 rgba(0, 0, 0, 0.2);
  margin-right: 1em;
  margin-bottom: 1em;
  border-top-left-radius: 5px;
  border-bottom-left-radius: 5px;
}
.modal-content-wrapper .mg-posts .posts .img-wrapper, .modal-content-wrapper .mg-posts .posts .contents {
  display: inline-block;
  position: relative;
  -moz-transition: all 500ms ease;
  -o-transition: all 500ms ease;
  -webkit-transition: all 500ms ease;
  transition: all 500ms ease;
}
.modal-content-wrapper .mg-posts .posts .img-wrapper {
  float: left;
  width: 238px;
  height: 140px;
  background-size: cover;
  background-position: center center;
  border-top-left-radius: 5px;
  border-bottom-left-radius: 5px;
}
.modal-content-wrapper .mg-posts .posts .img-wrapper .mgindex {
  background: rgba(255, 255, 255, 0.5);
  width: 50px;
  text-align: center;
  padding: 0.5em 0;
  color: #444;
}
.modal-content-wrapper .mg-posts .posts .img-wrapper .mgindex .mgnum {
  font-weight: bolder;
}
.modal-content-wrapper .mg-posts .posts .contents {
  padding: 0.5em 1em;
   width: 58%;
   -moz-box-shadow: -2px 0 2px -1px rgba(0, 0, 0, 0.1);
  -webkit-box-shadow: -2px 0 2px -1px rgba(0, 0, 0, 0.1);
  box-shadow: -2px 0 2px -1px rgba(0, 0, 0, 0.1);
  height: 140px;
}
.modal-content-wrapper .mg-posts .posts .contents p {
  font-weight: 300;
  font-size: 1.4rem;
  line-height: 1.5;
  margin-bottom: 0.5em;
  font-family: 'Merriweather', sans-serif;
}

.modal-content-wrapper .mg-posts .posts .contents:before {
  content: '';
  position:absolute;
  background: white;
  width: 15px;
  height: 15px;
  top: 33%;
  left: -8px;
  -moz-transform: rotate(45deg);
  -ms-transform: rotate(45deg);
  -webkit-transform: rotate(45deg);
  transform: rotate(45deg);
  -moz-box-shadow: -1px 0 2px -1px rgba(0, 0, 0, 0.1);
  -webkit-box-shadow: -1px 0 2px -1px rgba(0, 0, 0, 0.1);
  box-shadow: -1px 0 2px -1px rgba(0, 0, 0, 0.1);
} 

.box-column{
	width: 250px;
	height: 200px;
}
.box-top{
    border-radius:10px;
}
.box-bottom{
    background:#FFF;
    border-radius:10px;
}
.title{
    font-size:20px;
    font-weight:600;
    text-transform: uppercase;
    color:#428bca;
}

</style>
<script>
$(document).ready(function(){
<%
 	for(int i=0; i<courseList.size(); i++){
		if(i == courseList.size()-1){ continue;}
%>	
		$("#map<%=courseList.get(i).getCourse_num()%>").css("display", "none");
<%
 	}
	for(int i=0; i<courseList.size(); i++){
%>
	$("#mapchange-<%=courseList.get(i).getCourse_num()%>").mouseover(function(){
		$(".listrow").css("cursor", "pointer");
		$("#map<%=courseList.get(i).getCourse_num()%>").css("display", "block");
		<%for(int j=0; j<courseList.size(); j++){
			if(courseList.get(i).getCourse_num() == courseList.get(j).getCourse_num()){ continue;}
		%>
		$("#map<%=courseList.get(j).getCourse_num()%>").css("display", "none");	
		<%}%>
	}).mouseout(function(){
		$(".listrow").css("cursor", "default");
	});
<%
 	}
%>	
});
</script>
</head>
<body>
<jsp:include page="../menubar.jsp" flush="true" />
<div class="container-fluid all_body_content">

        <div class="row subrow">
        <div class="area_subject">
        <h1> <blockquote><strong><%=course_area %>지역 여행코스</strong></blockquote></h1>
        </div> 
            <div class="col-md-8 mglist">
<%
            for(int i=0; i<courseList.size(); i++){
%>
                <div id="mapchange-<%=courseList.get(i).getCourse_num()%>" class="row listrow" data-toggle='modal' data-target='#<%=courseList.get(i).getCourse_num()%>' >
                    <div class="col-xs-4 mgimg" >
                        <img class="img-travel" src="/altaltal/image/course/<%=courseList.get(i).getCourse_picture() %>" class="img_size" />
                    </div>
                    <div class="col-xs-8 mgexp">
   
                        <h3><%=courseList.get(i).getCourse_name() %></h3>
                        <i class="fas fa-map-marked-alt"></i>&nbsp;&nbsp;
<%
			for(int j=0; j<siteList.size(); j++){
				if(siteList.get(j).getCourse_num() == courseList.get(i).getCourse_num()){
					
%>
					<%=siteList.get(j).getSite_order() %>. <%=siteList.get(j).getSite_name() %>&nbsp;
<%					
				}
			}
%>
                        <br>
                        <i class="fas fa-binoculars"></i>&nbsp;&nbsp;<%=courseList.get(i).getCourse_content() %>
                    </div>
                </div>
                
                <!-- modal -->
                <div class="modal fade" id="<%=courseList.get(i).getCourse_num()%>" tabindex="-1" role="dialog" 
                aria-labelledby="<%=courseList.get(i).getCourse_num()%>title" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
   					 <div class="modal-content">
   					 
	   					 <div class="modal-header modal-header-primary">
	        				<h3 class="modal-title" id="<%=courseList.get(i).getCourse_num()%>title" ><%=courseList.get(i).getCourse_name()%></h3>
	      				</div> <!--  modal-header 끝 -->
	      				
	      				<div class="modal-body">
<%
			for(int j=0; j<siteList.size(); j++){
				if(siteList.get(j).getCourse_num() == courseList.get(i).getCourse_num()){
					
%>
					<div class="modal-content-wrapper">
		               <div class="mg-posts">
		               <div class="posts featured">
		                  
		                  <div class="img-wrapper" style='background-image:url(/altaltal/image/site/<%=siteList.get(j).getSite_picture() %>)'>
		                   <div class="mgindex">
		                      <div class="mgnum">0<%=siteList.get(j).getSite_order() %></div>
		                      
		                     </div>
		                  </div>
		                  <div class="contents">
		                  <h5><strong>&nbsp;<%=siteList.get(j).getSite_name() %></strong></h5>
		                  <p>&nbsp;<%=siteList.get(j).getSite_content() %></p>
		                  </div>
      
               		 	</div> <!-- posts featured -->
               			</div> <!-- mg-posts -->
               		</div> <!-- modal-content-wrapper -->
               		<%if(j == siteList.size()-1 || siteList.size() == 1){ break; }%>
               		<hr/>
<%					
				}
			}
%>
	      				</div>	<!--  modal-body 끝 -->
	      				
	      				<div class="modal-footer">
        					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      					</div> <!--  modal-footer 끝 -->
   					 
   						 </div> <!-- modal-content 끝 -->
   					 </div> <!-- modal-dialog 끝 -->
                </div>
                
                
<%
            }
%>

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
                        	<a href="getHotplaceList.ho?page=<%=nowPage-1 %>" aria-label="Previous">
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
                                <a class="page-link" href="getHotplaceList.ho?page=<%=a %>" ><%=a %></a>
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
                                <a href="getHotplaceList.ho?page=<%=nowPage+1 %>" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                          <%} %>
                    </ul>
                    </div>
                </div> <!-- pagination -->
           </div>
			<br/>
            <div class="col-md-4">
<%
     	for(int i=0; i<courseList.size(); i++){
%>	
             	<div id="map<%=courseList.get(i).getCourse_num()%>" class="map-travelList"></div>
<%
     	}
%>
            </div>

        </div>
    </div>
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
<script>  
      function initMap() {
    	var markers = new Array();
		var pre_infors = new Array();
    	var inforWindows = new Array();
<%
     	for(int i=0; i<courseList.size(); i++){
       	double latSite = 0;
       	double lngSite = 0;
       	int check =0;
       	
				for(int j=0; j<siteList.size(); j++){
					if(courseList.get(i).getCourse_num() == siteList.get(j).getCourse_num()){
						latSite += siteList.get(j).getSite_maplat();
						lngSite += siteList.get(j).getSite_maplng();
						check++;
					}
				}
	        	latSite = latSite/check;
	        	lngSite = lngSite/check;
%>	     
        var map<%=courseList.get(i).getCourse_num()%> = new google.maps.Map(document.getElementById('map<%=courseList.get(i).getCourse_num()%>'), {
	          zoom: 14,
	          center: {lat: <%=latSite%>, lng: <%=lngSite%>}
		});
<%
     	}
%>

<%
     	for(int i=0; i<siteList.size(); i++){
%>	
			markers[<%=i%>] = new google.maps.Marker({
		   	 	position: new google.maps.LatLng(<%=siteList.get(i).getSite_maplat() %>, <%=siteList.get(i).getSite_maplng() %>),
		   	 	label : '<%=siteList.get(i).getSite_name() %>',
		   		title : '<%=siteList.get(i).getSite_name() %>',
		   		icon: './resources/image/marker1.png',
		   		map: map<%=siteList.get(i).getCourse_num() %>
			});
			
			 
			
        
			inforWindows[<%=i%>] = new google.maps.InfoWindow({
					content: '<div class="box-column text-center"><div class="box-top">'
              				+ '<img style="margin-bottom:10px;" src="/altaltal/image/site/<%=siteList.get(i).getSite_picture()  %>" width="240" height="150" /></div>'
							+ '<div class="box-bottom"><div class="title">'
			    			+ '<span><%=siteList.get(i).getSite_name()  %></span></div><div class="text">'
							+ '</div><a target="_blank" style="margin-top:10px;" class="btn btn-danger btn-circle" href="https://www.google.co.kr/maps/dir//<%=siteList.get(i).getSite_name()%>+<%=course_area%>">길찾기</a></div></div>'
			});
     		  
			pre_infors[<%=i%>] = true;
			
			markers[<%=i%>].addListener('click', function(){
				if(pre_infors[<%=i%>]){
					inforWindows[<%=i%>].open(map<%=siteList.get(i).getCourse_num()%>, this); 
					pre_infors[<%=i%>] = false;
				}else{
					inforWindows[<%=i%>].close(map<%=siteList.get(i).getCourse_num()%>, this); 
					pre_infors[<%=i%>] = true;
				}
			});

     		 <%
     	}
     		 %>
     		 
	<%
         	for(int i=0; i<courseList.size(); i++){
    %>	
     	google.maps.event.addListener(map<%=courseList.get(i).getCourse_num()%>, 'tilesloaded', function () {
            document.getElementById('map<%=courseList.get(i).getCourse_num()%>').style.position = 'absolute';
    });
     <%
         	}
    %>
     		 
    } /* initMap() */	
    </script>
    
<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAXLWZuztJOAvb2wZpL7ebcXaxHv65paaA&callback=initMap"></script>
</body>
</html>