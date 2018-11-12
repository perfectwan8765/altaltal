<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
	request.setCharacterEncoding("utf-8");
	if (session.getAttribute("email") == null){
		out.println("<script>");
		out.println("alert('채팅은 회원만 가능합니다.')");
		out.println("self.close();");
		out.println("</script>");
	}
	String nickname = (String)session.getAttribute("nickname");
	String region = (String)request.getAttribute("region");
	
%>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->


<html>
<head>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet" />
<style>
.container{max-width:95%; margin:auto;}
img{ max-width:100%;}
.inbox_chatList {
  background: #f8f8f8 none repeat scroll 0 0;
  float: left;
  overflow: hidden;
  width: 30%; border-right:1px solid #c4c4c4;
}
.inbox_nameList{
  background: #f8f8f8 none repeat scroll 0 0;
  float: left;
  overflow: hidden;
  width: 20%; border-right:1px solid #c4c4c4;
}
.inbox_msg {
  border: 1px solid #c4c4c4;
  clear: both;
  overflow: hidden;
}
.top_spac{ margin: 20px 0 0;}


.recent_heading {float: left; width:100%;}
.headind_srch{ padding:10px 29px 10px 20px; overflow:hidden; border-bottom:1px solid #c4c4c4;}

.recent_heading span {
  color: #05728f;
  font-size: 21px;
  margin: auto;
  font-weight: 700;
}
.region_name{
	color: gray;
	float: right;
	font-size: 12px;
	font-weight: 500;
}
.recent_heading h4 {
  color: #05728f;
  font-size: 21px;
  margin: auto;
}

.chat_ib h5{ font-size:15px; color:#464646; margin:0 0 8px 0;}
.chat_ib h5 span{ font-size:13px; float:right;}
.chat_ib p{ font-size:14px; color:#989898; margin:auto}
.chat_img {
  float: left;
  width: 11%;
}
.chat_ib {
  float: left;
  padding: 0 0 0 15px;
  width: 88%;
}

.chat_people{ overflow:hidden; clear:both;}
.chat_list {
  border-bottom: 1px solid #c4c4c4;
  margin: 0;
  padding: 18px 16px 10px;
}
.name_list {
  border-bottom: 1px solid #c4c4c4;
  margin: 0;
  padding: 18px 16px 10px;
}
.inbox_chat { height: 550px; overflow-y: scroll;}

.active_chat{ background:#ebebeb;}

.incoming_msg_img {
  display: inline-block;
  width: 6%;
}
.received_msg {
  display: inline-block;
  padding: 0 0 0 10px;
  vertical-align: top;
  width: 92%;
 }
 .received_withd_msg p {
  background: #ebebeb none repeat scroll 0 0;
  border-radius: 3px;
  color: #646464;
  font-size: 14px;
  margin: 0;
  padding: 5px 10px 5px 12px;
  width: 100%;
}
.time_date {
  color: #747474;
  display: block;
  font-size: 12px;
  margin: 8px 0 0;
}
.received_withd_msg { width: 57%;}
.mesgs {
  float: left;
  padding: 30px 15px 0 25px;
  width: 50%;
}

 .sent_msg p {
  background: #05728f none repeat scroll 0 0;
  border-radius: 3px;
  font-size: 14px;
  margin: 0; color:#fff;
  padding: 5px 10px 5px 12px;
  width:100%;
}
.outgoing_msg{ overflow:hidden; margin:26px 0 26px;}
.sent_msg {
  float: right;
  width: 46%;
}
.input_msg_write input {
  background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
  border: medium none;
  color: #4c4c4c;
  font-size: 15px;
  min-height: 48px;
  width: 100%;
}

.type_msg {border-top: 1px solid #c4c4c4;position: relative;}
.msg_send_btn {
  background: #05728f none repeat scroll 0 0;
  border: medium none;
  border-radius: 50%;
  color: #fff;
  cursor: pointer;
  font-size: 17px;
  height: 33px;
  position: absolute;
  right: 0;
  top: 11px;
  width: 33px;
}
.messaging { padding: 0 0 50px 0;}
.msg_history {
  height: 516px;
  overflow-y: auto;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	window.resizeTo(1400, 730);
	
	$('.chat_list').mouseover(function(){
		this.style.cursor = 'pointer';
		this.style.backgroundColor = '#ebebeb';
	}).mouseout(function(){
		this.style.backgroundColor = '#f8f8f8';
	}).click(function(){
		var tagId = $(this).attr('id');
		location.href="./chat_team.ch?region="+tagId;
	});
	
});

	var log = function(s){
		var d = new Date();
		d.getHours()
		d.getMinutes()
		var m = s.split("/");
		var msg="";
		if(m[0] === 'message'){
			if(m[1] === '<%=nickname%>' ){
				msg += '<div class="outgoing_msg"><div class="sent_msg"><p>';
				msg += m[2];
				msg += '</p><span class="time_date">';
				msg += d.getHours() + ':' + d.getMinutes();
				msg += ' | ' + (d.getMonth() + 1) + '월 ' + d.getDate() + '일</span></div></div></div>'
				$('#messageList').append(msg);
			}else{
				msg += '<div class="incoming_msg"><div class="received_msg"> <div class="received_withd_msg"><p>';
				msg += m[2];
				msg += '</p><span class="time_date">';
				msg += d.getHours() + ':' + d.getMinutes();
				msg += ' | ' + (d.getMonth() + 1) + '월 ' + d.getDate() + '일</span></div></div></div>'
				$('#messageList').append(msg);
			}
		}else if(m[0] === 'nameList'){
			$("#nameList").empty();
			
			for(var i=1; i<m.length; i++){
				var inhtml = "";
				if(i == m.length-1){ continue;}
				inhtml += '<div class="name_list"><div class="chat_people"><div class="chat_img">';
				inhtml += '<img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>';
				inhtml += '<div class="chat_ib"><h5>';
				inhtml += m[i];
				inhtml += '<span class="chat_date">나</span></h5></div></div></div>';
				$("#nameList").append(inhtml);
			}
		}else if(m[0] === 'remove'){
			$("#nameList").empty();
			for(var i=1; i<m.length; i++){
				var inhtml = "";
				if(i == m.length-1){ continue;}
				inhtml += '<div class="name_list"><div class="chat_people"><div class="chat_img">';
				inhtml += '<img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>';
				inhtml += '<div class="chat_ib"><h5>';
				inhtml += m[i];
				inhtml += '<span class="chat_date">';
				inhtml += '</span></h5></div></div></div>';
				$("#nameList").append(inhtml); 
			}
		}
	} //log()함수 정의 끝

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
				if(input == null || input == ""){
					return false;
				}
				w.send("<%=nickname%>/" + input);
				document.getElementById("input").value = "";
			}
	}
</script>
</head>
<body>
<div class="container">
	<h3 class=" text-center">Live Chat</h3>
<div class="messaging">
	<div class="inbox_msg">
	<!--  리스트 시작 -->
        <div class="inbox_chatList">
        
        <div class="headind_srch">
	        <div class="recent_heading">
	              <span>Local Chat List</span><span class="region_name">region : <%=region %></span>
	        </div>
        </div>
        
        <div class="inbox_chat">
        
        <div class="chat_list" id="seoul">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Seoul_Chat <span class="chat_date">서울</span></h5>
                  <p>서울지역 채팅방입니다</p>
                </div>
              </div>
         </div>
         
         <div class="chat_list" id="busan">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Busan_Chat <span class="chat_date">부산</span></h5>
                  <p>부산지역 채팅방입니다</p>
                </div>
              </div>
         </div>
         
         <div class="chat_list" id="daegu">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Daegu_Chat <span class="chat_date">대구</span></h5>
                  <p>대구지역 채팅방입니다</p>
                </div>
              </div>
         </div>
         
         <div class="chat_list" id="daejeon">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Dejeon_Chat <span class="chat_date">대전</span></h5>
                  <p>대전지역 채팅방입니다</p>
                </div>
              </div>
         </div>
         
         <div class="chat_list" id="incheon">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Incheon_Chat <span class="chat_date">인천</span></h5>
                  <p>인천지역 채팅방입니다</p>
                </div>
              </div>
         </div>
         
         <div class="chat_list" id="gwangju">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Gwangju_Chat <span class="chat_date">광주</span></h5>
                  <p>광주지역 채팅방입니다</p>
                </div>
              </div>
         </div>
         
         <div class="chat_list" id="ulsan">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Ulsan_Chat <span class="chat_date">울산</span></h5>
                  <p>울산지역 채팅방입니다</p>
                </div>
              </div>
         </div>
         
         <div class="chat_list" id="gyeonggi">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Gyeonggi_Chat <span class="chat_date">경기</span></h5>
                  <p>경기지역 채팅방입니다</p>
                </div>
              </div>
         </div>
         
         <div class="chat_list" id="gangwon">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Gangwon_Chat <span class="chat_date">강원</span></h5>
                  <p>강원지역 채팅방입니다</p>
                </div>
              </div>
         </div>
         
         <div class="chat_list" id="chungcheong">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Chungcheong_Chat <span class="chat_date">충청</span></h5>
                  <p>충청지역 채팅방입니다</p>
                </div>
              </div>
         </div>
         
         <div class="chat_list" id="jeonla">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Jeonla_Chat <span class="chat_date">전라</span></h5>
                  <p>전라지역 채팅방입니다</p>
                </div>
              </div>
         </div>
         
         <div class="chat_list" id="gyeongsang">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Gyeongsang_Chat <span class="chat_date">경상</span></h5>
                  <p>경상지역 채팅방입니다</p>
                </div>
              </div>
         </div>
         
         <div class="chat_list" id="jeju">
              <div class="chat_people">
                <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
                <div class="chat_ib">
                  <h5>Jeju_Chat <span class="chat_date">제주</span></h5>
                  <p>제주지역 채팅방입니다</p>
                </div>
              </div>
         </div>
         
	 	</div> <!-- inbox_chat 끝 -->
	 	
     </div> <!-- inbox_chatList 끝 -->
     <!--  리스트끝-->
     
     <!--  메시지 시작 -->
	 <div class="mesgs">
          <div class="msg_history" id='messageList'>
           </div> <!-- msg_history 끝 -->
            
            <div class="type_msg">
            <div class="input_msg_write">
              <input id="input" type="text" class="write_msg" placeholder="Type a message" />
              <button id="send_button" class="msg_send_btn" type="button"><i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>
            </div>
          	</div>
          	
       </div> <!--  메시지 끝 -->
       
       <!--  리스트 시작 -->
        <div class="inbox_nameList">
        
        <div class="headind_srch">
	        <div class="recent_heading">
	              <h4>Participants</h4>
	        </div>
        </div>
        
        <div class="inbox_chat" id="nameList">
	 	</div> <!-- inbox_chat 끝 -->
	 	
     </div> <!-- inbox_chatList 끝 -->
     <!--  리스트끝-->
     
     </div>
     <p class="text-center top_spac"> 알딸딸프로젝트는 건전한 채팅문화를 추구합니다.</p>
</div>
</div>

</body>
</html>