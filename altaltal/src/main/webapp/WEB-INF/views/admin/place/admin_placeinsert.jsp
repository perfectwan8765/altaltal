<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		
		if(session.getAttribute("admin") == null){
			out.print("<script>");
			out.print("alert('관리자만 추가가 가능합니다.')");
			out.print("location.href='./main.me'");
			out.print("</script>");
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
<script src="//cdn.ckeditor.com/4.10.0/basic/ckeditor.js"></script>

<title>Project Altaltal</title>
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
table tr td input[type="file"]{
	display:inline;
} 

</style>
<script>
var sel_file2;

$(document).ready(function() {
   $(".place-image").on("change", handleImgFileSelect2);
});

function handleImgFileSelect2(e) {
   var files = e.target.files;
   var filesArr = Array.prototype.slice.call(files);
   var image_id = e.target.id;
    filesArr.forEach(function(f) {
      sel_file2 = f;
      
      var reader = new FileReader();
      reader.onload = function(e) {
         $("#"+image_id+"_read").attr("src", e.target.result);
      }
      reader.readAsDataURL(f);
   }); 
}
</script>
</head>
<body>
<jsp:include page="../../menubar.jsp" flush="true" />
   <!-- 게시판 등록 -->

<div id="page-wrapper">
<jsp:include page="../admin_sidebar.jsp" flush="true" ></jsp:include>
          <form action="./adminPlaceInsert.ad" method="post" name="boardform" enctype='multipart/form-data' >
   <table class="board_view">
  
      <colgroup>
         <col width="15%">
         <col width="85%"/>
         </colgroup>
         <caption><h3>맛집 추가</h3></caption>
         <tbody>
         <tr>
             <th scope="row">지역</th>
             <td> <select class="form-control" name="place_area" >
			                <option value="서울">서울</option>
			                <option value="부산">부산</option>
			                <option value="대구">대구</option>
			                <option value="인천">인천</option>
			                <option value="광주">광주</option>
			                <option value="대전">대전</option>
			                <option value="울산">울산</option>
			                <option value="경기">경기</option>
			                <option value="강원">강원</option>
			                <option value="충북">충북</option>
			                <option value="충남">충남</option>
			                <option value="전북">전북</option>
			                <option value="전남">전남</option>
			                <option value="경북">경북</option>
			                <option value="경남">경남</option>
			                <option value="제주">제주</option>
                      </select>
            </td>
         </tr>
         <tr>
            <th scope="row">맛집명</th>
            <td><input type="text" id="place_name" name="place_name" /></td>
         </tr>
         <tr>
            <th scope="row">주소</th>
            <td><input type="text" id="place_juso" name="place_juso" size='60' placeholder=' 시, 도 다음부분부터 작성해주세요.' /></td>
         </tr>
         <tr>
            <th scope="row">대표메뉴</th>
            <td><input type="text" id="place_menu" name="place_menu" size='60' placeholder=' 여러가지인 경우 /로 구분해주세요.' /></td>
         </tr>
         <tr>
            <th scope="row">전화번호</th>
            <td><input type="text" id="place_phone" name="place_phone" size='60' placeholder=" -도 붙여주세요." /></td>
         </tr>
        <tr>
             <th scope="row">평균가격대</th>
             <td> <select class="form-control" name="place_price" >
			                <option value="9choen">1만원 이하</option>
			                <option value="1man">1만원 ~ 2만원</option>
			                <option value="2man">2만원 ~ 3만원</option>
			                <option value="3man">3만원 ~ 4만원</option>
			                <option value="4man">4만원 ~ 5만원</option>
			                <option value="5man">5만원 이상</option>
                      </select>
            </td>
         </tr>
         <tr>
            <th scope="row">블로그url</th>
            <td><input type="text" id="place_url" name="place_url" size='60' placeholder=' 네이버블로그 크롤링 주소를 입력해주세요.' /></td>
         </tr>
         <tr>
            <th scope="row">위도</th>
            <td><input type="text" id="place_maplat" name="place_maplat" size='60' placeholder=' ex) 41.40338' /></td>
         </tr>
         <tr>
            <th scope="row">경도</th>
            <td><input type="text" id="place_maplng" name="place_maplng" size='60' placeholder=' ex) 41.40338' /></td>
         </tr>
         <tr>
         <tr>
            <th scope="row">소개</th>
            <td><textarea id="place_content" name="place_content" cols='80' rows='10' placeholder="맛집 소개,,," ></textarea></td>
         </tr>
         <tr>
            <th rowspan='6' scope="row">사진파일</th>
            <td><img id="place_mainimg_read" src="./resources/image/noimage.gif" width="100" height="100" >&nbsp;&nbsp; 
            메인 사진 : <input type="file" class="place-image" id="place_mainimg" name="place_mainimg" /></td>
         </tr>
           <tr>
            <td><img id="place_subimg1_read" src="./resources/image/noimage.gif" width="100" height="100" >&nbsp;&nbsp;
            서브 사진1 : <input type="file" class="place-image"id="place_subimg1" name="place_subimg1" /></td>
         </tr>
           <tr>
            <td><img id="place_subimg2_read" src="./resources/image/noimage.gif" width="100" height="100" >&nbsp;&nbsp;
            서브 사진2 : <input type="file" class="place-image"id="place_subimg2" name="place_subimg2" /></td>
         </tr>
         <tr>
            <td><img id="place_subimg3_read" src="./resources/image/noimage.gif" width="100" height="100" >&nbsp;&nbsp;
            서브 사진3: <input type="file" class="place-image" id="place_subimg3" name="place_subimg3" /></td>
         </tr>
           <tr>
            <td><img id="place_subimg4_read" src="./resources/image/noimage.gif" width="100" height="100" >&nbsp;&nbsp;
            서브 사진4 : <input type="file" class="place-image" id="place_subimg4" name="place_subimg4" /></td>
         </tr>
         <tr>
            <td><img id="place_subimg5_read" src="./resources/image/noimage.gif" width="100" height="100" >&nbsp;&nbsp;
            서브 사진5 : <input type="file" class="place-image" id="place_subimg5" name="place_subimg5" /></td>
         </tr>
         </tbody>
   </table>
   <br/>
       <div class="view_button">
       <button type="submit" class="button" >작성</button>&nbsp;&nbsp;
       <button type="button" class="button" onclick="location.href='adminPlaceList.ad'">목록</button>
        </div>
   </form>
  </div>
<jsp:include page="../../footer.jsp" flush="true" />
</body>
</html>