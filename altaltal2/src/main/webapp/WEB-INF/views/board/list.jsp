<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>자유게시판</title>
<jsp:include page="../menubar.jsp" flush="true" />
<link rel="stylesheet" href="/resources/css/board/list.css" />
<section class="entryArea">
<br/><h2>자유게시판</h2><br/>
		
  <div class="container">		
  <table class="table table-sm table-hover">
    <colgroup>
      <col width="7%">  <!-- 글 번호 -->
      <col width="25%">   <!--  제목   -->
      <col width="15%"> <!-- 작성자 -->
      <col width="20%"> <!-- 작성일 -->
      <col width="7%">  <!-- 조회수 -->
    </colgroup>

<c:if test="${not empty list }">
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
		<c:forEach items="${list}" var="board" varStatus="status">
			<tr>
				<td align='center'>${pageMaker.startNum - status.index }</td>
				<td>
					 <a href="/board/view?&bno=${board.bno }&page=${cri.page}">${board.title }</a>
				</td>
				<td align='center'>${board.uname }</td>
				<td align='center'><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.regdate }"/></td>
				<td align='center'>${board.viewcnt }</td>
			</tr>
		</c:forEach>
	</tbody>
	</table>
	</div>
	
	<div class="container" align="right" >
		<a href="/board/write?page=${cri.page}" class="write" >글쓰기</a>
	</div>
	
	<div class="container" align="center">
    	<form class="form-inline" action="/board/list" method="get" >
        	<select class="form-control" name="topic" required>
        		<option <c:out value="${cri.topic eq null ? 'selected': '' }" /> >- 분류 -</option>
            	<option <c:out value="${cri.topic eq 'title' ? 'selected': '' }" /> value="title" >제목</option>
                <option <c:out value="${cri.topic eq 'content' ? 'selected': '' }" /> value="content" >내용</option>
                <option <c:out value="${cri.topic eq 'writer' ? 'selected': '' }" /> value="writer" >작성자</option>
            </select>
			<div class="input-group custom-search-form">
                 <input type="text" name="keyword" class="form-control" placeholder="Search..." required>
                 	<span class="input-group-btn">
                    	<button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                    </span>
             </div>
          </form>
     </div>

	<div id="pageList">
		<div class="text-center">
			<ul class="pagination">
			<c:if test="${pageMaker.prev }">
				<li><a href="/board/list?page=${pageMaker.startPage -1}">&laquo;</a></li>
			</c:if>
			
			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="idx">
				<li <c:out value="${pageMaker.cri.page == idx ? 'class=active':' ' }" />> 
					<a href="/board/list?page=${idx}">${idx }</a></li>
			</c:forEach>
			
			<c:if test="${pageMaker.next }">
				<li><a href="/board/list?page=${pageMaker.endPage +1 }">&raquo;</a></li>
			</c:if>
			</ul>
		</div>
	</c:if>
	</div>
</section>

<c:if test="${empty list}">
	<section class="entryArea">등록된 글이 없습니다.
	<br/><br/>
	<div align="right" ><a href="/board/write?page=${cri.page }" >글쓰기</a></div>
	</section>
</c:if>
<jsp:include page="../footer.jsp" flush="true"></jsp:include>
