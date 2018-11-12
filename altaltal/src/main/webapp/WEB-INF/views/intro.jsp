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

   #wrap {
     position: absolute;
     top: 50%;
     left: 50%;
     width: 500px;
     height: 300px;
     margin: -150px 0 0 -250px;
   }

   div#wrap div {
     text-align:center;
     margin: auto;
   }

   div#select {
     cursor: pointer;
     width:50%;
   }

   div#yes {
     float: left;
   }

   div#no {
     float: right;
   }

   .point {
     color: red;
   }
</style>
</head>

<body>
   <div id="wrap">
   <div id="intro">
  	  <h1>만 <span class="point">19</span>세 이상인가요?</h1>
   	  <h1>Are you over <span class="point">19</span> years old?</h1>
   </div>
   <div id="select">
      <div id="no" onclick="location.replace('intro_no.in')">
         <h2>아니오</h2>
         <h2>No</h2>
      </div>
      <div id="yes" onclick="location.href='intro_yes.in'">
         <h2>예</h2>
         <h2>Yes</h2>
      </div>
   </div>
   </div>
</body>
</html>

