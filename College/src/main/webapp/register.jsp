<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="dbcp.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="bean.registerBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<registerBean> registers = new ArrayList<>();
	try{
		Connection conn = DBCP.getConnection();
		String sql = "SELECT a.*, b.`stdName`, c.`lecName` from `register` AS a ";
			   sql += "JOIN `student` AS b ON a.regStdNo = b.stdNo ";
			   sql += "JOIN `lecture` AS c ON a.regLecNo = c.lecNo;";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
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
		rs.close();
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>수강관리</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
		$(function(){
			
			$(document).on('click', '.btnregRegister', function(){
				$('section').show();
			});
			
			$(document).on('click', '.btnregClose', function(){
				$('section').hide();
			});
			
			$.get('/College/proc/getLectures.jsp',function(data){
				for(let lecture of data){
					let lecName = "<option value='"+lecture.lecNo+"'>";
					    lecName += lecture.lecName;
					    lecName += "</option>";
					$('select[name=lecName]').append(lecName);	
				}
			});
			
			
			$(document).on('click', 'input[type=submit]', function(){
				let regStdNo = $('input[name=regStdNo]').val();
				let stdName = $('input[name=stdName]').val();
				let regLecNo = $('select[name=lecName]').val();
				
				let jsonData = {
					"regStdNo":regStdNo,	
					"stdName":stdName,	
					"regLecNo":regLecNo,
				};
				
				$.ajax({
					url:'/College/proc/regRegisterProc.jsp',
					method: 'post',
					data:jsonData,
					dataType: 'json',
					success: function(data){
						
						let table = "<tr>";
						table += "<td>"+data.regStdNo+"</td>";
						table += "<td>"+data.stdName+"</td>";
						table += "<td>"+data.result+"</td>";
						table += "<td>"+data.regLecNo+"</td>";
						table += "<td>-</td>";
						table += "<td>-</td>";
						table += "<td>-</td>";
						table += "<td>-</td>";
						table += "</tr>";
						
						$('#register').append(table);	
					}
				});
			});
			
			$(document).on('click', '.btnsearch', function(){
				
				$('#register .row').remove();
				let regStdNo = $('input[name=search]').val();
				
				let jsonData = {"regStdNo":regStdNo};
				
				//console.log(jsonData);
				
				$.ajax({
					url:'/College/proc/searchProc.jsp',
					method: 'get',
					data:jsonData,
					dataType: 'json',
					success: function(data){
						
						console.log(data);
						
						for(let register of data){
							let table = "<tr class=row>";
							table += "<td>"+register.regStdNo+"</td>";
							table += "<td>"+register.stdName+"</td>";
							table += "<td>"+register.lecName+"</td>";
							table += "<td>"+register.regLecNo+"</td>";
							table += "<td>"+register.regMidScore+"</td>";
							table += "<td>"+register.regFinalScore+"</td>";
							table += "<td>"+register.regTotalScore+"</td>";
							table += "<td>"+register.regGrade+"</td>";
							table += "</tr>";
							
							$('#register').append(table);
						}
							
					}
				});
				
			});
		});
		</script>
	</head>
	<body>
		<h3>수강관리</h3>
		<a href="/College/lecture.jsp">강좌관리</a>
		<a href="/College/register.jsp">수강관리</a>
		<a href="/College/student.jsp">학생관리</a>
		
		<h3>수강현황</h3>
		<input type="text" name="search" placeholder="학번입력"/>
		<button class="btnsearch">검색</button>
		<button class="btnregRegister">수강신청</button>
		<table border="1" id="register">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>강좌명</th>
				<th>강좌코드</th>
				<th>중간시험</th>
				<th>기말시험</th>
				<th>총점</th>
				<th>등급</th>
			</tr>
			<% for(registerBean register : registers){ %>
			<tr class="row">
				<td><%= register.getRegStdNo() %></td>
				<td><%= register.getStdName() %></td>
				<td><%= register.getLecName() %></td>
				<td><%= register.getRegLecNo() %></td>
				<td><%= register.getRegMidScore() %></td>
				<td><%= register.getRegFinalScore() %></td>
				<td><%= register.getRegTotalScore() %></td>
				<td><%= register.getRegGrade() %></td>
			</tr>
			<% } %>
		</table>
		<section style="display:none;">
			<h3>수강신청</h3>
			<button class="btnregClose">닫기</button>
			<table border="1">
				<tr>
					<td>학번</td>
					<td><input type="text" name="regStdNo"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="stdName"></td>
				</tr>
				<tr>
					<td>신청강좌</td>
					<td>
						<select name="lecName">
							<option>강좌선택</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right" colspan="2"><input type="submit" value="신청"/></td>
				</tr>
			</table>
		</section>
	</body>
</html>