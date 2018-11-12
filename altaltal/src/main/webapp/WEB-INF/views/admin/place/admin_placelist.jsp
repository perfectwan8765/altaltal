<%@page import="com.spring.altaltal.freeboard.PageInfo"%>
<%@page import="com.spring.altaltal.hotplace.HotplaceVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%
	if(session.getAttribute("admin") == null){
		out.println("<script>");
		out.println("alert('관리자계정으로 로그인 해주세요.');");
		out.println("location.href='./main.me';");
		out.println("</script>");
	}
	
	ArrayList<HotplaceVO> placeList = (ArrayList<HotplaceVO>)request.getAttribute("placeList");
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

<title>관리자_ 맛집리스트</title>
<style type="text/css">
#page-wrapper{
	padding-bottom: 150px;
}
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
  width: 900px;
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
	
	function deleteCheck(place_num){
		if(confirm("해당 맛집 정보를 삭제하시겠습니까?")){
			location.href="./deletePlace.ad?place_num="+ place_num;
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
		<br/><h2>맛집리스트</h2><br/>

  <div class="container">
  <div id="makguli_insert"><button class="member_change" onclick="location.href='./adminPlaceInsertForm.ad'">추가</button></div>		
  <table class="table table-sm table-hover">
    <colgroup>
      <col width="8%">  <!-- 지역 -->
      <col width="14%">   <!--  맛집명   -->
      <col width="30%"> <!-- 주소 -->
      <col width="12%"> <!-- 가격대 -->
      <col width="8%">  <!-- 좋아요 -->
      <col width="8%">  <!-- 조회수 -->
      <col width="20%">  <!-- 수정, 삭제 버튼 -->
    </colgroup>


<%
if(placeList != null && listCount > 0){
%>
	<thead class="thead-line1">
			<tr style="font-weight:580; text-align:center" >
				<td>지역</td>
				<td>맛집명</td>
				<td>주소</td>
				<td>가격대</td>
				<td>좋아요</td>
				<td>조회수</td>
				<td>&nbsp;</td>
			</tr>
	</thead>
	<tbody>
			<%
		for(int i=0;i<placeList.size();i++){
			
	%>
			<tr align='center'>
				<td><%=placeList.get(i).getPlace_area() %></td>
				<td><a href="adminPlace.ad?place_num=<%=placeList.get(i).getPlace_num() %>" ><%=placeList.get(i).getPlace_name() %></a></td>
				<td><%=placeList.get(i).getPlace_juso() %></td>
				<td><%if(placeList.get(i).getPlace_price().equals("9choen")){ %>1만원 이하<%}%>
						<%if(placeList.get(i).getPlace_price().equals("1man")){ %>1만원 ~ 2만원<%}%>
						<%if(placeList.get(i).getPlace_price().equals("2man")){ %>2만원 ~ 3만원<%} %>
						<%if(placeList.get(i).getPlace_price().equals("3man")){ %>3만원 ~ 4만원<%}%>
						<%if(placeList.get(i).getPlace_price().equals("4man")){ %>4만원 ~ 5만원<%} %>
						<%if(placeList.get(i).getPlace_price().equals("4man")){ %>5만원 이상<%} %></td>
				<td><%=placeList.get(i).getPlace_likecount() %></td>
				<td><%=placeList.get(i).getPlace_readcount() %></td>
				<td><button class="member_change" onclick="location.href='placeUpdateForm.ad?place_num=<%=placeList.get(i).getPlace_num()%>'" >수정</button>
				<button class="member_change" onclick="deleteCheck('<%=placeList.get(i).getPlace_num() %>')" >삭제</button>
			</tr>
			<%} %>
		</tbody>
		</table>
		</div>
	
	<div class="container">

          <form class="form-inline" action="./adminPlaceList.ad" method="POST" onsubmit="return searchCheck();" >
              <center>
                          <select class="form-control" name="topic" id="topic">
                              <option value="area" >지역</option>
                              <option value="place" >맛집명</option>
                              <option value="juso" >주소</option>
                              <option value="phone" >전화번호</option>
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
		<li><a href="adminPlaceList.ad?page=<%=nowPage-1 %>&topic=<%=topic%>&keyword=<%=keyword%>" >«</a></li>&nbsp;
		<%} %>
		
		<%for(int a=startPage;a<=endPage;a++){
				if(a==nowPage){%>
		<li><a><%=a %></a></li>
		<%}else{ %>
		<li><a href="adminPlaceList.ad?page=<%=a %>&topic=<%=topic%>&keyword=<%=keyword%>" ><%=a %>
		</a></li>&nbsp;
		<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
		<li><a>»</a></li>
		<%}else{ %>
		<li><a href="adminPlaceList.ad?page=<%=nowPage+1 %>&topic=<%=topic%>&keyword=<%=keyword%>" >»</a></li>
		<%} %>
		</ul>
	</div>
	</section>
	<%
    }
	else
	{
	%>
	<section id="emptyArea">등록된 맛집이 없습니다.<br/><br/>
	<div>
	</div>
	<div class="empty_bottom"></div>
	</section>
	<%
	}
%>
</div>
<jsp:include page="../../footer.jsp" flush="true"></jsp:include>
</body>
</html>