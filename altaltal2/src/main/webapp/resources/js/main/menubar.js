function logincheck()
{
	var email = document.loginform.email.value;
	var password = document.loginform.upw.value;

	if(email.length == 0){
		alert("이메일를 입력하세요.");
		document.loginform.email.focus();
		return false;
	}
	if(password.length == 0){
		alert("비밀번호를 입력하세요.");
		document.loginform.upw.focus();
		return false;
	}
	
	return true;
}

/*비밀번호 찾기*/
function openConfirmPassword(loginform)
{	
	var url="/user/find";
	open(url, "confirm", "toolbar=no,location=no,status=no,menubar=no,"+
						 "scrollbars=no,resizable=no,width=450px,height=300");
}

/*회원가입 양식 체크*/
function joincheck()
{
	var email = document.joinform.email.value;
	var nickname = document.joinform.uname.value;
	var password1 = document.joinform.upw.value;
	var password2 = document.joinform.upw2.value;
	
	var pattern1 = /[0-9]/;
	var pattern2 = /[a-zA-Z]/;
	var pattern3 = /[~!@#$%^&*]/;
	
	if(email.length == 0){
		alert("이메일을 입력하세요.");
		document.joinform.email.focus();
		return false;
	}
	if(nickname.length == 0){
		alert("닉네임을 입력하세요.");
		document.joinform.uname.focus();
        return false;
	}
	if(password1.length == 0){
		alert("비밀번호를 입력하세요.");
		document.joinform.upw.focus();
		return false;
	}
	if(!pattern1.test(password1)||!pattern2.test(password1)||!pattern3.test(password1)||password1.length<8||password1.length>50){
		alert("영문+숫자+특수기호 8자리 이상으로 비밀번호를 구성하세요.");
		document.joinform.upw.focus();
		return false;
	}
	if(password1 != password2){
		alert("확인 비밀번호가 일치하지 않습니다.");
		document.joinform.upw.value="";
		document.joinform.upw2.value="";
		document.joinform.upw.focus();
		return false;
	}
	if(document.joinform.push1.value == 0){
		alert('이메일 중복체크를 해주세요');
		document.joinform.email.focus();
		return false;
	}
	if(document.joinform.push2.value == 0){
		alert('닉네임 중복체크를 해주세요');
		document.joinform.uname.focus();
		return false;
	}
	else{
		document.joinform.submit();
	}
	
	return true;
}

/*이메일 중복확인*/
function openConfirmEMAIL(joinform){			
	var email = document.joinform.email.value;
	var url="/user/emailChk?email="+ email;
	
	if(email.length == 0){
		alert("이메일을 입력하세요.");
		document.joinform.email2.focus();
		return false;
	}
	open(url, "confirm", "toolbar=no,location=no,status=no,menubar=no,"+
						 "scrollbars=no,resizable=no,width=450,height=300");
}

/*닉네임 중복확인*/
function openConfirmNICKNAME(joinform){			
	var uname = document.joinform.uname.value;
	var url="/user/unameChk?uname="+uname;
	
	if(uname.length == 0){
		alert("닉네임을 입력하세요.");
		document.joinform.uname.focus();
		return false;
	}
	open(url, "confirm", "toolbar=no,location=no,status=no,menubar=no,"+
						 "scrollbars=no,resizable=no,width=450,height=300");
}

/*채팅창 오픈*/
function chatCheck(){
	if('${user}' == null){
		alert("로그인을 해주세요.");
		return false;
	}
	return true;
}

/*프로필 사진 업로드*/
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
		location.href="/user/logout";
	}
}
