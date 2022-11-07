<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="dbcp.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="bean.studentBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<studentBean> students = new ArrayList<>();
	
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery("select * from `student`");
		
		while(rs.next()){
			studentBean student = new studentBean();
			student.setStdNo(rs.getString(1));
			student.setStdName(rs.getString(2));
			student.setStdHp(rs.getString(3));
			student.setStdYear(rs.getInt(4));
			student.setStdAddress(rs.getString(5));
			
			students.add(student);
		}
		rs.close();
		stmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>학생관리</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
		$(function(){
			
			$(document).on('click', '.btnstdRegister', function(){
				$('section').show();
			});
			
			$(document).on('click', '.btnstdClose', function(){
				$('section').hide();
			});
			
			$(document).on('click', 'input[type=submit]', function(){
				let stdNo = $('input[name=stdNo]').val();
				let stdName = $('input[name=stdName]').val();
				let stdHp = $('input[name=stdHp]').val();
				let stdYear = $('input[name=stdYear]').val();
				let stdAddress = $('input[name=stdAddress]').val();
				
				let jsonData = {
					"stdNo":stdNo,	
					"stdName":stdName,	
					"stdHp":stdHp,	
					"stdYear":stdYear,	
					"stdAddress":stdAddress	
				};
				
				$.ajax({
					url:'/College/proc/stdRegisterProc.jsp',
					method: 'post',
					data:jsonData,
					dataType: 'json',
					success: function(data){
						
						let table = "<tr>";
						table += "<td>"+data.stdNo+"</td>";
						table += "<td>"+data.stdName+"</td>";
						table += "<td>"+data.stdHp+"</td>";
						table += "<td>"+data.stdYear+"</td>";
						table += "<td>"+data.stdAddress+"</td>";
						table += "</tr>";
						
						$('#student').append(table);	
					}
				});
			});
		});
		</script>
	</head>
	<body>
		<h3>학생관리</h3>
		<a href="/College/lecture.jsp">강좌관리</a>
		<a href="/College/register.jsp">수강관리</a>
		<a href="/College/student.jsp">학생관리</a>
		
		<h3>학생목록</h3>
		<button class="btnstdRegister">등록</button>
		<table border="1" id="student">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>학년</th>
				<th>주소</th>
			</tr>
			<% for(studentBean student : students){ %>
			<tr>
				<td><%= student.getStdNo() %></td>
				<td><%= student.getStdName() %></td>
				<td><%= student.getStdHp() %></td>
				<td><%= student.getStdYear() %></td>
				<td><%= student.getStdAddress() %></td>
			</tr>
			<% } %>
		</table>
		<section style="display:none;">
			<h3>학생등록</h3>
			<button class="btnstdClose">닫기</button>
			<table border="1">
				<tr>
					<td>학번</td>
					<td><input type="text" name="stdNo"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="stdName"></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="stdHp"></td>
				</tr>
				<tr>
					<td>학년</td>
					<td><input type="number" name="stdYear"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="stdAddress"></td>
				</tr>
				<tr>
					<td align="right" colspan="2"><input type="submit" value="등록"/></td>
				</tr>
			</table>
		</section>
	</body>
</html>