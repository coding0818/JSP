<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>book::register</title>
	</head>
	<body>
		<h4>도서목록</h4>
		<a href="/Bookstore2/index.jsp">처음으로</a>
		<a href="/Bookstore2/book/list.do">도서목록</a>
		<form action="/Bookstore2/book/register.do" method="post">
			<table border="1">
				<tr>
					<td>도서번호</td>
					<td><input type="number" name="bookId"/></td>
				</tr>
				<tr>
					<td>도서명</td>
					<td><input type="text" name="bookName"/></td>
				</tr>
				<tr>
					<td>출판사</td>
					<td><input type="text" name="publisher"/></td>
				</tr>
				<tr>
					<td>가격</td>
					<td><input type="number" name="price"/></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="등록"/>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>