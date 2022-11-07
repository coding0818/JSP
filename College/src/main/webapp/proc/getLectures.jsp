<%@page import="com.google.gson.Gson"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="dbcp.DBCP"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.lectureBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<lectureBean> lectures = new ArrayList<>();
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery("select * from `lecture`");
		
		while(rs.next()){
			lectureBean lecture = new lectureBean();
			lecture.setLecNo(rs.getInt(1));
			lecture.setLecName(rs.getString(2));
			lecture.setLecCredit(rs.getInt(3));
			lecture.setLecTime(rs.getInt(4));
			lecture.setLecClass(rs.getString(5));
			
			lectures.add(lecture);
		}
		rs.close();
		stmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}

	Gson gson = new Gson();
	String jsonData = gson.toJson(lectures);
	out.print(jsonData);

%>

