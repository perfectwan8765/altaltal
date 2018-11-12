<%@page import="com.spring.altaltal.freeboard.PageInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	if(session.getAttribute("email") == null){
		out.println("<script>");
		out.println("alert('로그인을 해주세요');");
		out.println("location.href='./main.me'");
		out.println("</script>");
	}
	
	ArrayList<HashMap<String, Object>> commentList = (ArrayList<HashMap<String, Object>>)request.getAttribute("commentList");
    PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
	int number = listCount-((nowPage-1)*10);
	
	String topic = "";
	String keyword = "";
	
	if(request.getAttribute("topic") != null){
		topic = (String)request.getAttribute("topic");
	}
	
	if(request.getAttribute("keyword") != null){
		keyword = (String)request.getAttribute("keyword");
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
%>

<!DOCTYPE html>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpoint" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<title>Project Altaltal</title>
<style type="text/css">
#registForm {
	width: 200px;
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
  width: 80% !important;
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
#page-wrapper{
	padding-bottom: 130px;
}
table tbody td, table thead td{
	vertical-align: middle !important;
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
	
	function articleDelete(article_num, writer){
		var user = '<%=session.getAttribute("nickname") %>';
		if(user === writer){
			if(window.confirm("해당 게시물을 삭제하시겠습니까?")){
			location.href='./mypageArticleDelete.my?page=<%=nowPage%>&free_num=' + article_num;
			}
		}else{
			alert("해당글 게시자만 삭제가 가능합니다.");
		}
	}

</script>
</head>


<body>
<jsp:include page="../menubar.jsp" flush="true" />
	<!-- 게시판 리스트 -->
<div id="page-wrapper">
<jsp:include page="./mypage_sidebar.jsp" flush="true" ></jsp:include>
	<section id="listForm">
		<br/><h2>막걸리 평가 리스트</h2><br/>
		
  <div class="container">		
  <table class="table table-sm table-hover">
    <colgroup>
      <col width="8%">		<!-- 글 번호 -->
      <col width="7%">		<!--  지역   -->
      <col width="16%">		<!-- 막걸리명 -->
      <col width="6%">		<!-- 단맛 -->
      <col width="6%">		<!-- 신맛 -->
      <col width="6%">		<!-- 바디감 -->
      <col width="6%">		<!-- 탄산 -->
      <col width="6%">		<!-- 대중성 -->
      <col width="15%">		<!-- 작성일 -->
      <col width="23%">		<!-- 수정 삭제 -->
    </colgroup>

<%
if(commentList != null && listCount > 0){
%>
	<thead class="thead-line1">
			<tr style="font-weight:580;" >
				<td style="text-align:center;">번호</td>
				<td style="text-align:center; ">지역</td>
				<td style="text-align:center; ">막걸리명</td>
				<td style="text-align:center; ">단맛</td>
				<td style="text-align:center; ">신맛</td>
				<td style="text-align:center; ">바디감</td>
				<td style="text-align:center; ">탄산</td>
				<td style="text-align:center; ">대중성</td>
				<td style="text-align:center; ">작성일</td>
				<td style="text-align:center; ">&nbsp;</td>
			</tr>
	</thead>
	<tbody>
			<%
		for(int i=0;i<commentList.size();i++){
			
	%>
			<tr align='center'>
				<td><%=number%></td>
				<td><%=commentList.get(i).get("makguli_area").toString() %></td>
				<td><%=commentList.get(i).get("makguli_name").toString() %></td>
				<td><%=commentList.get(i).get("mboard_sweat").toString() %>점</td>
				<td><%=commentList.get(i).get("mboard_sour").toString() %>점</td>
				<td><%=commentList.get(i).get("mboard_body").toString() %>점</td>
				<td><%=commentList.get(i).get("mboard_spark").toString() %>점</td>
				<td><%=commentList.get(i).get("mboard_popular").toString() %>점</td>
				<td><%=sdf.format((Date)commentList.get(i).get("mboard_date")) %></td>
				<td><button class="write">평가 수정</button>
				<button class="write" >평가 삭제</button></td>
			</tr>
			<%number--;} %>
		</tbody>
		</table>
		</div>
		
	<div class="container">
          <form class="form-inline" action="./myMakguliCommentList.my" method="POST" onsubmit="return searchCheck();" >
              <center>
                          <select class="form-control" name="topic" id="topic">
                              <option value="name" >막걸리명</option>
                              <option value="area" >막걸리 지역</option>
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
	
		<%if(nowPage<=1){ %>
		<li><a>«</a></li>&nbsp;
		<%}else{ %>
		<li><a href="myMakguliCommentList.my?page=<%=nowPage-1 %>&keyword=<%=keyword%>&topic=<%=topic%>">«</a></li>&nbsp;
		<%} %>
		
		<%for(int a=startPage;a<=endPage;a++){
				if(a==nowPage){%>
		<li><a><%=a %></a></li>
		<%}else{ %>
		<li><a href="myMakguliCommentList.my?page=<%=a %>&keyword=<%=keyword%>&topic=<%=topic%>"><%=a %>
		</a></li>&nbsp;
		<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
		<li><a>»</a></li>
		<%}else{ %>
		<li><a href="myMakguliCommentList.my?page=<%=nowPage+1 %>&keyword=<%=keyword%>&topic=<%=topic%>">»</a></li>
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
	<br/>
	<br/>
	</section>
	<%
	}
%>
</div>
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
</body>
</html>