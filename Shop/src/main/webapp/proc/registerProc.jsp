<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String orderId = request.getParameter("orderId");
	String orderProduct = request.getParameter("orderNo");
	String orderCount = request.getParameter("orderCount");
	
	int result = 0;

	try{
		Connection conn = DBCP.getConnection();
		String sql = "insert into `order`";		
			   sql += "(`orderId`,`orderProduct`,`orderCount`,`orderDate`)";
			   sql += "values (?,?,?,NOW())";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, orderId);
		psmt.setString(2, orderProduct);
		psmt.setString(3, orderCount);
		
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
