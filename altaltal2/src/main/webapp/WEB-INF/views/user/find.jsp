<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head>
<!-- Boot Strap -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpoint" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script>

if("${msg}" != ""){
	alert("${msg}");
}

function formSubmit(){
	var email = document.findform.email.value;
	
	if(email.length == 0){
		alert("이메일을 입력하세요.");
		findform.member_email.focus();
        return false;
	}
	
	return true;
}
</script>
</head>
<body>
	<table width="450px" height="20px">
		<tr>
			<td align="left"><b>비밀번호 찾기</b></td>
		</tr>
	</table>

	<br>

	<form action="/user/find" method="post" name="findform" onSubmit="return formSubmit();">
		<table width="450px" cellspacing="0" cellpadding="0" border="0">
		    <tr>
			    <td height="29" bgcolor="#F3F3F3">
				    <font size="2">이메일</font>
			    </td>
			    <td>
			    	&nbsp;
			    	<input type="text" name="email" maxlength="40" size="40">
			    </td>
		    </tr>
		    <tr>
			    <td colspan="2" height="1"></td>
		    </tr>
		    <tr>
			    <td colspan="2" style="padding:10px 0 20px 0" align="center">
				<input type="submit" value="확인">
			</td>
		    </tr>				
		</table>
	</form>	
</body>
</html>