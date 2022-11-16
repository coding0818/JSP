<%@page import="kr.co.farmstory1.bean.UserBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	UserBean sessUser = (UserBean) session.getAttribute("sessUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>팜스토리::메인</title>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css"/>
    <link rel="stylesheet" href="/Farmstory1/css/style.css">
    <link rel="stylesheet" href="/Farmstory1/user/css/style.css">
    <link rel="stylesheet" href="/Farmstory1/board/css/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
	<script>
        $(function(){

            $('#tabs').tabs();
        });
    </script>
</head>
<body>
    <div id="wrapper">
        <header>
          <a href="/Farmstory1/" class="logo">
            <img src="/Farmstory1/img/logo.png" alt="instoduction">  
          </a>
          <p>
            <a href="/Farmstory1/">HOME |</a>
            <% if(sessUser == null){ %>
            <a href="/Farmstory1/user/login.jsp">로그인 |</a>
            <a href="/Farmstory1/user/terms.jsp">회원가입 |</a>
            <% }else{ %>
            <a href="/Farmstory1/user/proc/logout.jsp">로그아웃 |</a>
            <% } %>
            <a href="#">고객센터</a>
          </p>
          <img src="/Farmstory1/img/head_txt_img.png" alt="3만원이상무료배송">
          <ul class="gnb">
              <li><a href="/Farmstory1/instroduction/hello.jsp"></a></li>
              <li><a href="/Farmstory1/board/list.jsp?group=market&cate=market"><img src="/Farmstory1/img/head_menu_badge.png" alt></a></li>
              <li><a href="/Farmstory1/board/list.jsp?group=story&cate=story"></a></li>
              <li><a href="/Farmstory1/board/list.jsp?group=event&cate=event"></a></li>
              <li><a href="/Farmstory1/board/list.jsp?group=community&cate=notice"></a></li>
          </ul>
        </header>
       