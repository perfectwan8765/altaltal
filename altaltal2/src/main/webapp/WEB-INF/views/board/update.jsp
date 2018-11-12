<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>글 수정하기</title>
<jsp:include page="../menubar.jsp" flush="true" ></jsp:include>
<link rel="stylesheet" href="/resources/css/board/view.css">

<div class="full_body">
	<br/><h3 class="mainheader">게시물</h3><br/>
	<form name="updateForm" method="post" action="/board/update" >
		<input type="hidden" name="page" value="${cri.page }" />
		<input type="hidden" name="topic" value="${cri.topic }" />
		<input type="hidden" name="keyword" value="${cri.keyword }" />
		<input type="hidden" name="bno" value="${board.bno }" />		
	<table class="board_view">
    	<colgroup>
        	<col width="15%"/>
        	<col width="35%"/>
        	<col width="15%"/>
       		<col width="35%"/>
       	</colgroup>
            
        <tbody>
        	<tr>
            	<th scope="row">작성자</th>
                <td>${board.uname }</td>
                <th scope="row">조회수</th>
                <td>${board.viewcnt }</td>
            </tr>
            <tr>
            	<th scope="row">작성일</th>
                <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.regdate }"/></td>
                <th scope="row">최근 수정일</th>
                <td>
                <c:if test="${board.updatedate eq null}">없음</c:if>
                <c:if test="${board.updatedate ne null }">
                	<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.updatedate}" />
                </c:if>
                </td>
            </tr>
            <tr>
            	<th scope="row">제목</th>
                <td colspan="3"><input type="text" name="title" value="${board.title }" required /></td>
            </tr>
            <tr>
            	<td colspan="4">
            		<textarea rows="10" cols="100" class="ckeditor" name="content" required>${board.content}</textarea>
            	</td>
            </tr>
        </tbody>
	</table>
	<br/>
	
		<div class="view_button">
			<button type="button" class="button" onclick="javascript:$('form[name=updateForm]').submit();">수정</button>
	        <button type="button" class="button" id="listBtn" >목록</button>
		</div>
	</form>	
	<br />
</div>
	
	<script>
		var formObj = $("form[name=updateForm]");
		
		$("#listBtn").on("click", function(event){
			formObj.attr("method", "get");
			formObj.attr("action", "/board/list");
			formObj.submit();				
		});
		
	</script> 

<jsp:include page="../footer.jsp" flush="true"></jsp:include>