<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpoint" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script>
//로그인 양식 체크
function logincheck()
{
	var email=loginform.member_email.value;
	var password=loginform.member_password.value;

	if(email.length == 0){
		alert("이메일를 입력하세요.");
		loginform.member_email.focus();
		return false;
	}
	if(password.length == 0){
		alert("비밀번호를 입력하세요.");
		loginform.member_password.focus();
		return false;
	}
	
	return true;
}

//회원가입 양식 체크
function joincheck()
{
	var email=joinform.member_email.value;
	var nickname=joinform.member_nickname.value;
	var password1=joinform.member_password.value;
	var password2=joinform.MEMBER_PASSWORD2.value;
	
	var pattern1 = /[0-9]/;
	var pattern2 = /[a-zA-Z]/;
	var pattern3 = /[~!@#$%^&*]/;
	
	if(email.length == 0){
		alert("이메일을 입력하세요.");
		joinform.member_email.focus();
		return false;
	}
	if(nickname.length == 0){
		alert("닉네임을 입력하세요.");
		joinform.member_nickname.focus();
        return false;
	}
	if(password1.length == 0){
		alert("비밀번호를 입력하세요.");
		joinform.member_password.focus();
		return false;
	}
	if(!pattern1.test(password1)||!pattern2.test(password1)||!pattern3.test(password1)||password1.length<8||password1.length>50){
		alert("영문+숫자+특수기호 8자리 이상으로 비밀번호를 구성하세요.");
		joinform.member_password.focus();
		return false;
	}
	if(password1 != password2){
		alert("확인 비밀번호가 일치하지 않습니다.");
		joinform.member_password.value="";
		joinform.MEMBER_PASSWORD2.value="";
		joinform.member_password.focus();
		return false;
	}
	if(document.joinform.push1.value == 0){
		alert('이메일 중복체크를 해주세요');
		joinform.member_email.focus();
		return false;
	}
	if(document.joinform.push2.value == 0){
		alert('닉네임 중복체크를 해주세요');
		joinform.member_nickname.focus();
		return false;
	}
	else{
		document.joinform.submit();
	}
	
	return true;
}

//비밀번호 찾기
function openConfirmPassword(loginform)
{	
	var url="./MemberFind.me";
	open(url, "confirm", "toolbar=no,location=no,status=no,menubar=no,"+
						 "scrollbars=no,resizable=no,width=450px,height=300");
}

//이메일 중복확인
function openConfirmEMAIL(joinform){			
	var email=joinform.member_email.value;
	var url="./MemberEMAILCheckAction.me?member_email="+joinform.member_email.value;
	
	if(email.length == 0){
		alert("이메일을 입력하세요.");
		joinform.member_email.focus();
		return false;
	}
	open(url, "confirm", "toolbar=no,location=no,status=no,menubar=no,"+
						 "scrollbars=no,resizable=no,width=450,height=300");
}

//닉네임 중복확인
function openConfirmNICKNAME(joinform){			
	var nickname=joinform.member_nickname.value;
	var url="./MemberNICKNAMECheckAction.me?member_nickname="+joinform.member_nickname.value;
	
	if(nickname.length == 0){
		alert("닉네임을 입력하세요.");
		joinform.member_nickname.focus();
		return false;
	}
	open(url, "confirm", "toolbar=no,location=no,status=no,menubar=no,"+
						 "scrollbars=no,resizable=no,width=450,height=300");
}

// 채팅창 오픈
function chatCheck(){
	if('<%=session.getAttribute("email") %>' == null){
		alert("로그인을 해주세요.");
		return false;
	}
	return true;
}
</script>

<script type="text/javascript">
//프로필 사진 업로드
var sel_file;

$(document).ready(function() {
   $("#inputPicture").on("change",handleImgFileSelect);
});

function handleImgFileSelect(e) {
   var files = e.target.files;
   var filesArr = Array.prototype.slice.call(files);
   
   filesArr.forEach(function(f) {
      sel_file = f;
      
      var reader = new FileReader();
      reader.onload = function(e) {
         $("#image").attr("src", e.target.result);
      }
      reader.readAsDataURL(f);
   });
}

function logout(){
	if(window.confirm('로그아웃 하시겠습니까?')){
		location.href="./memberLogout.me";
	}
}
</script>
  <style>

    /*내비게이션 바*/
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
      height: 100px;
      background-color: white;
    }

    .navbar-align {
      margin : 20px 0 0 20px;
    }

    /* Add a gray background color and some padding to the footer */


    .dorpdown {display: block;
    }

    .dropdown-content {
	display: none;
	position: absolute;
	background-color: #f9f9f9;
	min-width: 150px;
	box-shadow: 8px 8px 5px rgba(0, 0, 0, 0.2);
	z-index:1;
	}

	.dropdown-content a {
		color: black;
		padding: 12px 16px;
		text-decoration: none;
		display: block;
		text-align: left;
		}

	.dropdown-content a:hover {
		background-color: #f1f1f1;
		}

	.dropdown:hover .dropdown-content {
		display: block;
		}

	.avatar {
   border-radius: 100%;
   display:inline-block;
   padding:0.5rem;
   background-color: rgba(0,0,0,0,0.1);
   border : 1px solid rgba(0,0,0,0,0.25);
   margin-bottom: 1.5rem;
		}
	.avatar img {
   border-radius: 100%;
   display:block;
  		}

/*메인사진 크기조절
  #myCarousel {
    width: 1519.5px;
    height: 300px;
    margin: auto;
  }

#container-black {
  margin-left: 0px;
  margin-right: 0px;
  color: grey;
}
*/

