<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>1_스크립트릿</title>
		<!-- 
			날짜 : 2022/10/04
			이름 : 박가영
			내용 : JSP 스크립트릿 실습하기
		 -->
	</head>
	<body>
		<h3>스크립트 요소</h3>
		
		<h4>스크립트릿(Scriptlet)</h4>
		<%
			// 스크립트릿(프로그램 코드 영역)	
			int var1 = 1;
			boolean var2 = true;
			double var3 = 3.14;
			String var4 = "Hello";
		
			// JSP 출력객체로 HTML 출력
			out.println("<p> var1 : "+var1+"</p>");
			out.println("<p> var1 : "+var2+"</p>");
		%>
		
		<h4>표현식(Expression)</h4>
		
		
	</body>
</html>