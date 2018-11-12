<%@ page import="com.spring.altaltal.freeboard.FreeboardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String nickname = (String)session.getAttribute("nickname");
	String profile  = (String)session.getAttribute("profile");
	FreeboardVO article = (FreeboardVO)request.getAttribute("article");
    String nowPage = (String)request.getAttribute("page");
    String article_num = (String)request.getAttribute("article_num");
%>

<!DOCTYPE html>
<html>
<head>
<!-- Boot Strap -->

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpoint" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<title>Project Altaltal</title>
<script>
	$(document).ready(function(){
		
		function printReplyArticle(){
			$('#reply-list').empty();
			
			$.ajax({
				url: '/altaltal/getReplyArticle.fr',
				type: 'POST',
				data: { "free_num" : <%=article.getFree_num() %>},
				dataType: 'json',
				contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
				success: function(data){
					$.each(data, function(index, reply){
						var dt= new Date(reply.free_date);
						var output = '';
						output += "<article id='"+ reply.free_num +"_div' class='row'><div class='col-md-2 col-sm-2 hidden-xs'><figure class='thumbnail'>";
						output += "<img class='img-responsive' src='/altaltal/image/profile/" + reply.member_picture +"' width='30' height='30' />";
						output += "</figure></div><div class='col-md-10 col-sm-10'><div class='panel panel-default arrow left'>";
						output += "<div class='panel-body'><header class='text-left'>";
						if(reply.free_ref_level >1){
							output += "<div class='comment-user'><i class='glyphicon glyphicon-upload'></i> &nbsp;re-comment</div>";
						}
						output += "<div class='comment-user'><i class='glyphicon glyphicon-user'></i> " + reply.member_nickname +"";
						output += "&nbsp;&nbsp;&nbsp;&nbsp;<i class='glyphicon glyphicon-time'></i> " + dt.getFullYear() + "/" + (dt.getMonth()+1) + "/" + dt.getDate() + " " + dt.getHours() + ":" + dt.getMinutes() + "</div>";
						output += "</header><div class='comment-post'><p>" + reply.free_content + "</p></div>";
						output += "<p class='text-right'>";
						output +=	"<button class='btn btn-default btn-sm' onclick='displaybt("+ reply.free_num +");' ><i class='glyphicon glyphicon-send'></i> &nbsp;reply</button>";
						output += "&nbsp;&nbsp;<button type='button' onclick='updateComment(\"" + reply.free_num +"\", \""+ reply.member_nickname + "\");' class='btn btn-default btn-sm' ><i class='glyphicon glyphicon-scissors'></i> &nbsp;modify</button>";
						output += "&nbsp;&nbsp;<button type='button' onclick='deleteComment(\"" + reply.free_num +"\", \""+ reply.member_nickname + "\");' class='btn btn-default btn-sm' ><i class='glyphicon glyphicon-trash'></i> &nbsp;delete</button><br/>";
						output += "</p></div></div></div></article>"
						
						output += "<form action='./updateComment.fr' name='commentForm' method='post' >";
						output += "<input type='hidden' name='main_num' value='<%=article.getFree_num() %>' />";
						output += "<input type='hidden' name='page' value='<%=nowPage %>' />";
						output += "<input type='hidden' name='free_num' value='" + reply.free_num +"' />";
						output += "<input type='hidden' name='article_num' value='<%=article_num %>' />";
						output += "<article id='"+ reply.free_num +"_update' class='row commentReply'><div class='col-md-2 col-sm-2 hidden-xs'><figure class='thumbnail' >";
						output += "<img class='img-responsive' src='<spring:url value="/image/profile/${sessionScope.profile }" />' width='30' height='30' />";
						output += "</figure></div><div class='col-md-10 col-sm-10'><div class='panel panel-default arrow left'>";
						output += "<div class='panel-body'><header class='text-left'><div class='comment-user'><i class='glyphicon glyphicon-refresh'></i> &nbsp;re-comment</div>";
						output += "<div class='comment-post'><p>";
						output += "<textarea name='free_content' rows='5' cols='80' placeholder='comment here...' >"+ reply.free_content +"</textarea></p></div>";
						output += "<p class='text-right'>";
						output += "<button type='button' onclick='loginCheck(this.form);' class='btn btn-default btn-sm' ><i class='glyphicon glyphicon-send'></i> &nbsp;reply</button>";
						output += "&nbsp;&nbsp;<button type='button' onclick='returnComment(\"" + reply.free_num +"\");' class='btn btn-default btn-sm' ><i class='glyphicon glyphicon-scissors'></i> &nbsp;cancel</button>";
						output += "</p></div></div></div></article></form>";					
						output += "<form action='./boardWrite.fr' name='commentForm' method='post' >";
						output += "<input type='hidden' name='free_ref' value='" + reply.free_ref +"' />";
						output += "<input type='hidden' name='free_ref_seq' value='" + reply.free_ref_seq +"' />";
						output += "<input type='hidden' name='free_ref_level' value='" + reply.free_ref_level +"' />";
						output += "<input type='hidden' name='member_nickname' value='<%=nickname%>' />";
						output += "<article id='"+ reply.free_num +"_comment' class='row commentReply'><div class='col-md-2 col-sm-2 hidden-xs'><figure class='thumbnail' >";
						<%if(session.getAttribute("email") == null){%>
						output += "<img class='img-responsive' src='./resources/image/guest.png' width='30' height='30' />";
						<%}else{%>
						output += "<img class='img-responsive' src='<spring:url value="/image/profile/${sessionScope.profile }" />' width='30' height='30' />";
						<%}%>
						output += "</figure></div><div class='col-md-10 col-sm-10'><div class='panel panel-default arrow left'>";
						output += "<div class='panel-body'><header class='text-left'><div class='comment-user'><i class='glyphicon glyphicon-refresh'></i> &nbsp;re-comment</div>";
						output += "<div class='comment-post'><p>";
						output += "<textarea name='free_content' rows='5' cols='80' placeholder='comment here...' ></textarea></p></div>";
						output += "<p class='text-right'>";
						output += "<button type='button' onclick='loginCheck(this.form);' class='btn btn-default btn-sm' ><i class='glyphicon glyphicon-send'></i> &nbsp;reply</button>";
						output += "</p></div></div></div></article></form>"

						$('#reply-list').append(output);
					});	
				},
				error: function() {alert('ajax 통신실패');}
			});
		}
		printReplyArticle();
	});
	
	function displaybt(free_num){
		if($('#'+free_num+'_comment').css('display') == 'block'){
			$('#'+free_num+'_comment').css('display', 'none');
		}else{
			$('#'+free_num+'_comment').css('display', 'block');
		}
	}
	
	
	function articleDelete(){
		var writer = '<%=article.getMember_nickname() %>'; 
		var user = '<%=session.getAttribute("nickname") %>'; 
		if(user === writer){
			if(window.confirm("해당 게시물을 삭제하시겠습니까?")){
				location.href="./articleDelete.fr?page=<%=nowPage%>&free_num=<%=article.getFree_num() %>";
			}
		}else{
			alert("해당글 게시자만 삭제 가능합니다.");
		}
	}
	
	function updateWriterCheck(){
		var user = '<%=session.getAttribute("nickname") %>';
		var writer = '<%=article.getMember_nickname() %>';
		
		if(user === writer){
		location.href='./articleUpdateForm.fr?page=<%=nowPage%>&free_num=<%=article.getFree_num()%>&article_num=<%=article_num%>';
		}else{
			alert("해당글 게시자만 수정이 가능합니다.");
		}
	}
	
	function loginCheck(this_form){

		var content = this_form.free_content.value;
		if('<%=session.getAttribute("email") %>' == null || '<%=session.getAttribute("email") %>' === ""){
			alert("회원만 댓글을 입력할 수 있습니다.");
			return false;
		}
		
		if(content == null || content === ""){
			alert("댓글 내용을 입력해주세요.");
			this_form.free_content.focus();
			return false;
		}
		this_form.submit();
	}
	
	function deleteComment(free_num, writerName){
		var user = '<%=(String)session.getAttribute("nickname") %>';
		alert(free_num);
		if(user !== writerName){
			alert("해당 댓글 작성자만 삭제가능합니다.");
		}else{
			if(confirm("해당 댓글을 삭제하시겠습니까?"))
			location.href="./commentDelete.fr?free_num="+ free_num +"&main_num=<%=article.getFree_num() %>&page=<%=nowPage%>&article_num=<%=article_num%>";
		}
	}
	
	function updateComment(free_num, writerName){
		var user = '<%=(String)session.getAttribute("nickname") %>';
		if(user !== writerName){
			alert("해당 댓글 작성자만 수정가능합니다.");
		}else{
			if($('#'+free_num+'_div').css('display') == 'block'){
				$('#'+free_num+'_div').css('display', 'none');
				$('#'+free_num+'_update').css('display', 'block');
			}else{
				$('#'+free_num+'_div').css('display', 'block');
				$('#'+free_num+'_update').css('display', 'none');
			}	
		}
	}
	function returnComment(free_num){
		if($('#'+free_num+'_div').css('display') == 'block'){
			$('#'+free_num+'_div').css('display', 'none');
			$('#'+free_num+'_update').css('display', 'block');
		}else{
			$('#'+free_num+'_div').css('display', 'block');
			$('#'+free_num+'_update').css('display', 'none');
		}	
	}