#point {
  color: black;
}

  body {
    background-repeat: no-repeat;
    background-size: cover;
    background-attachment: fixed;
    margin: 0;
    padding: 0;
  }


      div.white {
        background-color: white;
        width: 100%;
      }

      div.top {
        height: 150px;
      }

      div.contents {
        height: 600px;
      }

      div.hole {
        width: 100%;
        height: 400px;
      }
      
      .recipient-name {
         width: 100%;
         padding: 10px 20px;
         box-sizing: border-box;
         border: none;
         border-bottom: 1px solid #CCC;
      }
      
      #login-name {
         width: 100%;
         padding: 12px 20px;
         margin: 3px 0;
         background-color: #E6E6E6;
      }
      #insert-member{
         width: 100%;
         padding: 12px 20px;
         margin: 3px 0;
         background-color: #E6E6E6;
      }
      .btn-link{
      color: black;
      }
      .navbar-header{
      	margin-top : 10px !important;
      }
      .navbar-nav{
      	margin-top : 5px !important;
      }
      #point{
      	font-size: 20px;
      }
      .navbar-brand{
      	float: right;
      }
      
       /*modal 버튼*/
       .mgmodalcontent{
        height:280px;
    	}
 	   .mgcity{
        width: 120px;
        height: 40px;
        margin-bottom:10px;
   		}
      
  </style>
  
  <nav class="navbar navbar-default">
    <div class="navbar-align">
    <div class="container-fluid">
      <div class="navbar-header">
       <img src="./resources/image/altaltal1.png" width="45" height="45" /><a class="navbar-brand" href="./intro_yes.in"><span id="point">Project altaltal</span></a>
      </div>
  <ul class="nav navbar-nav navbar-right">
      <li><a href="./main.me">HOME</a></li>
      <li><a href="#" data-toggle="modal" data-target="#maguli_list">막걸리</a></li>
      <li><a href="#" data-toggle="modal" data-target="#hotplace_list">맛집</a></li>
      <li><a href="#" data-toggle="modal" data-target="#course_list">여행코스</a></li>
      <li><a href="./getMainBoardList.fr">자유게시판</a></li>
      <li><a href="#" onclick="chatCheck(); window.open('./chat_intro.ch','','width=600,height=500');" >채팅</a></li>
      <%if(session.getAttribute("email") == null){ %>
      <li><a href="#" data-toggle="modal" data-target="#menubar-login">로그인</a></li>
      <li><a href="#" data-toggle="modal" data-target="#menubar-join">회원가입</a></li>
      <%}else{ 
      			if(session.getAttribute("admin") == null){
      %>
     			 <li><a href="./MypageInfoAction.my">마이페이지</a></li>
			      <%}else{ %>
			     <li><a href="./AdminMembersList.ad">관리자페이지</a></li>
			      <%} %>
      <li><a href="#" onclick="logout();">로그아웃</a></li>
      <%} %>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=서울';">서울</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=부산';">부산</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=대구';">대구</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=인천';">인천</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=광주';">광주</button>
                            </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=대전';">대전</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=울산';">울산</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=경기';">경기</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=강원';">강원</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=충북';">충북</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=충남';">충남</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=전북';">전북</button>
                        </div>
                    </div>
                    <div>
                        <div class="row">
                            <div class="col-xs-3">
                                <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=전남';">전남</button>
                            </div>
                            <div class="col-xs-3">
                                <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=경북';">경북</button>
                            </div>
                            <div class="col-xs-3">
                                <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=경남';">경남</button>
                            </div>
                            <div class="col-xs-3">
                                <button type="button" class="btn btn-default mgcity" onclick="location.href='getMakguliList.ma?makguli_area=제주';">제주</button>
                            </div>
                        </div>
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
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=서울';">서울</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=부산';">부산</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=대구';">대구</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=인천';">인천</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=광주';">광주</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=대전';">대전</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=울산';">울산</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=경기';">경기</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=강원';">강원</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=충북';">충북</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=충남';">충남</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=전북';">전북</button>
                        </div>
                    </div>
                    <div>
                        <div class="row">
                            <div class="col-xs-3">
                                <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=전남';">전남</button>
                            </div>
                            <div class="col-xs-3">
                                <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=경북';">경북</button>
                            </div>
                            <div class="col-xs-3">
                                <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=경남';">경남</button>
                            </div>
                            <div class="col-xs-3">
                                <button type="button" class="btn btn-default mgcity" onclick="location.href='getHotplaceList.ho?place_area=제주';">제주</button>
                            </div>
                        </div>
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
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='courseList.tr?course_area=서울';">서울</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='courseList.tr?course_area=부산';">부산</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='courseList.tr?course_area=대구';">대구</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href='courseList.tr?course_area=인천';">인천</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=광주';">광주</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=대전';">대전</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=울산';">울산</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=경기';">경기</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=강원';">강원</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=충북';">충북</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=충남';">충남</button>
                        </div>
                        <div class="col-xs-3">
                            <button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=전북';">전북</button>
                        </div>
                    </div>
                    <div>
                        <div class="row">
                            <div class="col-xs-3">
                                <button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=전남';">전남</button>
                            </div>
                            <div class="col-xs-3">
                                <button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=경북';">경북</button>
                            </div>
                            <div class="col-xs-3">
                                <button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=경남';">경남</button>
                            </div>
                            <div class="col-xs-3">
                                <button type="button" class="btn btn-default mgcity" onclick="location.href=courseList.tr?course_area=제주';">제주</button>
                            </div>
                        </div>
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
    <form class="form-horizontal" name="joinform" id="joinform" action="./MemberJoinAction.me" method="post" onsubmit="return joincheck()">
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