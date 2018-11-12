<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
	request.setCharacterEncoding("utf-8");
	if (session.getAttribute("email") == null){
		out.println("<script>");
		out.println("location.href='loginForm.do'");
		out.println("</script>");
	}
	String name = (String)session.getAttribute("name");
	String userName = (String)request.getAttribute("userName");
	
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
	var log = function(s){
		var m = s.split("/");
		alert(m[0]);
		alert(m[1]);
		alert(m[2]);
		alert(m.length);
		if(m[0] === 'message'){
			document.getElementById("output").textContent += (m[1]+ "\n");
		}else if(m[0] === 'nameList'){
			document.getElementById("nameList").textContent= "";
			for(var i=1; i<m.length; i++){
				if(i == m.length-1){ continue;}
				document.getElementById("nameList").innerHTML += ("<a href='#' onclick='oneChat(\"" + m[i] +"\")'>" + m[i]+ "</a><br/>");
			}
		}else if(m[0] === 'remove'){
			document.getElementById("nameList").textContent= "";
			for(var i=1; i<m.length; i++){
				if(i== m.length-1){ continue;}
				document.getElementById("nameList").textContent += (m[i]+ "\n"); 
			}
			
		}
	}
	
	
	w = new WebSocket("ws://localhost:8800/altaltal/chat/broadcasting?userName=<%=userName%>");
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
				w.send("<%=name%>>" + input);
				document.getElementById("input").value = "";
			}
	}
	
	function oneChat(userName){
		window.open("client_chat.do", "oneChat");
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
</style>
</head>
<body>
<div class="row">
	<div class="col-md-5">
	<input type='text' id='input' placeholder='input message...' size='55' />
	<button id='send_button'>SEND</button>
	<textarea id='output' readonly rows='25' cols='80'></textarea>
	</div>
	<div class="col-md-2">
	대화명 : <%=name%> | 상대방 : <%=userName %>
	<div id='nameList'></div>
	</div>
	<div class="col-md-4"></div>
</div>
</body>
</html>