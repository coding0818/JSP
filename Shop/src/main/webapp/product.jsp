<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="Bean.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	List<ProductBean> products = new ArrayList<>();

	try{
		Connection conn = DBCP.getConnection();
		String sql = "select * from `product`";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		ResultSet rs = psmt.executeQuery();
		while(rs.next()){
			ProductBean pb = new ProductBean();
			
			pb.setProdNo(rs.getInt(1));
			pb.setProdName(rs.getString(2));
			pb.setStock(rs.getInt(3));
			pb.setPrice(rs.getInt(4));
			pb.setCompany(rs.getString(5));
			
			products.add(pb);
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
		<title>Shop::product</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function(){
				
				$(document).on('click', 'button', function(){
					
					let no = $(this).val();
					$('section').empty();
					
					let table = "<h3>주문하기</h3>";
					    table += "<table border='1'>";
					    table += "<tr>";
						table += "<td>상품번호</td>";
						table += "<td><input type='text' name='no' value="+no+" /></td>";
						table += "</tr>";
						table += "<tr>";
						table += "<td>수량</td>";
				        table += "<td><input type='number' name='orderCount'/></td>";
					    table += "</tr>";
					    table += "<tr>";
					    table += "<td>주문자</td>";
					    table += "<td><input type='text' name='orderId'/></td>";
					    table += "</tr>";	
						table += "<tr>";
						table += "<td colspan='2' align='right'><input type='submit' value='주문하기'/></td>";
						table += "</tr>";
						table += "</table>";
					$('section').append(table);
				});
				
				
				$(document).on('click', 'input[type=submit]', function(){	
					
					let orderNo = $('input[name=no]').val();
					let orderCount = $('input[name=orderCount]').val();
					let orderId = $('input[name=orderId]').val();
					
					let jsonData = {
							"orderNo":orderNo,
							"orderCount":orderCount,
							"orderId":orderId
					}
					
					console.log(jsonData);
					
					$.ajax({
						url: './proc/registerProc.jsp',
						method: 'post',
						data: jsonData, 
						dataType: 'json',
						success: function(data){
							if(data.result == 1){
								alert('주문완료!');
							}
						}
					});
				});
			});
		</script>
	</head>
	<body>
		<h3>상품목록</h3>
		<a href="./customer.jsp">고객목록</a>
		<a href="./order.jsp">주문목록</a>
		<a href="./product.jsp">상품목록</a>
		<table border="1">
			<tr>
				<th>상품번호</th>
				<th>상품명</th>
				<th>재고량</th>
				<th>가격</th>
				<th>제조사</th>
				<th>주문</th>
			</tr>
			<% for(ProductBean pb : products){ %>
			<tr>
				<td><%= pb.getProdNo() %></td>
				<td><%= pb.getProdName()%></td>
				<td><%= pb.getStock() %></td>
				<td><%= pb.getPrice() %></td>
				<td><%= pb.getCompany() %></td>
				<td>
					<button value="<%=pb.getProdNo() %>">주문</button>
				</td>
			</tr>
			<% } %>
		</table>
		<section></section>
	</body>
</html>