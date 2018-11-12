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

   div#wrap div {
     text-align:center;
     margin: auto;
   }

   div#img {
     width: 450px;
     height: 450px;
     background: url(./resources/image/intro.png);
   }

   div#select {
     cursor: pointer; 
     width:30%;
   }

   div#kor {
     float: left;
   }

   div#eng {
     float: right;
   }

   #point {
     color: red;
   }
</style>
</head>

<body>
   <div id="wrap">
      <div id="img"></div>
      <div id="select">
      <div id="eng" onclick="location.href='./main.me'">
         <h1>English</h1>
      </div>
      <div id="kor" onclick="location.href='./main.me'">
         <h1>한국어</h1>
      </div>
      </div>
   </div>
</body>
</html>