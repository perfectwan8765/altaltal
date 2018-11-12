<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.spring.altaltal.member.MemberVO" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
	if(session.getAttribute("email") == null){
		out.print("<script>");
		out.print("alert('로그인을 해주세요.');");
		out.print("location.href='./main.me';");
		out.print("</script>");
	}

   MemberVO vo = (MemberVO)request.getAttribute("vo");
   String nowPage = (String)request.getAttribute("page");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
   <title>admin page</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpoint" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style>
.board_view {
margin-left:13.5em; 
width:65%;
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

.board_view tbody th, .board_view tbody td {
padding:10px 0 10px 10px;
border :1px solid #ccc
}

.board_view tbody th.th_file {
padding:0 0 0 15px;
 vertical-align:middle
}



/*버튼 위치*/


 .view_button {
 padding: 15px 0;
 text-align:center;
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
   text-decoration:none !important;<!-- important:강제로 지정하기 -->
   text-shadow:0px 1px 0px #ffffff;
}
.button:hover {
   background-color:#f6f6f6;
}
.button:active {
   position:relative;
   top:1px;
}
#page-wrapper{
	padding-bottom: 130px;
}
.top_head{
	padding-bottom: 10px;
}
</style>
<script>
//회원수정 양식 체크
function infocheck()
{
   var nickname=infoform.member_nickname.value;
   var password1=infoform.member_password.value;
   var password2=infoform.MEMBER_PASSWORD2.value;
   
   var pattern1 = /[0-9]/;
   var pattern2 = /[a-zA-Z]/;
   var pattern3 = /[~!@#$%^&*]/;
   
   if(nickname.length == 0){
      alert("닉네임을 입력하세요.");
      infoform.member_nickname.focus();
        return false;
   }
   if(password1.length == 0){
      alert("비밀번호를 입력하세요.");
      infoform.member_password.focus();
      return false;
   }
   if(!pattern1.test(password1)||!pattern2.test(password1)||!pattern3.test(password1)||password1.length<8||password1.length>50){
      alert("영문+숫자+특수기호 8자리 이상으로 비밀번호를 구성하세요.");
      infoform.member_password.focus();
      return false;
   }
   if(password1 != password2){
      alert("확인 비밀번호가 일치하지 않습니다.");
      infoform.member_password.value="";
      infoform.MEMBER_PASSWORD2.value="";
      infoform.member_password.focus();
      return false;
   }
   else{
      document.infoform.submit();
   }
   
   return true;
}

//닉네임 중복확인
function openConfirmNICKNAME(infoform){         
   var nickname=infoform.member_nickname.value;
   var url="./AdminNICKNAMECheck.ad?member_nickname="+infoform.member_nickname.value;
   
   if(nickname.length == 0){
      alert("닉네임을 입력하세요.");
      infoform.member_nickname.focus();
      return false;
   }
   open(url, "confirm", "toolbar=no,location=no,status=no,menubar=no,"+
                   "scrollbars=no,resizable=no,width=450,height=300");
}
</script>

<script type="text/javascript">
//프로필 사진 업로드
var sel_file;

$(document).ready(function() {
   $("#inputMypage").on("change", handleImgFileSelect123);
});

function handleImgFileSelect123(e) {
   var files = e.target.files;
   var filesArr = Array.prototype.slice.call(files);
   
   filesArr.forEach(function(f) {
      sel_file = f;
      
      var reader = new FileReader();
      reader.onload = function(e) {
         $("#imageMypage").attr("src", e.target.result);
      }
      reader.readAsDataURL(f);
   });
}
</script>

</head>

<body>
<jsp:include page="../../menubar.jsp" flush="true" ></jsp:include>


<div id="page-wrapper">
<jsp:include page="../admin_sidebar.jsp" flush="true" ></jsp:include>
<!-- 본문 -->
<div id="page-content-wrapper">
<div class="contanier-fluid">

<table class="board_view">

<!-- 개인정보 수정 -->   

<form enctype='multipart/form-data' action="./AdminMemberUpdate.ad" method="post" name="infoform" onsubmit="return infocheck()">
<input type="hidden" name="page" value="<%=nowPage%>" />
<thead>
	<tr><td class="top_head" colspan="2"><h3>회원정보수정</h3></td></tr>
</thead>

  <tbody>
   <tr >
      <th scope="row">
         <font size="2">이메일</font>
      </th>
      <td>
         ${vo.member_email}
         <input type="hidden" name="member_email" value="${vo.member_email}">
      </td>
   </tr>
   <tr>
      <th scope="row">
         <font size="2">비밀번호</font>
      </th>
      <td>
         <input type="password" name="member_password" size="30" placeholder="영문+숫자+특수기호 8자리 이상"/>
      </td>
   </tr>
   <tr>
      <th scope="row" >
         <font size="2">비밀번호 확인</font>
      </th>
      <td>
         <input type="password" name="MEMBER_PASSWORD2" size="30" placeholder="영문+숫자+특수기호 8자리 이상"/>
      </td>
   </tr>
   <tr>
      <th scope="row">
         <font size="2">닉네임</font>
      </th>
      <td>
         <input type="text" name="member_nickname" size="30" value="${vo.member_nickname }" />
         <button type="button" class="button" name="confirm_nickname"  onclick="openConfirmNICKNAME(this.form)" >중복확인</button>
      </td>
   </tr>
   <tr>
      <th scope="row">
         <font size="2">프로필 사진</font>
      </th>
      <td>
         <img id="imageMypage" src="<spring:url value='/image/profile/${vo.member_picture }' />" class="img-rounded" width="140" height="140" />
           <input type='file' id="inputMypage" name="profile_img" accept="image/*">
      </td>
   </tr>
   <tr>
      <th scope="row">
         <font size="2">관심지역</font>
      </th>
      <td>
            <select name="member_area">
                <option value="서울특별시" <%if(vo.getMember_area().equals("서울특별시")){ %> selected <%} %>>서울특별시</option>
                <option value="부산광역시" <%if(vo.getMember_area().equals("부산광역시")){ %> selected <%} %>>부산광역시</option>
                <option value="대구광역시" <%if(vo.getMember_area().equals("대구광역시")){ %> selected <%} %>>대구광역시</option>
                <option value="인천광역시" <%if(vo.getMember_area().equals("인천광역시")){ %> selected <%} %>>인천광역시</option>
                <option value="광주광역시" <%if(vo.getMember_area().equals("광주광역시")){ %> selected <%} %>>광주광역시</option>
                <option value="대전광역시" <%if(vo.getMember_area().equals("대전광역시")){ %> selected <%} %>>대전광역시</option>
                <option value="울산광역시" <%if(vo.getMember_area().equals("울산광역시")){ %> selected <%} %>>울산광역시</option>
                <option value="경기도" <%if(vo.getMember_area().equals("경기도")){ %> selected <%} %>>경기도</option>
                <option value="강원도" <%if(vo.getMember_area().equals("강원도")){ %> selected <%} %>>강원도</option>
                <option value="충청도" <%if(vo.getMember_area().equals("충청도")){ %> selected <%} %>>충청도</option>
                <option value="전라도" <%if(vo.getMember_area().equals("전라도")){ %> selected <%} %>>전라도</option>
                <option value="경상도" <%if(vo.getMember_area().equals("경상도")){ %> selected <%} %>>경상도</option>
                <option value="제주도" <%if(vo.getMember_area().equals("제주도")){ %> selected <%} %>>제주도</option>
            </select>
      </td>
   </tr>
   <tr>
      <th scope="row">
         <font size="2">국가</font>
      </th>
      <td>
         
         <select name="member_country">
                <option value="대한민국(KOR)" <%if(vo.getMember_country().equals("대한민국(KOR)")){ %> selected <%} %> >대한민국(KOR)</option>
                <option value="미국(USA)" <%if(vo.getMember_country().equals("미국(USA)")){ %> selected <%} %> >미국(USA)</option>
                <option value="일본(JAP)" <%if(vo.getMember_country().equals("일본(JAP)")){ %> selected <%} %> >일본(JAP)</option>
            </select>
      </td>
   </tr>
   </tbody>
<tfoot>
<tr>
<td class="view_button" colspan="2">
<button type="submit" class="button">회원정보 수정</button>
<button class="button" onclick="location.href='./AdminMembersList.ad?page=<%=nowPage%>'">목록</button>
</td>
</tr>
</tfoot>
</form>
</table>

<!-- 개인정보 수정 -->
</div>
</div>
</div>
<!-- 본문끝 -->
<jsp:include page="../../footer.jsp" flush="true"></jsp:include>
</body>
</html>