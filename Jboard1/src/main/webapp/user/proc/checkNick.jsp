<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String nick = request.getParameter("nick");

	int result = 0;
	
	try{
		Connection conn = DBCP.getConnection();
		
		PreparedStatement psmt = conn.prepareStatement("select count(`nick`) from `board_user` where `nick`=?");
		psmt.setString(1, nick);
		
		ResultSet rs = psmt.executeQuery();
		
		if(rs.next()){
			result = rs.getInt(1);
		}
		
		rs.close();
		psmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}

	JsonObject json = new JsonObject();
	json.addProperty("result", result);
	
	String jsonData = json.toString();
	out.print(jsonData);
%>