<%@page import="java.sql.PreparedStatement"%>
<%@page import="dbcp.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.google.gson.JsonObject"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String stdNo = request.getParameter("stdNo");
	String stdName = request.getParameter("stdName");
	String stdHp = request.getParameter("stdHp");
	String stdYear = request.getParameter("stdYear");
	String stdAddress = request.getParameter("stdAddress");

	try{
		Connection conn = DBCP.getConnection();
		String sql = "insert into `student` set ";
			   sql += "`stdNo`=?, ";
			   sql += "`stdName`=?, ";
			   sql += "`stdHp`=?, ";
			   sql += "`stdYear`=?, ";
			   sql += "`stdAddress`=?";
					  
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, stdNo);
		psmt.setString(2, stdName);
		psmt.setString(3, stdHp);
		psmt.setString(4, stdYear);
		psmt.setString(5, stdAddress);
		
		psmt.executeUpdate();
		
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	JsonObject json = new JsonObject();
	json.addProperty("stdNo", stdNo);
	json.addProperty("stdName", stdName);
	json.addProperty("stdHp", stdHp);
	json.addProperty("stdYear", stdYear);
	json.addProperty("stdAddress", stdAddress);
	
	out.print(json);
	
%>