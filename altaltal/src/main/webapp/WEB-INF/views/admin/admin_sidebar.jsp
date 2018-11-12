<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
 <%
	String email = (String)session.getAttribute("email");
	String nickname = (String)session.getAttribute("nickname");
%>     
  <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    
<style>

#page-wrapper {
   padding-left: 250px;
   position: relative;
   min-height: 680px;
}

/*----------------sidebar-wrapper----------------*/

.sidebar-wrapper {
   position: absolute;
   width: 250px;
   height: 100%;
   margin-left: -250px;
   background: #fafafa;
   overflow-x:hidden;
   overflow-y:hidden;
}

.sidebar-wrapper ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
}

.sidebar-wrapper a {
    text-decoration: none;
}

/*----------------sidebar-content----------------*/

.sidebar-content {
    max-height: calc(100% - 30px);
    height: calc(100% - 30px);
    overflow-y: hidden;
    position: relative;
}

.sidebar-content.desktop {
    overflow-y: hidden;
}

/*--------------------sidebar-brand----------------------*/

.sidebar-wrapper .sidebar-brand {
    padding: 0 20px;
}

.sidebar-wrapper .sidebar-brand>a {
    text-transform: uppercase;
    font-weight: bold;
}

/*--------------------sidebar-header----------------------*/

.sidebar-wrapper .sidebar-header {
    padding: 20px 20px 5px 20px;
    overflow: hidden;
}

.sidebar-wrapper .sidebar-header .user-pic {
    float: left;
    width: 60px;
    padding: 2px;
    border-radius: 8px;
    margin-right: 15px;
}

.sidebar-wrapper .sidebar-header .user-info {
    float: left;
}

.sidebar-wrapper .sidebar-header .user-info>span {
    display: block;
}

.sidebar-wrapper .sidebar-header .user-info .user-role {
    font-size: 12px;
}

.sidebar-wrapper .sidebar-header .user-info .user-status {
    font-size: 11px;
    margin-top: 4px;
}

.sidebar-wrapper .sidebar-header .user-info .user-status i {
    font-size: 8px;
    margin-right: 4px;
    color: #5cb85c;
}




/*----------------------sidebar-menu-------------------------*/

.sidebar-wrapper .sidebar-menu {
    padding-bottom: 10px;
}

.sidebar-title{
    padding: 21px 20px 0px 20px;
    font-size:25px;
 }
 hr{
 width:215px;
 border-bottom:1px solid #b2b2b2;
 }

.sidebar-wrapper .sidebar-menu  span {
    font-weight: bold;
    font-size: 14px;
    padding: 15px 20px 5px 20px;
    display: inline-block;
}

.sidebar-wrapper .sidebar-menu ul li a {
    display: inline-block;
    width: 100%;
    text-decoration: none;
    position: relative;
    margin-bottom:8px;
}

.sidebar-wrapper .sidebar-menu ul li a i {
    margin-right: 10px;
    font-size: 14px;
    width: 30px;
    height: 30px;
    line-height: 30px;
    text-align: center;
    border-radius: 4px;
}


.sidebar-wrapper .sidebar-menu .sidebar-dropdown>a:after {
    content: "\f105";
    font-family: FontAwesome;
    font-weight: 400;
    font-style: normal;
    display: inline-block;
    text-align: center;
    text-decoration: none;
    background: 0 0;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    position: absolute;
    right: 15px;
    top: 13px;
}

.sidebar-wrapper .sidebar-menu .sidebar-dropdown .sidebar-submenu ul {
    padding: 5px 0;
}

.sidebar-wrapper .sidebar-menu .sidebar-dropdown .sidebar-submenu li {
    padding-left: 25px;
    font-size: 13px;
}


.sidebar-wrapper .sidebar-menu .sidebar-dropdown .sidebar-submenu li a:before {
   
    font-family: FontAwesome;
    font-weight: 400;
    font-style: normal;
    display: inline-block;
    text-align: center;
    text-decoration: none;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    margin-right: 10px;
    font-size: 10px;
}


.sidebar-wrapper .sidebar-menu .sidebar-submenu {
    display: none;
}
.sidebar-wrapper .sidebar-menu .sidebar-dropdown .sidebar-submenu li a:hover{
     
   background:  rgba(156, 156, 156, 0.2);
}

.sidebar-wrapper .sidebar-menu .sidebar-dropdown.active>a:after {
    transform: rotate(90deg);
    right: 17px;
}

</style>
 <!-- 사이드바    -->
  <nav id="sidebar" class="sidebar-wrapper">
            <div class="sidebar-content">
               <div  class="sidebar-title">Admin page</div>
               <hr />
                <div class="sidebar-brand">
                    <a href="#">Admin Information</a>
                </div>
                <div class="sidebar-header">
                    <div class="user-pic">
                        <img class="img-responsive img-rounded" src="<spring:url value='/image/profile/${sessionScope.profile }' />" alt="User picture">
                    </div>
                    <div class="user-info">
                        <span class="user-name">
                            <strong><%=nickname %></strong>
                        </span>
                        <span class="user-role">Administrator</span>
                        <span class="user-status">
                            <span><%=email %></span>
                        </span>
                    </div>
                </div>
           <hr/>
             
                <div class="sidebar-menu">
                    <ul>
                      <li>
                           <a href="#">
                           <span>관리자 정보 수정</span></a>
                             </li>
                          <li>
                           <a href="./AdminMembersList.ad">
                           <span>회원목록</span></a>
                             </li>
                        <li class="sidebar-dropdown">
                            <a href="#">
                                <span> 관리 리스트</span>
                             
                            </a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li>
                                        <a href="./adminMakguliList.ad">막걸리 리스트</a>
                                    </li>
                                    <li>
                                        <a href="./adminPlaceList.ad">맛집 리스트</a>
                                    </li>
                                    <li>
                                        <a href="./adminCourseList.ad">여행테마 리스트</a>
                                    </li>
                                  
                                </ul>
                            </div>
                        </li>
                        
                        
                        <li>
                            <a href="./feedbackList.ad">
                                <span>피드백 리스트</span>
                               
                            </a>
                           
                        </li>
                    </ul>
                </div>
                <!-- sidebar-menu  -->
            </div>
       
        </nav>
<!-- 사이드바 끝 -->

<script>
jQuery(function ($) {

    $(".sidebar-dropdown > a").click(function () {
        $(".sidebar-submenu").slideUp(200);
        if ($(this).parent().hasClass("active")) {
            $(".sidebar-dropdown").removeClass("active");
            $(this).parent().removeClass("active");
        } else {
            $(".sidebar-dropdown").removeClass("active");
            $(this).next(".sidebar-submenu").slideDown(200);
            $(this).parent().addClass("active");
        }

    });

 

    if (!/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
        $(".sidebar-content").mCustomScrollbar({
            axis: "y",
            autoHideScrollbar: true,
            scrollInertia: 300
        });
        $(".sidebar-content").addClass("desktop");

    }
});

</script>