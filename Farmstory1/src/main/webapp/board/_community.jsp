<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cate = request.getParameter("cate");
%>
<div id="sub">
  <div>
    <img src="../img/sub_top_tit5.png" alt>
  </div>
  <section class="cate5">
    <aside>
      <img src="../img/sub_aside_cate5_tit.png" alt="">
      <ul>
        <li class="<%= cate.equals("notice") ? "on":"off"%>"><a href="./list.jsp?group=community&cate=notice">1</a></li>
        <li class="<%= cate.equals("today") ? "on":"off"%>"><a href="./list.jsp?group=community&cate=today">1</a></li>
        <li class="<%= cate.equals("chef") ? "on":"off"%>"><a href="./list.jsp?group=community&cate=chef">1</a></li>
        <li class="<%= cate.equals("fna") ? "on":"off"%>"><a href="./list.jsp?group=community&cate=fna">1</a></li>
        <li class="<%= cate.equals("qna") ? "on":"off"%>"><a href="./list.jsp?group=community&cate=qna">1</a></li>
      </ul>
    </aside>
    <article>
      <nav>
        <img src="../img/sub_nav_tit_cate5_<%= cate %>.png" alt="찾아오시는길">
        <p>
          HOME > 커뮤니티 > 
          <% if(cate.equals("notice")){ %>
         	<span>공지사항</span>
          <% }else if(cate.equals("today")){ %>
          	<span>오늘의 식단</span>
          <% }else if(cate.equals("chef")){ %>
          	<span>나도요리사</span>
          <% }else if(cate.equals("fna")){ %>
          	<span>1:1고객문의</span>
          <% }else if(cate.equals("qna")){ %>
          	<span>자주묻는질문</span>
          <% } %>
        </p>
      </nav>