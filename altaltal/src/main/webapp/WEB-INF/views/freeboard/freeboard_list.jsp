<%@ page import="com.spring.altaltal.freeboard.PageInfo"%>
<%@ page import="com.spring.altaltal.freeboard.FreeboardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	String email = "";
	if(session.getAttribute("email") != null){
		email = (String)session.getAttribute("email");
	}
	
	ArrayList<FreeboardVO> articleList = (ArrayList<FreeboardVO>)request.getAttribute("boardList");
    PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
	int number = listCount-((nowPage-1)*10);
	
	String topic = (String)request.getAttribute("topic");
	String keyword = (String)request.getAttribute("keyword");
	
%>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpoint" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<title>자유게시판</title>
<style type="text/css">
#registForm {
	width: 400px;
	height: 600px;
	border: 1px solid red;
	margin: auto;
}

h2 {
	text-align: center;
}
.container {
  padding-right: 15px;
  padding-left: 15px;
  margin-right: auto;
  margin-left: auto;
  width: 850px;
}

/* @media (min-width: 768px) {
  .container {
    width: 750px;
  }
}

@media (min-width: 992px) {
  .container {
    width: 970px;
  }
}

@media (min-width: 1200px) {
  .container {
    width: 850px;
  }
} */

.write {
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
	margin-right: 13%;
}
.write:hover {
	background-color:#f6f6f6;
}
.write:active {
	position:relative;
	top:1px;
}

/*#tr_top {
	background: orange;
	text-align: center;
}*/

#pageList {
	margin: auto;
	width: 500px;
	text-align: center;
}

#emptyArea {
	margin: auto;
	width: 500px;
	text-align: center;
}
.thead-line1 {
	border-top: 1px solid #ccc;
	border-bottom : 1px solid #ccc;
}
.table{
	border-bottom : 1px solid #ccc;
}
.form-control {
	width : 160px;
}
 .search {
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

	font-family:Arial;
	font-size:12px;
	font-weight:bold;
	padding:5px 11px;
	text-decoration:none;
	text-shadow:0px 1px 0px #ffffff;
}
</style>
<script>
	function searchCheck(){
		if($("#topic").val() == null || $("#topic").val() == ""){
			alert("검색 주제를 선택해주세요.");
			return false;
		}
		
		if($("#keyword").val() == null ||$("#keyword").val() == ""){
			alert("키워드를 입력해주세요.");
			return false;
		}
		return true;
	}
	
	function loginCheck(event){
		var event = event || window.event;
		if('<%=email %>' == null || '<%=email %>' == ""){
			alert("회원만 글쓰기가 가능합니다. 로그인을 해주세요.");
			event.preventDefault();
		}
	}
</script>
</head>


<body>
<jsp:include page="../menubar.jsp" flush="true" />
	<!-- 게시판 리스트 -->

	<section id="listForm">
		</br><h2>자유게시판</h2></br>
		
  <div class="container">		
  <table class="table table-sm table-hover">
    <colgroup>
      <col width="7%">  <!-- 글 번호 -->
      <col width="35%">   <!--  제목   -->
      <col width="15%"> <!-- 작성자 -->
      <col width="10%"> <!-- 작성일 -->
      <col width="7%">  <!-- 조회수 -->
    </colgroup>


<%
if(articleList != null && listCount > 0){
%>
	<thead class="thead-line1">
			<tr style="font-weight:580;" >
				<td style="text-align:center;">번호</td>
				<td style="text-align:left; ">제목</td>
				<td style="text-align:center; ">작성자</td>
				<td style="text-align:center; ">날짜</td>
				<td style="text-align:center; ">조회수</td>
			</tr>
	</thead>
	<tbody>
			<%
		for(int i=0;i<articleList.size();i++){
			
	%>
			<tr>
				<td align='center'><%=number%></td>
				<td>
					 <a href="./getBoardArticle.fr?free_num=<%=articleList.get(i).getFree_num()%>&page=<%=nowPage%>&article_num=<%=number%>">
							<%=articleList.get(i).getFree_subject()%>
					</a>
				</td>

				<td align='center'><%=articleList.get(i).getMember_nickname() %></td>
				<td align='center'><%=articleList.get(i).getFree_date() %></td>
				<td align='center'><%=articleList.get(i).getFree_readcount() %></td>
			</tr>
			<%number--;} %>
		</tbody>
		</table>
		</div>
	<div align="right" ><a href="boardWriteForm.fr?page=<%=nowPage%>" class="write" onclick="loginCheck();">글쓰기</a></div>
	
	
	<div class="container">

          <form class="form-inline" action="./getMainBoardList.fr" method="POST" onsubmit="return searchCheck();" >
              <center>
                          <select class="form-control" name="topic" id="topic">
                              <option value="title" >제목</option>
                              <option value="content" >내용</option>
                              <option value="writer" >작성자</option>
                          </select>


                         <div class="input-group custom-search-form">
                              <input id="keyword" type="text" name="keyword" class="form-control" placeholder="Search...">
                                  <span class="input-group-btn">
                                      <button class="btn btn-default" type="submit">
                                        <i class="glyphicon glyphicon-search"></i>
                                      </button>
                                  </span>
                          </div>
          </form>
      </div>
	</section>


	<section id="pageList">
	<div class="text-center">
	<ul class="pagination">
	<%if(topic.equals("")){ %>
	
		<%if(nowPage<=1){ %>
		<li><a>«</a></li>&nbsp;
		<%}else{ %>
		<li><a href="getMainBoardList.fr?page=<%=nowPage-1 %>">«</a></li>&nbsp;
		<%} %>
		
		<%for(int a=startPage;a<=endPage;a++){
				if(a==nowPage){%>
		<li><a><%=a %></a></li>
		<%}else{ %>
		<li><a href="getMainBoardList.fr?page=<%=a %>"><%=a %>
		</a></li>&nbsp;
		<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
		<li><a>»</a></li>
		<%}else{ %>
		<li><a href="getMainBoardList.fr?page=<%=nowPage+1 %>">»</a></li>
		<%} %>
		
	<%}else{ %>
	
		<%if(nowPage<=1){ %>
		<li><a>«</a></li>&nbsp;
		<%}else{ %>
		<li><a href="articleSearch.fr?page=<%=nowPage-1 %>&topic=<%=topic%>&keyword=<%=keyword %>">«</a></li>&nbsp;
		<%} %>
		
		<%for(int a=startPage;a<=endPage;a++){
				if(a==nowPage){%>
		<li><a><%=a %></a></li>
		<%}else{ %>
		<li><a href="articleSearch.fr?page=<%=a %>&topic=<%=topic%>&keyword=<%=keyword %>"><%=a %>
		</a></li>&nbsp;
		<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
		<li><a>»</a></li>
		<%}else{ %>
		<li><a href="articleSearch.fr?page=<%=nowPage+1 %>&topic=<%=topic%>&keyword=<%=keyword %>">»</a></li>
		<%} %>
		
	<%} %>
		</ul>
	</div>
	</section>
	<%
    }
	else
	{
	%>
	<section id="emptyArea">등록된 글이 없습니다.
	</br>
	</br>
	<div align="right" ><a href="boardWriteForm.fr" class="write" onclick="loginCheck();">글쓰기</a></div>
	</section>
	<%
	}
%>
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>