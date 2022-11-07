<%@page import="java.util.ArrayList"%>
<%@page import="bean.lectureBean"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="dbcp.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>강좌관리</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function(){
				
				$(document).on('click', '.btnRegister', function(){
					$('section').show();
				});
				
				$(document).on('click', '.btnClose', function(){
					$('section').hide();
				});
				
				$(document).on('click', 'input[type=submit]', function(){
					let lecNo = $('input[name=lecNo]').val();
					let lecName = $('input[name=lecName]').val();
					let lecCredit = $('input[name=lecCredit]').val();
					let lecTime = $('input[name=lecTime]').val();
					let lecClass = $('input[name=lecClass]').val();
					
					let jsonData = {
						"lecNo":lecNo,	
						"lecName":lecName,	
						"lecCredit":lecCredit,	
						"lecTime":lecTime,	
						"lecClass":lecClass	
					};
					
					$.ajax({
						url:'/College/proc/lecRegisterProc.jsp',
						method: 'post',
						data:jsonData,
						dataType: 'json',
						success: function(data){
							
							let table = "<tr>";
							table += "<td>"+data.lecNo+"</td>";
							table += "<td>"+data.lecName+"</td>";
							table += "<td>"+data.lecCredit+"</td>";
							table += "<td>"+data.lecTime+"</td>";
							table += "<td>"+data.lecClass+"</td>";
							table += "</tr>";
							
							$('#lecture').append(table);	
							
							
						}
					});
				});
			});
		</script>
	</head>
	<body>
		<h3>강좌관리</h3>
		<a href="/College/lecture.jsp">강좌관리</a>
		<a href="/College/register.jsp">수강관리</a>
		<a href="/College/student.jsp">학생관리</a>
		
		<h3>강좌현황</h3>
		<button class="btnRegister">등록</button>
		<table border="1" id="lecture">
			<tr>
				<th>번호</th>
				<th>강좌명</th>
				<th>학점</th>
				<th>시간</th>
				<th>강의장</th>
			</tr>
			<% for(lectureBean lecture : lectures){ %>
			<tr>
				<td><%= lecture.getLecNo() %></td>
				<td><%= lecture.getLecName() %></td>
				<td><%= lecture.getLecCredit() %></td>
				<td><%= lecture.getLecTime() %></td>
				<td><%= lecture.getLecClass() %></td>
			</tr>
			<% } %>
		</table>
		
		<section style="display:none;">
		<h3>강좌등록</h3>
			<button class="btnClose">닫기</button>
			<table border="1">
				<tr>
					<td>번호</td>
					<td><input type="number" name="lecNo"></td>
				</tr>
				<tr>
					<td>강좌명</td>
					<td><input type="text" name="lecName"></td>
				</tr>
				<tr>
					<td>학점</td>
					<td><input type="number" name="lecCredit"></td>
				</tr>
				<tr>
					<td>시간</td>
					<td><input type="number" name="lecTime"></td>
				</tr>
				<tr>
					<td>강의장</td>
					<td><input type="text" name="lecClass"></td>
				</tr>
				<tr>
					<td align="right" colspan="2"><input type="submit" value="추가"/></td>
				</tr>
			</table>
		</section>
	</body>
</html>