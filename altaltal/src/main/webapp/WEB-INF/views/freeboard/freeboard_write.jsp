<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		
		if(session.getAttribute("email") == null){
			out.print("<script>");
			out.print("alert('회원만 글쓰기가 가능합니다.')");
			out.print("location.href='./main.me'");
			out.print("</script>");
		}
		
		String email = (String)session.getAttribute("email");
		String nickname = (String)session.getAttribute("nickname");
		String nowPage = (String)request.getAttribute("page");

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewpoint" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="//cdn.ckeditor.com/4.10.0/basic/ckeditor.js"></script>

<title>MVC 게시판</title>
<style type="text/css">
.write_section{
 padding: 10px 10px;
}
#registForm {
   width: 500px;
   height: 610px;
   border: 1px solid red;
   margin: auto;
}

h2 {
   text-align: center;
}

table {
   margin: auto;
   width: 450px;
}

.td_left {
   width: 150px;
   background: orange;
}

.td_right {
   width: 300px;
   background: skyblue;
}


.board_view {
margin:auto; 
width:50%;
border-top:1px solid #ccc;
   
border-bottom:1px solid #ccc;
margin-bottom: 5px;
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
padding:18px 15px 18px 15px;
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
   text-decoration:none !important;
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
</head>
<body>
<jsp:include page="../menubar.jsp" flush="true" />
   <!-- 게시판 등록 -->

<div class="full_body">
          <form action="./boardWrite.fr" method="post" name="boardform">
          <input type='hidden' name='free_ref' value='0' />
          <input type='hidden' name='free_ref_seq' value='0' />
		  <input type='hidden' name='free_ref_level' value='0' />
   <table class="board_view">
   
      <colgroup>
         <col width="15%">
         <col width="*"/>
         </colgroup>
         <caption>게시글 작성</caption>
         <tbody>
         <tr>
             <th scope="row">글쓴이 </th>
             <td><%=nickname %></td>
             <input type="hidden" name="member_nickname" value='<%=nickname %>' />
           </tr>
         <tr>
            <th scope="row">제목</th>
            <td><input type="text" id="free_subject" name="free_subject" class="free_subject"></input></td>
         </tr>
         <tr>
                    <td colspan="2" class="view_text">
                        <textarea rows="10" cols="100" title="내용" id="free_content" name="free_content"></textarea>
                       <script>
                       CKEDITOR.replace( 'free_content' );
                       </script>
                    </td>
                </tr>
         </tbody>
   </table>
       <div class="view_button">
       <button type="submit" class="button" >작성</button>
       <button type="button" class="button" onclick="location.href='getMainBoardList.fr?page=<%=nowPage%>'">목록</button>
        </div>
   </form>
  </div>
<jsp:include page="../footer.jsp" flush="true" />
</body>
</html>