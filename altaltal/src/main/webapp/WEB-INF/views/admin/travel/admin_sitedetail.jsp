<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.spring.altaltal.travel.CourseVO"%>
<%@page import="com.spring.altaltal.travel.SiteVO"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		
		if(session.getAttribute("admin") == null){
			out.print("<script>");
			out.print("alert('관리자만 추가가 가능합니다.')");
			out.print("location.href='./main.me'");
			out.print("</script>");
		}
		
		CourseVO course =(CourseVO)request.getAttribute("CourseVO");
		SiteVO site =(SiteVO)request.getAttribute("SiteVO");
		
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpoint" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="//cdn.ckeditor.com/4.10.0/basic/ckeditor.js"></script>

<title>관리자_여행장소 상세정보</title>
<style type="text/css">
.full_body{
	padding-bottom: 180px;
}
.write_section{
 padding: 10px 10px;
}
#registForm {
   width: 500px;
   height: 610px;
   border: 1px solid red;
   margin: auto;
}

h3 {
   text-align: center;
   padding-top: 10px;
   padding-bottom: 10px;
}

table {
   margin: auto;
   width: 450px;
}

.td_left {
   width: 150px;
   background: orange;
}

.td_right {
   width: 300px;
   background: skyblue;
}
.form-control {
	width : 160px;
}
.board_view {
margin:auto; 
width:50%;
border-top:1px solid #ccc;
   
border-bottom:1px solid #ccc;
margin-bottom: 5px;
}
.board_view tbody th {
text-align:left;
background:#f7f7f7;
color:#3b3a3a
}
.board_view tbody th.list_tit {
font-size:13px;
color:#000;
letter-spacing:0.1px
}
.board_view tbody .no_line_b th, .board_view tbody .no_line_b td {
border-bottom:none
}
.board_view tbody th, .board_view tbody td {
padding:15px 0 16px 16px;
border-bottom:1px solid #ccc
}
.board_view tbody td.view_text {
border-top:1px solid #ccc; 
border-bottom:1px solid #ccc;
padding:18px 15px 18px 15px;
}
.board_view tbody th.th_file {
padding:0 0 0 15px;
 vertical-align:middle
}
 
 .view_button {
 position: absolute;
 right: 25%;
 }
.button{
 
 -moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
   -webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
   box-shadow:inset 0px 1px 0px 0px #ffffff;
   background-color:#ffffff;
   -moz-border-radius:6px;
   -webkit-border-radius:6px;
   border-radius:6px;
   border:1px solid #dcdcdc;
   display:inline-block;
   cursor:pointer;
   color:#666666;
   font-family:Arial;
   font-size:12px;
   font-weight:bold;
   padding:6px 11px;
   text-decoration:none !important;
   text-shadow:0px 1px 0px #ffffff;
 }

.button:hover {
   background-color:#f6f6f6;
}
.button:active {
   position:relative;
   top:1px;
}
</style>
<script>
	function siteDeleteCheck(site_num){
		if(confirm("해당 여행장소를 삭제하시겠습니까?")){
			location.href="./siteDelete.ad?site_num=" + site_num + "&course_num=<%=site.getCourse_num()%>";
		}
	}
</script>
</head>
<body>
<jsp:include page="../../menubar.jsp" flush="true" />

   <!-- 게시판 등록 -->
<div class="full_body">
<jsp:include page="../admin_sidebar.jsp" flush="true" ></jsp:include>
   <table class="board_view">
      <colgroup>
         <col width="15%">
         <col width="*"/>
         </colgroup>
         <caption><h3>여행장소 상세정보</h3></caption>
         <tbody>
         <tr>
             <th scope="row">코스명</th>
             <td><%=course.getCourse_name() %></td>
         </tr>
         <tr>
             <th scope="row">코스순서</th>
             <td><%=site.getSite_order() %></td>
         </tr>
         <tr>
            <th scope="row">장소명</th>
            <td><%=site.getSite_name() %></td>
         </tr>
         <tr>
            <th scope="row">위도</th>
            <td><%=site.getSite_maplat() %></td>
         </tr>
         <tr>
            <th scope="row">경도</th>
            <td><%=site.getSite_maplng() %></td>
         </tr>
         <tr>
            <th scope="row">소개</th>
            <td><textarea cols='80' rows='10' ><%=site.getSite_content() %></textarea></td>
         </tr>
         <tr>
            <th scope="row">사진파일</th>
            <td><img src="<spring:url value='/image/site/${SiteVO.site_picture }' />" /></td>
         </tr>
         </tbody>
   </table>
   <br/>
       <div class="view_button">
       <button type="button" class="button" onclick="location.href='adminCourse.ad?course_num=<%=site.getCourse_num()%>'">해당 여행코스</button>
       &nbsp;&nbsp;
       <button type="button" class="button" onclick="location.href='siteUpdateForm.ad?site_num=<%=site.getSite_num() %>&course_name=<%=course.getCourse_name() %>'">수정</button>
       &nbsp;&nbsp;
       <button type="button" class="button" onclick="onclick="siteDeleteCheck('<%=site.getSite_num() %>');">삭제</button>
        </div>
   </form>
  </div>
<jsp:include page="../../footer.jsp" flush="true" />
</body>
</html>