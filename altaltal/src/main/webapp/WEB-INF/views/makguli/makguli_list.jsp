<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="com.spring.altaltal.freeboard.PageInfo"%>
<%@ page import="com.spring.altaltal.makguli.MakguliVO"%>
<%@ page import="java.util.*"%>
<%
	ArrayList<MakguliVO> makguliList = (ArrayList<MakguliVO>) request.getAttribute("makguliList");

	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
	
	String makguli_area = (String)request.getAttribute("makguli_area");
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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">

<title>막걸리리스트</title>
<style>
/*서브버튼*/
        .topsubmenu {
            background-attachment: fixed;
            margin-bottom:10px;
            padding: 13px;
            border-bottom:1px solid #ccc;
        }
/* 서브버튼 */

/*섹션 부분*/
        section.all_body_content {
            width: 1500px;
            height: 730px;
            border: 1px solid #fff;
            padding-left: 40px;
            float: left;
        }
/* 섹션부분 */



/* 상당버튼 */
        .button {
            -moz-box-shadow: inset 0px 1px 0px 0px #ffffff;
            -webkit-box-shadow: inset 0px 1px 0px 0px #ffffff;
            box-shadow: inset 0px 1px 0px 0px #ffffff;
            background-color: #ffffff;
            -moz-border-radius: 6px;
            -webkit-border-radius: 6px;
            border-radius: 6px;
            border: 1px solid #dcdcdc;
            display: inline-block;
            cursor: pointer;
            color: #666666;
            font-family: Arial;
            font-size: 12px;
            font-weight: bold;
            padding: 12px 15px;
            text-decoration: none !important;
            text-shadow: 0px 1px 0px #ffffff;
        }

        .button:hover {
            background-color: #f6f6f6;
        }

        .button:active {
            position: relative;
            top: 1px;
        }
        #main_subject{
           margin-left: 40px;
           font-size: 24px;
        }
        .subject_area{
             padding-top: 15px;
           padding-bottom: 10px;
        }
        
.entry {
  position: relative;
  width: 330px;
  height: 200px;
  background: white;
  margin: 15px;
  overflow: hidden;
  float: left;
  box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.15);
}
.entry:hover .makguli_img {
  right: 60px;
  top: -10px;
  -moz-transform: scale(0.9, 0.9);
  -ms-transform: scale(0.9, 0.9);
  -webkit-transform: scale(0.9, 0.9);
  transform: scale(0.9, 0.9);
}
.entry:hover aside {
  left: -50px;
  transition: all 0.75s ease;
  opacity: 0;
}
.entry:hover i {
  left: 90px;
  opacity: 1;
  -moz-transform: scale(0.7, 0.7);
  -ms-transform: scale(0.7, 0.7);
  -webkit-transform: scale(0.7, 0.7);
  transform: scale(0.7, 0.7);
}
.entry aside {
  width: 190px;
  height: 200px;
  padding: 20px 5px 20px 10px;
  z-index: 100;
  position: relative;
  left: 0px;
  transition: all 0.5s ease;
  line-height: 200%
}
.entry strong {
  font-family: "effra";
  text-transform: uppercase;
  font-weight: bold;
  font-size: 16px;
  line-height: 14px;
  color: #333;
}
.entry p {
  font-family: "Arial";
  font-size: 13px;
  margin-top: 10px;
  color: #283e4a;
  position:absolute;
  top:70px;
}
.entry a {
  display: block;
  width: inherit;
  height: inherit;
}

.entry a:hover {
  cursor: pointer;
}
.entry a .makguli_img {
  position: absolute;
  top: 0px;
  right: -35px;
  transition: all 0.5s ease;
}
.div_pagenation{
     border : none;
     text-align: center;
 }
    </style>
</head>

<body>
<jsp:include page="../menubar.jsp" flush="true" />
	<div class="topsubmenu">
        <button type="button" class="button" onclick="location.href='getMakguliList.ma?makguli_area=<%=makguli_area%>&keyword=like';" >좋아요</button>&nbsp;
        <button type="button" class="button" onclick="location.href='getMakguliList.ma?makguli_area=<%=makguli_area%>&keyword=read';" >조회수</button>&nbsp;
        <button type="button" class="button" onclick="location.href='getMakguliList.ma?makguli_area=<%=makguli_area%>&keyword=abc';" >가나다순</button>&nbsp;
    </div>


    <section class="container-fluid all_body_content">
    <h1> <blockquote><strong><%=makguli_area %>지역 막걸리</strong></blockquote></h1>

        <div class="row index-content">
<%
		for(int i=0; i<makguliList.size(); i++){
%>
    		<article class="entry" onclick="location.href='getMakguli.ma?makguli_num=<%=makguliList.get(i).getMakguli_num()%>&page=<%=nowPage%>&keyword=<%=keyword%>';">
			  <a>
			    <aside>
			      <strong><%=makguliList.get(i).getMakguli_name()%></strong>
			   		<p><%=makguliList.get(i).getMakguli_make()%></p>
			      <br/><span style="position:absolute; top:125px;"><img src="./resources/image/like.png" width="25" height="25" />&nbsp;&nbsp;<%=makguliList.get(i).getMakguli_likecount()%></span>
			      <br/><span style="position:absolute; top:151px;"><img src="./resources/image/view.png" width="25" height="25" />&nbsp;&nbsp;<%=makguliList.get(i).getMakguli_readcount()%></span>
			    </aside>
			    <img class="makguli_img" src="/altaltal/image/makguli/<%=makguliList.get(i).getMakguli_picture()%>" width="180" height='220' />
			  </a>
			</article>
			
<%
		}
%>
   		</div>

       <div class="row div_pagenation">
                <div class="col-xs-12">
                    <ul class="pagination">
                        
                        <%if(nowPage<=1){ %>
                        <li class="page-item">
                            <a aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                            </li>
                        <%}else{ %>
                        <li class="page-item">
                        	<a href="getMakguliList.ma?makguli_area=<%=makguli_area %>&page=<%=nowPage-1 %>&keyword=<%=keyword %>" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                            </li>
                        <%} %>
                        <%for(int a=startPage;a<=endPage;a++){
							if(a==nowPage){%>
                            <li class="page-item">
                                <a class="page-link" ><%=a %></a>
                            </li>
                        <%}else{ %>
                            <li class="page-item">
                                <a class="page-link" href="getMakguliList.ma?makguli_area=<%=makguli_area %>&page=<%=a %>&keyword=<%=keyword %>" ><%=a %></a>
                            </li>
                           		<%} %>
						<%} %>
						
						<%if(nowPage>=maxPage){ %>
                            <li class="page-item">
                                <a aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                         <%}else{ %>
                            <li class="page-item">
                                <a href="getMakguliList.ma?makguli_area=<%=makguli_area %>&page=<%=nowPage+1 %>&keyword=<%=keyword %>" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                          <%} %>
                    </ul>
                    </div>
                </div> 
    </section>

<jsp:include page="../footer.jsp" flush="true" />
</body>

</html>