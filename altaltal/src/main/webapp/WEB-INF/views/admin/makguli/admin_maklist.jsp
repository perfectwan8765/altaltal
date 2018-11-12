<%@page import="com.spring.altaltal.freeboard.PageInfo"%>
<%@page import="com.spring.altaltal.makguli.MakguliVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%
	if(session.getAttribute("admin") == null){
		out.println("<script>");
		out.println("alert('관리자계정으로 로그인 해주세요.');");
		out.println("location.href='./main.me';");
		out.println("</script>");
	}
	
	ArrayList<MakguliVO> makguliList = (ArrayList<MakguliVO>)request.getAttribute("makguliList");
    PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
	
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

<title>관리자_ 막걸리리스트</title>
<style type="text/css">
#page-wrapper{
	padding-bottom: 150px;
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
#emptyArea{
	min-height: 80%;
	padding-bottom: 150px;
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

.member_change {
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
.member_change {
	background-color:#f6f6f6;
}
.member_change {
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
.table>tbody>tr>td{
vertical-align: middle !important;
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
#makguli_insert{
	width: 5%;
	float: right;
	margin-bottom: 10px;
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
	
	function deleteCheck(makguli_num){
		if(confirm("해당 막걸리를 삭제하시겠습니까?")){
			location.href="./makguliDelete.ad?makguli_num="+ makguli_num;
		}
	}
</script>
</head>


<body>
<jsp:include page="../../menubar.jsp" flush="true" />

	<!-- 게시판 리스트 -->
<div id="page-wrapper">
  <jsp:include page="../admin_sidebar.jsp" flush="true" ></jsp:include>
	<section id="listForm">
		<br/><h2>막걸리리스트</h2><br/>

  <div class="container">
  <div id="makguli_insert"><button class="member_change" onclick="location.href='./adminMakguliInsertForm.ad'">추가</button></div>		
  <table class="table table-sm table-hover">
    <colgroup>
      <col width="12%">  <!-- 지역 -->
      <col width="12%">   <!--  제품명   -->
      <col width="12%"> <!-- 제조사 -->
      <col width="12%">  <!-- 사진파일명 -->
      <col width="12%">  <!-- 좋아요 -->
      <col width="12%">  <!-- 조회수 -->
      <col width="20%">  <!-- 수정, 삭제 버튼 -->
    </colgroup>

<%
if(makguliList != null && listCount > 0){
%>
	<thead class="thead-line1">
			<tr style="font-weight:580; text-align:center" >
				<td>지역</td>
				<td>제품명</td>
				<td>제조사</td>
				<td>사진파일명</td>
				<td>좋아요 수</td>
				<td>조회수</td>
				<td>&nbsp;</td>
			</tr>
	</thead>
	<tbody>
			<%
		for(int i=0; i<makguliList.size(); i++){
			
	%>
			<tr align='center'>
				<td><%=makguliList.get(i).getMakguli_area() %></td>
				<td><a href="./adminMakguli.ad?makguli_num=<%=makguliList.get(i).getMakguli_num() %>" ><%=makguliList.get(i).getMakguli_name() %></a></td>
				<td><%=makguliList.get(i).getMakguli_make() %></td>
				<td><%=makguliList.get(i).getMakguli_picture() %></td>
				<td><%=makguliList.get(i).getMakguli_likecount() %></td>
				<td><%=makguliList.get(i).getMakguli_readcount() %></td>
				<td><button class="member_change" onclick="location.href='makguliupdateForm.ad?makguli_num=<%=makguliList.get(i).getMakguli_num()%>'">수정</button>
				<button class="member_change" onclick="deleteCheck('<%=makguliList.get(i).getMakguli_num()%>');">삭제</button>
			</tr>
			<%} %>
		</tbody>
		</table>
		</div>
	
	<div class="container">

          <form class="form-inline" action="./adminMakguliList.ad" method="POST" onsubmit="return searchCheck();" >
              <center>
                          <select class="form-control" name="topic" id="topic">
                              <option value="area" >지역</option>
                              <option value="product" >제품명</option>
                              <option value="make" >제조사</option>
                              <option value="dosu" >도수</option>
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
		<li><a href="adminMakguliList.ad?page=<%=nowPage-1 %>&topic=<%=topic%>&keyword=<%=keyword%>" >«</a></li>&nbsp;
		<%} %>
		
		<%for(int a=startPage;a<=endPage;a++){
				if(a==nowPage){%>
		<li><a><%=a %></a></li>
		<%}else{ %>
		<li><a href="adminMakguliList.ad?page=<%=a %>&topic=<%=topic%>&keyword=<%=keyword%>" ><%=a %>
		</a></li>&nbsp;
		<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
		<li><a>»</a></li>
		<%}else{ %>
		<li><a href="adminMakguliList.ad?page=<%=nowPage+1 %>&topic=<%=topic%>&keyword=<%=keyword%>" >»</a></li>
		<%} %>
		</ul>
	</div>
	</section>
	<%
    }
	else
	{
	%>
	<section id="emptyArea">등록된 막걸리가 없습니다.<br/><br/>
	<div class="empty_bottom"></div>
	</section>
	<%
	}
%>
</div>
<jsp:include page="../../footer.jsp" flush="true"></jsp:include>
</body>
</html>