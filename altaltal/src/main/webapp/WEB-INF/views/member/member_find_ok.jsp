<%@ page contentType="text/html; charset=utf-8" %>
<% 
	String email=(String)request.getAttribute("email"); 
%>

<html>
<head>
<script>
function windowclose(){
	self.close();
}
</script>
</head>

<body>
<table width="450px" height="35px">
	<tr><td align="left">
	<b>비밀번호 찾기</b>
	</td></tr>
</table>
	
<table width="440px">
	<thead>새로운 비밀번호가 전송되었습니다.<br/><br/><br/></thead>
	<tr><td align="left">등록된 이메일 : [<%=email %>]로 새로운 비밀번호가 발송되었습니다. 확인해주세요.</td></tr>
</table>

<table width="450px">
	<tr>
		<td align="center">	
			<hr/><br/><input type="button" value="닫기" onclick="windowclose()"/>
		</td>
	</tr>
</table>
</body>
</html>