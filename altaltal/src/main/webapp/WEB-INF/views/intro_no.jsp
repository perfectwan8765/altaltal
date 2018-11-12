<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
   body, html {
     height: 100%;
   }

   div#wrap {
     position: absolute;
     top: 50%;
     left: 50%;
     width: 1200px;
     height: 600px;
     margin: -300px 0 0 -600px;
   }

   #wrap div {
     text-align:center;
     margin: auto;
   }

   div#img {
     width: 450px;
     height: 450px;
     background: url(./resources/image/crying.png);
   }

   .point {
     color: red;
   }
</style>
</head>

<body>
   <div id="wrap">
      <div id="img"></div>
      <div id="content">
         <h1>죄송합니다. 본 사이트는 만 <span class="point">19</span>세 이상만 사용할 수 있습니다</h1>
         <h1>Sorry, this site is only available for people aged <span class="point">19</span> and over</h1>
      </div>
   </div>
</body>
</html>