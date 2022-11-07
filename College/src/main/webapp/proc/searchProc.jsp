<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.registerBean"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dbcp.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String regStdNo = request.getParameter("regStdNo");
	
	List<registerBean> registers = new ArrayList<>();

	try{
		Connection conn = DBCP.getConnection();
		String sql = "SELECT a.*, b.`stdName`, c.`lecName` from `register` AS a ";
		   sql += "JOIN `student` AS b ON a.regStdNo = b.stdNo ";
		   sql += "JOIN `lecture` AS c ON a.regLecNo = c.lecNo ";
		   sql += "WHERE a.regStdNo=?";
		
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, regStdNo);
		
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			registerBean register = new registerBean();
			register.setRegStdNo(rs.getString(1));
			register.setRegLecNo(rs.getString(2));
			register.setRegMidScore(rs.getInt(3));
			register.setRegFinalScore(rs.getInt(4));
			register.setRegTotalScore(rs.getInt(5));
			register.setRegGrade(rs.getString(6));
			register.setStdName(rs.getString(7));
			register.setLecName(rs.getString(8));
			
			registers.add(register);
		}
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	Gson gson = new Gson();
	String jsonData = gson.toJson(registers);
	out.print(jsonData);
%>