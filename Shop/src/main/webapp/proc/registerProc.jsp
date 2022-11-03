<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String prodOrderer = request.getParameter("prodOrderer");
	String prodNo = request.getParameter("prodNo");
	String prodCount = request.getParameter("prodCount");
	
	int result = 0;

	try{
		Connection conn = DBCP.getConnection();
		String sql = "insert into `order` ";		
			   sql += "(`orderId`,`orderProduct`,`orderCount`,`orderDate`) ";
			   sql += "values (?,?,?,NOW())";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, prodOrderer);
		psmt.setString(2, prodNo);
		psmt.setString(3, prodCount);
		
		result = psmt.executeUpdate();
		
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
