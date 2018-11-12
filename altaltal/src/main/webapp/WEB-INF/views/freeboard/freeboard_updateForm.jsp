<%@ page import="com.spring.altaltal.freeboard.FreeboardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	
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
<script src="//cdn.ckeditor.com/4.10.0/basic/ckeditor.js"></script>

<title>MVC 게시판</title>
<script>
	function updateCheck(this_form){
		var content = this_form.free_content.value;
		var subject = this_form.free_subject.value;
		
		if(content == null || content == ""){
			alert("해당글을 입력해주세요.");
			this_form.free_content.focus();
		}else if(subject == null || subject == ""){
			alert("작성자를 입력해주세요.");
			this_form.free_subject.focus();
		}else{
			this_form.submit();
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
#update_container{
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

	<!-- 게시판 수정 -->
		</br>
		</br>
		<div id="update_container">
		 <form action="./articleUpdate.fr" method="post" name="updateform">
		 <input type="hidden" name="free_num" value="<%=article.getFree_num() %>" />
		 <input type="hidden" name="page" value="<%=nowPage %>" />
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
                       <input type="text" name="free_subject" value="<%=article.getFree_subject()%>" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="view_text">
                     <textarea rows="10" cols="100" title="내용" id="free_content" name="free_content"><%=article.getFree_content() %></textarea> 
                    <script>
                       CKEDITOR.replace( 'free_content' );
                       </script>
                    </td>
                </tr>
            </tbody>
        </table>
		</br>
		<div class="view_button">
		 <button type="button" class="button" onclick="updateCheck(this.form);">수정</button>
         <button type="button" class="button" onclick="location.href='./getMainBoardList.fr?page=<%=nowPage%>'">목록</button>
		</div>
		</form>
		</div>
		<br /> 
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>