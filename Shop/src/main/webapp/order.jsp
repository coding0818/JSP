<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Bean.OrderBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<OrderBean> orders = new ArrayList<>();

	try{
		Connection conn = DBCP.getConnection();
		String sql = "select `orderNo`, `name`, `company`, `orderCount`, `orderDate`";
			   sql += "from `order` as a join `customer` as b ON `custId`=`orderId`";
			   sql += "join `product` as c ON `orderProduct`=`prodNo`";
		PreparedStatement psmt = conn.prepareStatement(sql);
		
		ResultSet rs = psmt.executeQuery();
		
		while(rs.next()){
			OrderBean ob = new OrderBean();
			
			ob.setOrderNo(rs.getInt(1));
			ob.setOrderId(rs.getString(2));
			ob.setOrderProduct(rs.getString(3));
			ob.setOrderCount(rs.getString(4));
			ob.setOrderDate(rs.getString(5));
			
			orders.add(ob);
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
		<title>Shop::order</title>
	</head>
	<body>
		<h3>주문목록</h3>
		<a href="./customer.jsp">고객목록</a>
		<a href="./order.jsp">주문목록</a>
		<a href="./product.jsp">상품목록</a>
		<table border="1">
			<tr>
				<th>주문번호</th>
				<th>주문자</th>
				<th>주문상품</th>
				<th>주문수량</th>
				<th>주문일</th>
			</tr>
			<% for(OrderBean ob : orders){ %>
			<tr>
				<td><%= ob.getOrderNo() %></td>
				<td><%= ob.getOrderId() %></td>
				<td><%= ob.getOrderProduct() %></td>
				<td><%= ob.getOrderCount() %></td>
				<td><%= ob.getOrderDate() %></td>
			</tr>
			<% } %>
		</table>
	</body>
</html>