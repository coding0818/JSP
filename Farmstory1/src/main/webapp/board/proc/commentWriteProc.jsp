<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@page import="kr.co.farmstory1.bean.ArticleBean"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	String no  = request.getParameter("no");
	String content = request.getParameter("content");
	String regip = request.getRemoteAddr();
	
	ArticleBean comment = new ArticleBean();
	comment.setParent(no);
	comment.setContent(content);
	comment.setUid(uid);
	comment.setRegip(regip);
	
	ArticleBean article = ArticleDAO.getInstance().insertComment(comment);
	JsonObject json = new JsonObject();
	json.addProperty("result", 1);
	json.addProperty("no", article.getNo());
	json.addProperty("parent", article.getParent());
	json.addProperty("nick", article.getNick());
	json.addProperty("date", article.getRdate());
	json.addProperty("content", article.getContent());
	
	String jsonData = json.toString();
	out.print(jsonData);

%>