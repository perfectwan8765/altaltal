<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>닉네임 중복체크</title>
<script>
function windowclose()
{
	opener.document.joinform.uname.value="${uname}";
	opener.document.joinform.push2.value = 1;
	self.close();
}
</script>
</head>
<body bgcolor="#f5f5f5">
	<c:if test="${check eq 1 }">
	<table width="480" border="0" cellspacing="0" cellpadding="5">
		<tr align="center">
		<td height="30">
			<font size="2">${uname } 는 이미 사용 중인 닉네임입니다.</font>
		</td>
		</tr>
	</table>
	<form action="/user/unameChk" method="get" name="checkForm" >
	<table width="480" border="0" cellspacing="0" cellpadding="5">
		<tr>
		<td align="center">
			<font size="2">다른 닉네임을 선택하세요.</font><p>
			<input type="text" size="20" maxlength="20" name="uname"/>
			<input type="submit" value="중복확인" />
		</td>					
		</tr>
	</table>
	</form>
	</c:if>

	<c:if test="${check ne 1 }">
	<table width="480" border="0" cellspacing="0" cellpadding="5">
		<tr>
			<td align="center">
			<font size="2">입력하신 ${uname } 는 사용할 수 있는 닉네임입니다.</font>
			<br/><br/>
			<input type="button" value="닫기" onclick="windowclose();" />
			</td>
		</tr>
	</table>
	</c:if>
	
</body>
</html>