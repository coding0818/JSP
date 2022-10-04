<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>3_반복문</title>
		<%--
			날짜 : 2022/10/04
			이름 : 박가영
			내용 : JSP 조건문 실습하기
		
		 --%>
	</head>
	<body>
		<h3>반복문</h3>
		
		<h4>for</h4>
		<%
			for(int i=1; i<=3; i++){
				out.println("<p>i : "+i+"</p>");
			}
		%>
		
		<% for(int k=1; k<=3; k++){ %>
			<p>k : <%= k %></p>
		<% } %>
		
		<h4>while</h4>
		<%
			int j=1;
			while(j<=3){
		%>
			<p>j : <%= j %></p>
		<% 
				j++;
			} 
		%>		
		
		<h4>구구단</h4>
		<table border="1">
			<tr>
				<th>2단</th>
				<th>3단</th>
				<th>4단</th>
				<th>5단</th>
				<th>6단</th>
				<th>7단</th>
				<th>8단</th>
				<th>9단</th>
			</tr>
			
			<tr>
				<td>2 x 1 = 2</td>
				<td>3 x 1 = 2</td>
				<td>4 x 1 = 2</td>
				<td>5 x 1 = 2</td>
				<td>6 x 1 = 2</td>
				<td>7 x 1 = 2</td>
				<td>8 x 1 = 2</td>
				<td>9 x 1 = 2</td>
			</tr>
			<tr>
				<td>2 x 2 = 4</td>
				<td>3 x 2 = 6</td>
				<td>4 x 2 = 8</td>
				<td>5 x 2 = 10</td>
				<td>6 x 2 = 12</td>
				<td>7 x 2 = 14</td>
				<td>8 x 2 = 16</td>
				<td>9 x 2 = 18</td>
			</tr>
		</table>
		
		<table border="1">
		<tr>
			<th>2단</th>
			<th>3단</th>
			<th>4단</th>
			<th>5단</th>
			<th>6단</th>
			<th>7단</th>
			<th>8단</th>
			<th>9단</th>
		</tr>
		
		<% for(int x=2; x<=9; x++){ %>
		<tr>
			<% for(int y=1; y<=9; y++){
				<td> <%= y %></td>
			<% } %> 
		</tr>
		<% } %>
		
		</table>
		
		
	</body>
</html>