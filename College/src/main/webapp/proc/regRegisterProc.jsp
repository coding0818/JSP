<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="dbcp.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.lectureBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String regStdNo = request.getParameter("regStdNo");
	String stdName = request.getParameter("stdName");
	String regLecNo = request.getParameter("regLecNo");
	String result = "";
	
	try{
		Connection conn = DBCP.getConnection();
		String sql = "insert into `register` set `regStdNo`=?, `regLecNo`=?";
		String sql1 = "select `lecName` from `lecture` where `lecNo`=?";
		
		PreparedStatement psmt = conn.prepareStatement(sql);
		PreparedStatement psmt1 = conn.prepareStatement(sql1);
		psmt.setString(1, regStdNo);
		psmt.setString(2, regLecNo);
		psmt1.setString(1, regLecNo);
		
		psmt.executeUpdate();
		ResultSet rs = psmt1.executeQuery();
		
		if(rs.next()){
			result = rs.getString(1);
		}
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	JsonObject json = new JsonObject();
	json.addProperty("regStdNo", regStdNo);
	json.addProperty("stdName", stdName);
	json.addProperty("regLecNo", regLecNo);
	json.addProperty("result", result);
	
	out.print(json);
%>