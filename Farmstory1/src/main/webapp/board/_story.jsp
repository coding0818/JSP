<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cate = request.getParameter("cate");
%>
<div id="sub">
  <div>
    <img src="../img/sub_top_tit3.png" alt>
  </div>
  <section class="cate3">
    <aside>
      <img src="../img/sub_aside_cate3_tit.png" alt="">
      <ul>
        <li class="<%= cate.equals("story") ? "on":"off" %>"><a href="./list.jsp?group=story&cate=story">1</a></li>
        <li class="<%= cate.equals("grow") ? "on":"off" %>"><a href="./list.jsp?group=story&cate=grow">2</a></li>
        <li class="<%= cate.equals("school") ? "on":"off" %>"><a href="./list.jsp?group=story&cate=school">2</a></li>
      </ul>
    </aside>
    <article>
      <nav>
        <img src="../img/sub_nav_tit_cate3_<%= cate %>.png" alt="찾아오시는길">
        <p>
          HOME > 농작물이야기 > 
          <% switch(cate){
	         case "story":
        	  out.print("<span>농작물이야기</span>");
        	  break;
	         case "grow":
        	  out.print("<span>텃밭가꾸기</span>");
        	  break;
	         case "school":
        	  out.print("<span>귀농학교</span>");
        	  break;
          } %>
        </p>
      </nav>