<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpoint" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./resources/js/main/menubar.js"></script>
<link rel="stylesheet" href="./resources/css/main/menubar.css" >
</head>
<body>
  <nav class="navbar navbar-default">
    <div class="navbar-align">
    <div class="container-fluid">
      <div class="navbar-header">
       <img src="./resources/image/altaltal1.png" width="45" height="45" /><span id="point">Project altaltal</span>
      </div>
  	<ul class="nav navbar-nav navbar-right">
      <li><a href="./main.me">HOME</a></li>
      <li><a href="#" data-toggle="modal" data-target="#maguli_list">막걸리</a></li>
      <li><a href="#" data-toggle="modal" data-target="#hotplace_list">맛집</a></li>
      <li><a href="#" data-toggle="modal" data-target="#course_list">여행코스</a></li>
      <li><a href="./getMainBoardList.fr">자유게시판</a></li>
      <li><a href="#" onclick="chatCheck(); window.open('./chat_intro.ch','','width=600,height=500');" >채팅</a></li>
      <c:if test="${empty sessionScope.email}">
      	<li><a href="#" data-toggle="modal" data-target="#menubar-login">로그인</a></li>
      	<li><a href="#" data-toggle="modal" data-target="#menubar-join">회원가입</a></li>
      </c:if>
      <c:if test="${not empty sessionScope.email}">
      		<c:if test="${empty sessionScope.admin}">
      			<li><a href="./MypageInfoAction.my">마이페이지</a></li>
      		</c:if>
      		<c:if test="${not empty sessionScope.admin}">
      			<li><a href="./AdminMembersList.ad">관리자페이지</a></li>
      		</c:if>
      		<li><a href="#" onclick="logout();">로그아웃</a></li>
    	</c:if>
    </ul>
    </div>
  </div>
  </nav>
<!-- 막걸리 지역(modal) 선택 -->
  <div class="modal fade bs-example-modal" tabindex="-1" role="diglog" aria-labelledby="exampleModalLabel" aria-hidden="true" id="maguli_list">
        <div class="modal-dialog">
            <div class="modal-content mgmodalcontent">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">막걸리 지역선택</h4>
                </div>
                <div class="modal-body">
                <div class="row">
                	<c:forTokens var="item" items="서울,부산,대구,인천" delims=",">
                    	<div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=${item}';">${item}</button>
                        </div>
                 	</c:forTokens>
                 </div>
                   <div class="row">
                   	<c:forTokens var="item" items="광주,대전,울산,경기" delims=",">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=${item}';">${item}</button>
                        </div>
                 	</c:forTokens>
                    </div>
                    <div class="row">
                   	<c:forTokens var="item" items="강원,충북,충남,전북" delims=",">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=${item}';">${item}</button>
                        </div>
                 	</c:forTokens>
                    </div>
					<div class="row">
                   	<c:forTokens var="item" items="전남,경북,경남,제주" delims=",">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=${item}';">${item}</button>
                        </div>
                 	</c:forTokens>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 막걸리 지역 선택 -->
    
    <!-- 맛집 지역(modal) 선택 -->
  <div class="modal fade bs-example-modal" tabindex="-1" role="diglog" aria-labelledby="exampleModalLabel" aria-hidden="true" id="hotplace_list">
        <div class="modal-dialog">
            <div class="modal-content mgmodalcontent">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">맛집 지역선택</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                    <c:forTokens var="item" items="서울,부산,대구,인천" delims=",">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=${item}';">${item}</button>
                        </div>
                    </c:forTokens>
                    </div>
                    <div class="row">
                    <c:forTokens var="item" items="광주,대전,울산,경기" delims=",">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=${item}';">${item}</button>
                        </div>
                    </c:forTokens>
                    </div>
                    <div class="row">
                    <c:forTokens var="item" items="강원,충북,충남,전북" delims=",">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=${item}';">${item}</button>
                        </div>
                    </c:forTokens>
                    </div>
                    <div class="row">
                    <c:forTokens var="item" items="전남,경북,경남,제주" delims=",">
                    	<div class="col-xs-3">
                        	<button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=${item}';">${item}</button>
                       	</div>
                    </c:forTokens>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 맛집 지역 선택 -->
    
    <!-- 여행 지역(modal) 선택 -->
  <div class="modal fade bs-example-modal" tabindex="-1" role="diglog" aria-labelledby="exampleModalLabel" aria-hidden="true" id="course_list">
        <div class="modal-dialog">
            <div class="modal-content mgmodalcontent">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">여행 지역선택</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                    <c:forTokens var="item" items="서울,부산,대구,인천" delims=",">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='courseList.tr?course_area=${item}';">${item}</button>
                        </div>
                    </c:forTokens>
                    </div>
                    <div class="row">
                    <c:forTokens var="item" items="광주,대전,울산,경기" delims=",">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=${item}';">${item}</button>
                        </div>
                    </c:forTokens>
                    </div>
                    <div class="row">
                    <c:forTokens var="item" items="강원,충북,충남,전북" delims=",">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=${item}';">${item}</button>
                        </div>
                    </c:forTokens>
                    </div>
                    <div class="row">
                    <c:forTokens var="item" items="전남,경북,경남,제주" delims=",">
                    	<div class="col-xs-3">
                        	<button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=${item}';">${item}</button>
                        </div>
                    </c:forTokens>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 여행 지역 선택 -->

