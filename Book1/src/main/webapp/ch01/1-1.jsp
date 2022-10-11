<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>page 지시어-import 속성</title>
		<!-- 
			날짜 : 2022/10/11
			이름 : 박가영
			내용 : 예제1-1 실습
		 -->
	</head>
	<body>
		<%
			Date today = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String todayStr = dateFormat.format(today);
			out.println("오늘 날짜 : "+todayStr);
		%>
	</body>
</html>