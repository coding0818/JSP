<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>user:::list</title>
	</head>
	<body>
		<h3>user 목록</h3>
		<a href="../1_JDBCTest.jsp">처음으로</a>
		<a href="./register.jsp">user 등록</a>
		
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>나이</th>
				<th>관리</th>
			</tr>
			
			<tr>
				<td>a101</td>
				<td>홍길동</td>
				<td>010-1234-1111</td>
				<td>27</td>
				<td>
					<a href="#">수정</a>
					<a href="#">삭제</a>
				</td>
			</tr>
			
		</table>
	</body>
</html>