</script>
<style type="text/css">

.mainheader{
	text-align: center
}

.board_view {
margin:auto; 
width:50%;
border-top:1px solid #ccc;
border-bottom:1px solid #ccc
}
.board_view tbody th {
text-align:left;
background:#f7f7f7;
color:#3b3a3a
}
.board_view tbody th.list_tit {
font-size:13px;
color:#000;
letter-spacing:0.1px
}
.board_view tbody .no_line_b th, .board_view tbody .no_line_b td {
border-bottom:none
}
.board_view tbody th, .board_view tbody td {
padding:15px 0 16px 16px;
border-bottom:1px solid #ccc
}
.board_view tbody td.view_text {
border-top:1px solid #ccc; 
border-bottom:1px solid #ccc;
padding:45px 18px 45px 18px
}
.board_view tbody th.th_file {
padding:0 0 0 15px;
 vertical-align:middle
}
 
 .view_button {
 position: absolute;
 right: 25%;
 }
.button{
	-moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
	-webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
	box-shadow:inset 0px 1px 0px 0px #ffffff;
	background-color:#ffffff;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #dcdcdc;
	display:inline-block;
	cursor:pointer;
	color:#666666;
	font-family:Arial;
	font-size:12px;
	font-weight:bold;
	padding:6px 11px;
	text-decoration:none !important;<!-- important:강제로 지정하기 -->
	text-shadow:0px 1px 0px #ffffff;
}
.button:hover {
	background-color:#f6f6f6;
}
.button:active {
	position:relative;
	top:1px;
}
</style>
<style type="text/css">
#comment_div{
	width: 48%;
	margin: auto;
	padding-bottom: 150px;
}
.comment-list .row {
  margin-bottom: 0px;
}
.comment-list .panel .panel-heading {
  padding: 4px 15px;
  position: absolute;
  border:none;
  /*Panel-heading border radius*/
  border-top-right-radius:0px;
  top: 1px;
}
.comment-list .panel .panel-heading.right {
  border-right-width: 0px;
  /*Panel-heading border radius*/
  border-top-left-radius:0px;
  right: 16px;
}
.comment-list .panel .panel-heading .panel-body {
  padding-top: 6px;
}
.comment-list figcaption {
  /*For wrapping text in thumbnail*/
  word-wrap: break-word;
}
/* Portrait tablets and medium desktops */
@media (min-width: 768px) {
  .comment-list .arrow:after, .comment-list .arrow:before {
    content: "";
    position: absolute;
    width: 0;
    height: 0;
    border-style: solid;
    border-color: transparent;
  }
  .comment-list .panel.arrow.left:after, .comment-list .panel.arrow.left:before {
    border-left: 0;
  }
  /*****Left Arrow*****/
  /*Outline effect style*/
  .comment-list .panel.arrow.left:before {
    left: 0px;
    top: 30px;
    /*Use boarder color of panel*/
    border-right-color: inherit;
    border-width: 16px;
  }
  /*Background color effect*/
  .comment-list .panel.arrow.left:after {
    left: 1px;
    top: 31px;
    /*Change for different outline color*/
    border-right-color: #FFFFFF;
    border-width: 15px;
  }
  /*****Right Arrow*****/
  /*Outline effect style*/
  .comment-list .panel.arrow.right:before {
    right: -16px;
    top: 30px;
    /*Use boarder color of panel*/
    border-left-color: inherit;
    border-width: 16px;
  }
  /*Background color effect*/
  .comment-list .panel.arrow.right:after {
    right: -14px;
    top: 31px;
    /*Change for different outline color*/
    border-left-color: #FFFFFF;
    border-width: 15px;
  }
}
.comment-list .comment-post {
  margin-top: 6px;
}
.commentReply{
	display: none;
}
</style>
</head>

