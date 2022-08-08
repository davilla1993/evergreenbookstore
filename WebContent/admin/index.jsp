<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="../css/style.css"/>
	<title>Evergreen Books - Admin</title>
</head>
<body>

	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
		<h1>Administrative Dashboard</h1>
	</div>
	
	<div align="center"><hr width="60%"/>
		<h2>Quick Actions:</h2>
		<b>
		<a href="new_book">New Book</a>&nbsp;
		<a href="user_form.jsp">New User</a>&nbsp;
		<a href="category_form.jsp">New Category</a>&nbsp;
		<a href="new_customer">New Customer</a>&nbsp;
		</b>
	</div>
	
	<div align="center"><hr width="60%"/>
		<h2>Recent Sales:</h2>
		
		<table class="table-list">
			<tr>
<!-- 				<th>Index</th> -->
				<th>Order ID</th>
				<th>Ordered by</th>
				<th>Book Copies</th>
				<th>Total</th>
				<th>Payment method</th>
				<th>Status</th>
				<th>Order Date</th>				
			</tr>
			<c:forEach var="order" items="${listMostRecentSales}" varStatus="status">
			
			<tr>
				<td><a href="view_order?id=${order.orderId}">${order.orderId}</a></td>
				<td>${order.customer.fullname}</td>
				<td>${order.bookCopies}</td>
				<td>$${order.total}</td>
				<td>${order.paymentMethod}</td>
				<td>${order.status}</td>
				<td>${order.orderDate}</td>
			</tr>
			
			</c:forEach>
			
		</table>
	</div>
	
	<div align="center"><hr width="60%"/>
		<h2>Recent Reviews:</h2>
		
		<table class="table-list">
			<tr>
				
				<th>Book</th>
				<th>Rating</th>
				<th>Headline</th>
				<th>Customer</th>
				<th>Review On</th>
			</tr>
			<c:forEach var="review" items="${listRecentReviews}" varStatus="status">
			<tr>
				<td>${review.book.title}</td>
				<td>${review.rating}</td>
				<td><a href="edit_review?id=${review.reviewId}">${review.headline}</a></td>
				<td>${review.customer.fullname}</td>
				<td>${review.reviewTime}</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	
	<div align="center"><hr width="60%"/>
		<h2>Statics:</h2>
		
		Total Users: ${totalUsers}&nbsp;&nbsp;&nbsp;
		Total Books: ${totalBooks}&nbsp;&nbsp;&nbsp;
		Total Customers: ${totalCustomers}&nbsp;&nbsp;&nbsp;
		Total Reviews: ${totalReviews}&nbsp;&nbsp;&nbsp;
		Total Orders: ${totalOrders}
			
	</div>
	
	<jsp:directive.include file="footer.jsp" />
	
</body>
</html>