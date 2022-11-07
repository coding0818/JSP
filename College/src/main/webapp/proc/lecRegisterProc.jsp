<%@page import="java.sql.ResultSet"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dbcp.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String lecNo = request.getParameter("lecNo");
	String lecName = request.getParameter("lecName");
	String lecCredit = request.getParameter("lecCredit");
	String lecTime = request.getParameter("lecTime");
	String lecClass = request.getParameter("lecClass");
		
	try{
		Connection conn = DBCP.getConnection();
		String sql = "insert into `lecture` set ";
			   sql += "`lecNo`=?, ";
			   sql += "`lecName`=?, ";
			   sql += "`lecCredit`=?, ";
			   sql += "`lecTime`=?, ";
			   sql += "`lecClass`=?";
					  
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, lecNo);
		psmt.setString(2, lecName);
		psmt.setString(3, lecCredit);
		psmt.setString(4, lecTime);
		psmt.setString(5, lecClass);
		
		psmt.executeUpdate();
		
		
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	JsonObject json = new JsonObject();
	json.addProperty("lecNo", lecNo);
	json.addProperty("lecName", lecName);
	json.addProperty("lecCredit", lecCredit);
	json.addProperty("lecTime", lecTime);
	json.addProperty("lecClass", lecClass);
	
	out.print(json);
%>