<body>
<jsp:include page="../menubar.jsp" flush="true" ></jsp:include>
		<br/>
		<h3 class="mainheader">게시물</h3>
		<br/>		
        <table class="board_view">
            <colgroup>
                <col width="15%"/>
                <col width="35%"/>
                <col width="15%"/>
                <col width="35%"/>
            </colgroup>
            
            <tbody>
                <tr>
                    <th scope="row">글 번호</th>
                    <td><%=article_num %></td>
                    <th scope="row">조회수</th>
                    <td><%=article.getFree_readcount()%></td>
                </tr>
                <tr>
                    <th scope="row">작성자</th>
                    <td><%=article.getMember_nickname()%></td>
                    <th scope="row">작성시간</th>
                    <td><%=article.getFree_date()%></td>
                </tr>
                <tr>
                    <th scope="row">제목</th>
                    <td colspan="3">
                       <%=article.getFree_subject()%>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="view_text">
                      <%=article.getFree_content() %>
                    </td>
                </tr>
            </tbody>
        </table>
		<br/>
		<div class="view_button">
		 <button type="button" class="button" onclick="updateWriterCheck(); ">수정</button>
         <button type="button" class="button" onclick="articleDelete();">삭제</button>
         <button type="button" class="button" onclick="location.href='./getMainBoardList.fr?page=<%=nowPage%>'">목록</button>
		</div>
		<br /> 

		<!--  댓글 시작 -->
	
		<div id="comment_div">
  			<div class="row comment_div">
      				<h3 class="page-header" >Comments</h3>
       					<section class="comment-list">
       					
       		<!-- 해당글 댓글 입력하는 공간 --> 
       		
       		<form action="./boardWrite.fr" name="commentForm" method='post'  >	
       		<input type='hidden' name='member_nickname' value='<%=nickname%>' />
       		<input type='hidden' name='free_ref' value='<%=article.getFree_num()%>' />
       		<input type='hidden' name='free_ref_seq' value='<%=article.getFree_ref_seq()%>' />
		    <input type='hidden' name='free_ref_level' value='<%=article.getFree_ref_level()%>' />		
       		<article class="row">
           	<div class="col-md-2 col-sm-2 hidden-xs">
              <figure class="thumbnail">
	               <img class="img-responsive" 
	               <%if(session.getAttribute("profile") == null){ %> src="./resources/image/guest.png" <%}else{%> 
	        		src="<spring:url value='/image/profile/${sessionScope.profile }' />" <% } %> width="30" height="30" />
              </figure>
            </div>
            <div class="col-md-10 col-sm-10">
              <div class="panel panel-default arrow left">
                <div class="panel-body">
                  <div class="comment-post">
                    <p>
                     <textarea name='free_content' rows="5" cols="80" placeholder=" comment here..." ></textarea>
                    </p>
                  </div>
                  <p class="text-right">
                  <c:choose>
                  	<c:when test="${null eq sessionScope.email}" >
                  	<button type="button" class="btn btn-default btn-sm" onclick="alert('회원만 댓글을 입력할 수 있습니다.');" ><i class="glyphicon glyphicon-send"></i>reply</button><br/>
            		</c:when>
            		<c:otherwise>
	             	<button type="button" onclick="loginCheck(this.form);" class="btn btn-default btn-sm" ><i class="glyphicon glyphicon-send"></i> reply</button><br/>
               		</c:otherwise>
               	</c:choose></p>
                </div>
              </div>
            </div>
          </article>
          </form>	<!-- 해당글 댓글 입력하는 공간 --> 
          
          
       	<div  id="reply-list" ></div> <!-- 해당글 댓글 들어가는 공간 -->
		</section>
  	</div>
</div>

<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>