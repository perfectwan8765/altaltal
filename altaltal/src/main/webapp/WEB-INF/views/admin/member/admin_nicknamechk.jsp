<%@ page contentType="text/html; charset=utf-8" %>
<%
	String nickname=(String)request.getAttribute("nickname");
	int check=((Integer)(request.getAttribute("check"))).intValue();
%>
<html>
<head>
<title>닉네임 중복체크</title>
<script>
function windowclose()
{
	opener.document.infoform.member_nickname.value="<%=nickname %>";
	self.close();
}
</script>
</head>

<body bgcolor="#f5f5f5">
<% if(check == 1){ %>
<table width="480" border="0" cellspacing="0" cellpadding="5">
	<tr align="center">
	<td height="30">
		<font size="2"><%=nickname %> 는 이미 사용 중인 닉네임입니다.</font>
	</td>
	</tr>
</table>
<form action="./MemberNICKNAMECheckAction.me" method="post" name="checkForm" >
<table width="480" border="0" cellspacing="0" cellpadding="5">
	<tr>
	<td align="center">
		<font size="2">다른 닉네임을 선택하세요.</font><p>
		<input type="text" size="20" maxlength="20" name="member_nickname"/>
		<input type="submit" value="중복확인" />
	</td>					
	</tr>
</table>
</form>
<% }else{ %>
<table width="480" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td align="center">
		<font size="2">입력하신 <%=nickname %> 는 사용할 수 있는 닉네임입니다.</font>
		<br/><br/>
		<input type="button" value="닫기" onclick="windowclose()" />
		</td>
	</tr>
</table>
<% } %>
</body>
</html>