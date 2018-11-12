<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
	request.setCharacterEncoding("utf-8");
	if (session.getAttribute("email") == null){
		out.println("<script>");
		out.println("self.close();");
		out.println("</script>");
	}
	String nickname = (String)session.getAttribute("nickname");
	String region = (String)request.getAttribute("region");
	
%>

<!DOCTYPE html>
<html>
<head>
<title>WebSocket</title>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script>
$(document).ready(function(){
	window.resizeTo(1500, 850);
});
	var log = function(s){
		var m = s.split("/");
		alert(m[0]);
		alert(m[1]);
		alert(m[2]);
		alert(m.length);
		if(m[0] === 'message'){
			if(m[1] === '<%=nickname%>'){
				document.getElementById("output_my").textContent += (m[2]+ "\n");
			}else{
				document.getElementById("output_other").textContent += (m[2]+ "\n");
			}
		}else if(m[0] === 'nameList'){
			document.getElementById("nameList").textContent= "";
			for(var i=1; i<m.length; i++){
				if(i == m.length-1){ continue;}
				document.getElementById("nameList").textContent += (m[i] + "\n");
			}
		}else if(m[0] === 'remove'){
			document.getElementById("nameList").textContent= "";
			for(var i=1; i<m.length; i++){
				if(i== m.length-1){ continue;}
				document.getElementById("nameList").textContent += (m[i]+ "\n"); 
			}
			
		}
	}
	
	
	w = new WebSocket("ws://localhost:8800/altaltal/broadcasting?region=<%=region%>");
	w.onopen = function(){
		alert('WebSocket Connected!!!');
	}
	w.onmessage = function(e){
		log(e.data.toString());
	}
	w.onclose = function(e){
		log("WebSocket Closed");
	}
	w.onerror = function(e){
		log("WebSocket error!!!");
	}

	window.onload = function(){
		document.getElementById("send_button").onclick = function(){
				var input = document.getElementById("input").value;
				w.send("<%=nickname%>/" + input);
				document.getElementById("input").value = "";
			}
	}
	
	function oneChat(userName){
		var url = "client_chat_onechat.do?userName=" + userName;
		window.open(url, "oneChat");
	}
</script>
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
	#output_other{
		text-align: left;
	}
	#output_my{
		text-align:light;
	}
</style>
</head>
<body>
<div class="row">
	<div class="list-group col-md-1">
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
	<div class="col-md-6">
	<div>채팅방 지역명 : <%=region %></div>
	<input type='text' id='input' placeholder='input message...' size='55' />
	<button id='send_button'>SEND</button>
	<textarea id='output_other' readonly rows='24' cols='40'></textarea>
	<textarea id='output_my' readonly rows='24' cols='40'></textarea>
	</div>
	<div class="col-md-2">
	대화명 : <%=nickname%>
	<div id='nameList'></div>
	</div>
</div>
</body>
</html>