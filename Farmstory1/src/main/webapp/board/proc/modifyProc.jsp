<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");

	ArticleDAO.getInstance().updateArticle(title, content, no);

	response.sendRedirect("/Farmstory1/board/view.jsp?group="+group+"&cate="+cate+"&pg="+pg+"&no="+no);
%>