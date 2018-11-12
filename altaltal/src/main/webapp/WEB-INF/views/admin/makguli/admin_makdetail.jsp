<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.spring.altaltal.makguli.MakguliVO"%>
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
		
		MakguliVO vo = (MakguliVO)request.getAttribute("makguli");

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

<title>관리자_막걸리 상세정보</title>
<style type="text/css">
#page-wrapper{
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
   width: 350px;
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
width:60%;
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
 right: 17%;
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
	function deleteCheck(){
		if(confirm("해당 막걸리정보를 삭제하시겠습니까?")){
			location.href="./makguliDelete.ad?makguli_num=<%=vo.getMakguli_num()%>";
		}
		
	}

</script>
</head>
<body>
<jsp:include page="../../menubar.jsp" flush="true" />
   <!-- 게시판 등록 -->

<div id="page-wrapper">
<jsp:include page="../admin_sidebar.jsp" flush="true" ></jsp:include>
   <table class="board_view">
  
      <colgroup>
         <col width="15%" />
         <col width="30%" />
         <col width="15%" />
         <col width="30%" />
         </colgroup>
         <caption><h3>막걸리 상세정보</h3></caption>
         <tbody>
         <tr>
             <th scope="row">지역</th>
             <td colspan='3' ><%=vo.getMakguli_area() %></td>
         </tr>
         <tr>
         	<th scope="row">제품명</th>
            <td colspan='3' ><%=vo.getMakguli_name()%></td>
          </tr>
         <tr>
            <th scope="row">제조사</th>
            <td><%=vo.getMakguli_make()%></td>
            <th scope="row">제조사url</th>
            <td><%=vo.getMakguli_make_url()%></td>
         </tr>
         <tr>
            <th scope="row">재료</th>
            <td><%=vo.getMakguli_ingre()%></td>
            <th scope="row">도수</th>
            <td><%=vo.getMakguli_degree() %>%</td>
         </tr>
         <tr>
            <th scope="row">좋아요</th>
            <td><%=vo.getMakguli_likecount()%></td>
            <th scope="row">조회수</th>
            <td><%=vo.getMakguli_readcount() %></td>
         </tr>
         <tr>
         <tr>
            <th scope="row">소개</th>
            <td colspan='3' ><textarea cols='80' rows='10' ><%=vo.getMakguli_content() %></textarea></td>
         </tr>
         <tr>
            <th scope="row">사진파일</th>
            <td colspan='3' ><img src="<spring:url value='/image/makguli/${makguli.makguli_picture }'/>" width='200' height='300'  /></td>
         </tr>
         </tbody>
   </table>
   <br/>
       <div class="view_button">
       <button type="button" class="button" onclick="location.href='adminMakguliList.ad'">목록</button>
          &nbsp;&nbsp;
       <button type="button" class="button" onclick="location.href='makguliupdateForm.ad?makguli_num=<%=vo.getMakguli_num()%>'">수정</button>
          &nbsp;&nbsp;
       <button type="button" class="button" onclick="deleteCheck();">삭제</button>
        </div>
  </div>
<jsp:include page="../../footer.jsp" flush="true" />
</body>
</html>