<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>글 상세보기</title>
<jsp:include page="../menubar.jsp" flush="true" ></jsp:include>
<link rel="stylesheet" href="/resources/css/board/view.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<div class="full_body">
	<br/><h3 class="mainheader">게시물</h3><br/>
			
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
                	<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.updatedate }" />
                </c:if>
                </td>
            </tr>
            <tr>
            	<th scope="row">제목</th>
                <td colspan="3">${board.title }</td>
            </tr>
            <tr>
            	<td colspan="4" class="view_text">${board.content }</td>
            </tr>
        </tbody>
	</table>
	<br/>
	
	<form action="" name="buttonForm">
		<input type="hidden" name="page" value="${cri.page }" />
		<input type="hidden" name="topic" value="${cri.topic }" />
		<input type="hidden" name="keyword" value="${cri.keyword }" />
		<input type="hidden" name="bno" value="${board.bno }" />
		<div class="view_button">
			<c:if test="${board.uname eq login.uname }">
			<button type="button" class="button" id="updateBtn" >수정</button>
	        <button type="button" class="button" id="deleteBtn" >삭제</button>
	        </c:if>
	        <button type="button" class="button" id="listBtn" >목록</button>      
		</div>
	</form>
	<br />
	
	<!-- 댓글 시작  -->
	<div class="row board_view" style="margin-top:20px;">
        <div class="panel panel-default widget">
            <div class="panel-heading">
                <span class="glyphicon glyphicon-comment"></span>
                <span class="panel-title">Reply</span>
            </div>
            
            <div class="panel-body">
            <c:if test="${login ne null }">
	        <div class="row">
	          	<div class="col-md-2" >
                	<img src="http://placehold.it/80" class="img-circle img-responsive" alt="" />                  
                 </div>
            	<div class="col-md-10">
    				<input type="text" id="replytext" class="form-control" placeholder="Write in your wall">
    				<span>${login.uname}</span>
                	<button type="submit" id="replybtn" class="btn btn-success" 
                       	style="float:right; margin-top:5px;">Post reply</button>
                </div>
           </div>
           </c:if>	<!-- body.row -->
           <c:if test="${login eq null }">
           <div>login을 해야 댓글 입력이 가능합니다.</div>
           </c:if>
           </div> <!-- panel-body --> 
           
           <div id="replydiv" class="panel-body"></div>
           
           <div id="pageList" style="text-align:center;"><ul class="pagination"></ul></div>
           	
       </div> <!-- div.widget -->
       
	</div>
	
	
</div>
	<script id="template" type="text/x-handlebars-template">
		{{#each .}}
			<div class="row" data-role={{rno}}>
	          	<div class="col-md-2" >
                	<img src="http://placehold.it/80" class="img-circle img-responsive" alt="" />
                 </div>
            	<div class="col-md-10">
    				<input type="text" class="form-control" value="{{replytext}}">
					<span>writer : {{uname}}, regdate: {{replyDate regdate}}</span>
					{{#isWriter uname }}
					<button class="btn btn-danger" style="float:right; margin-top:5px;">Delete reply</button>
                    <button class="btn btn-primary" style="float:right; margin-top:5px; margin-right:5px;">Modify reply</button>			
                	{{/isWriter}}
				</div>
           </div>
		{{/each}}
	</script>
	<script>
		var bno = ${board.bno};
		var replyPage = 1;
	
		$("#replybtn").on("click", function(){
			var text = $("#replytext").val();
			var uname = "${login.uname}";
			
			$.ajax({
				type:'post',
				url:'/replies/',
				headers:{
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "POST"
				},
				dataType:'text',
				data: JSON.stringify({bno:bno, uname:uname, replytext:text}),
				success:function(result){
					console.log("result:" + result);
					if(result == 'SUCCESS'){
						alert("등록되었습니다.");
						getPage("/replies/" + bno + "/1");
						$("#replytext").val("");
					}
				}
			});
		});
		
		Handlebars.registerHelper("replyDate", function(timeValue){
			var dateObj = new Date(timeValue);
			var year = dateObj.getFullYear();
			var month = dateObj.getMonth()+1;
			var date = dateObj.getDate();
			
			return year + "/" +month + "/" + date;
		});
		
		Handlebars.registerHelper("isWriter", function(writer, opts){
			var user = "${login.uname}";
			if (user == writer) {
				return opts.fn(this);
			}else {
				return opts.inverse(this);
			}
		});
		
		var printData = function(replyArr, target, templateObject){
			
				var template = Handlebars.compile(templateObject.html());
				var html = template(replyArr);
				$("#replydiv").html("");
				target.html(html);
		};
		
		var printPage = function(pageMaker, target){
				
			var str = "";
			
			if(pageMaker.prev){
				str += "<li><a href='" + (pageMaker.startPage - 1) + "'> << </a></li>";
			}
			
			for(var i=pageMaker.startPage; i<=pageMaker.endPage; i++){
				var strClass = pageMaker.cri.page == i ? 'class=active' : '';
				str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
			}
			
			if(pageMaker.next){
				str += "<li><a href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
			}
			
			target.html(str);
			
		};
			
		function getPage(pageInfo){
			$.getJSON(pageInfo, function(data){
				printData(data.list, $("#replydiv"), $("#template"));
				printPage(data.pageMaker, $(".pagination"));
			});
		}
		
		$(".pagination").on("click", "li a", function(event){
			event.preventDefault();
			replyPage = $(this).attr("href");
			getPage("/replies/"+ bno + "/" + replyPage);
		});
		
		$(document).ready(function(){
			getPage("/replies/" + bno + "/1");
		});
	</script>

	<script>
		var formObj = $("form[name=buttonForm]");
	
		$("#updateBtn").on("click", function(event){
			formObj.attr("method", "get");
			formObj.attr("action", "/board/update");
			formObj.submit();				
		});
		
		$("#deleteBtn").on("click", function(event){
			formObj.attr("method", "post");
			formObj.attr("action", "/board/delete");
			formObj.submit();				
		});
		
		$("#listBtn").on("click", function(event){
			formObj.attr("method", "get");
			formObj.attr("action", "/board/list");
			formObj.submit();				
		});
		
	</script>

<jsp:include page="../footer.jsp" flush="true"></jsp:include>