<!-- Small modal(로그인) -->
<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true" id="menubar-login">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h3 class="modal-title" id="myModalLabel" align="center">Log into Altaltal</h3>
    <form action="./MemberLoginAction.me" method=post name=loginform onsubmit="return logincheck()">
    <div class="modal-body">
        <div class="form-group">
            <input type="email" class="recipient-name" name="member_email" placeholder="Email Address">
        </div>
        <div class="form-group">
            <input type="password" class="recipient-name" name="member_password" placeholder="Password">
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-default btn-block" id="login-name">로그인</button>
        </div>
        <br><input type="button" class="btn btn-link" value="아이디/비밀번호 찾기" onclick="openConfirmPassword(this.form)">
    </div>
    </form>
    </div>
    </div>
  </div>
</div>

<!-- Large modal(회원가입) -->


<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="menubar-join">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h2 class="modal-title" id="myModalLabel" align="center">Create Account</h2>
    <form class="form-horizontal" name="joinform" id="joinform" enctype='multipart/form-data' action="./MemberJoinAction.me" method="post" onsubmit="return joincheck()">
    <input type='hidden' name='push1' value='0'/>
    <input type='hidden' name='push2' value='0'/>
    <div class="modal-body">
        <div class="form-group">
            <label for="inputEmail" class="col-sm-2 control-label">이메일</label>
        <div class="col-sm-6">
            <input type="email" class="form-control" id="inputEmail" name="member_email">
        </div>
        <div class="col-sm-2">
            <input type="button" class="btn btn-default" name="confirm_email" value="중복확인" onclick="openConfirmEMAIL(this.form)">
        </div>
        </div>
        <div class="form-group">
            <label for="inputPassword1" class="col-sm-2 control-label">비밀번호</label>
        <div class="col-sm-6">
            <input type="password" class="form-control" id="inputPassword1" name="member_password" placeholder="영문+숫자+특수기호 8자리 이상">
        </div>
        </div>
        <div class="form-group">
            <label for="inputPassword2" class="col-sm-2 control-label">비밀번호 확인</label>
        <div class="col-sm-6">
            <input type="password" class="form-control" id="inputPassword2" name="MEMBER_PASSWORD2" placeholder="영문+숫자+특수기호 8자리 이상">
        </div>
        </div>
        <div class="form-group">
            <label for="inputNickname" class="col-sm-2 control-label">닉네임</label>
        <div class="col-sm-6">
            <input type="text" class="form-control" id="inputNickname" name="member_nickname">
        </div>
        <div class="col-sm-2">
            <input type="button" class="btn btn-default" name="confirm_nickname" value="중복확인" onclick="openConfirmNICKNAME(this.form)">
        </div>
        </div>
        <div class="form-group">
            <label for="inputPicture" class="col-sm-2 control-label">프로필 사진</label>
        <div class="col-sm-2">
            <img id="image" src="./resources/image/profile.svg" class="img-rounded" width="140" height="140">
        </div>
        <div class="col-sm-8">
            <br><br><br><br><br><br>
            <input type='file' id="inputPicture" name="profile_img" accept="image/*">
        </div>
        </div>
        <div class="form-group">
            <label for="inputArea" class="col-sm-2 control-label">관심 지역</label>
        <div class="col-sm-4">
            <select class="form-control" name="member_area">
            <c:forTokens var="item" items="서울,부산,대구,인천,광주,대전,울산,경기,강원,충북,충남,전북,전남,경북,경남,제주" delims=",">
                <option value="${item}">${item}</option>
			</c:forTokens>
            </select>
        </div>
        </div>
        <div class="form-group">
            <label for="inputCountry" class="col-sm-2 control-label">국가</label>
        <div class="col-sm-4">
            <select class="form-control" name="member_country">
                <option value="대한민국(KOR)">대한민국(KOR)</option>
                <option value="미국(USA)">미국(USA)</option>
                <option value="일본(JAP)">일본(JAP)</option>
            </select>
        </div>
        </div>
    </div>
    <div class="modal-footer">
        <button type="submit" class="btn btn-default btn-block" id="insert-member">회원가입</button>
    </div>
    </form>
    </div>
    </div>
  </div>
</div>