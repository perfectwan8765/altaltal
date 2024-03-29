<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	if (session.getAttribute("email") == null){
		out.println("<script>");
		out.println("alert('채팅은 회원만 가능합니다.')");
		out.println("self.close();");
		out.println("</script>");
	}
	String name = (String)session.getAttribute("name");
	
%>

<!DOCTYPE html>
<html>
<head>
<title>WebSocket</title>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<style>
	.list-group{
		text-align: center;
	}
	#nameList{
		height: 50%;
		border-style: solid;
		border-color: black;
		text-align: center;	
	}
	.userName{
		font-size: large;
	}
</style>
</head>
<body>
<div class="row">
	<div class="list-group col-md-1">
		<div class="list-group-item">원하는 지역 채팅방을 선택해주세요.</div>
		<a href="./chat_team.ch?region=seoul" class="list-group-item list-group-item-action">서울</a>
		<a href="./chat_team.ch?region=incheon" class="list-group-item list-group-item-action">인천</a>
		<a href="./chat_team.ch?region=gyeonggi" class="list-group-item list-group-item-action">경기도</a>
		<a href="./chat_team.ch?region=daejeon" class="list-group-item list-group-item-action">대전</a>
		<a href="./chat_team.ch?region=chungcheongdo" class="list-group-item list-group-item-action">충청도</a>
		<a href="./chat_team.ch?region=daegu" class="list-group-item list-group-item-action">대구</a>
		<a href="./chat_team.ch?region=busan" class="list-group-item list-group-item-action">부산</a>
		<a href="./chat_team.ch?region=ulsan" class="list-group-item list-group-item-action">울산</a>
		<a href="./chat_team.ch?region=gyeongsangdo" class="list-group-item list-group-item-action">경상도</a>
		<a href="./chat_team.ch?region=gangwon" class="list-group-item list-group-item-action">강원도</a>
		<a href="./chat_team.ch?region=gwangju" class="list-group-item list-group-item-action">광주</a>
		<a href="./chat_team.ch?region=jeonlado" class="list-group-item list-group-item-action">전라도</a>
		<a href="./chat_team.ch?region=jejudo" class="list-group-item list-group-item-action">제주도</a>
	</div>
</div>
</body>
</html>