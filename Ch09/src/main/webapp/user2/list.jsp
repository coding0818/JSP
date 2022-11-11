<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>user:::list2</title>
	</head>
	<body>
		<h3>user2 목록</h3>
		<a href="/Ch09/user2/register.do">user2 등록</a>
		
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>나이</th>
				<th>관리</th>
			</tr>
			
			<c:forEach var="user" items="">
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td>
					<a href="/Ch09/user2/modify.do?uid=">수정</a>
					<a href="/Ch09/user3/delete.do?uid=">삭제</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</body>
</html>