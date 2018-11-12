<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<title>게시판 글쓰기</title>
<jsp:include page="../menubar.jsp" flush="true" />
<link rel="stylesheet" href="/resources/css/board/write.css" />
   
   <!-- 게시판 등록 -->

<div class="full_body">
	<br/><h3 style="text-align:center;">게시물 작성</h3><br/>
	
   <form action="/board/write" method="post" name="boardform">
   <table class="board_view">
   <colgroup>
   		<col width="15%">
   		<col width="*"/>
   </colgroup>
 		<tbody>
         	<tr>
            	<th scope="row">글쓴이 </th>
           		<td><input type="text" name="uname" value="uname" readonly/></td>
           </tr>
         	<tr>
            	<th scope="row">제목</th>
            	<td><input type="text" name="title" required/></td>
         	</tr>
         	<tr>
            	<td colspan="2" class="view_text">
            	<textarea rows="10" cols="100" class="ckeditor" name="content" required></textarea>
                </td>
            </tr>
         </tbody>
   </table>
   
       <div class="view_button">
       <button type="submit" class="button" >작성</button>
       <button type="button" class="button" onclick="location.href='/board/list?page=${cri.page}'">목록</button>
        </div>
   </form>
</div>
<jsp:include page="../footer.jsp" flush="true" />