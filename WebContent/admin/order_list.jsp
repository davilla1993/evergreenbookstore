<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="../css/style.css"/>
	<script type="text/javascript" src="../js/jquery-3.4.0.min.js"></script>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
	<title>Manage orders - Evergreen Bookstore Admin</title>
</head>
<body>

	<jsp:directive.include file="header.jsp" />
	
	<div>
		<h1 class="pageheading">Orders Management</h1>
	</div>
	
	<c:if test="${message != null}">
	
		<div align="center">
			<h4 class="message">${message}</h4>
		</div>
		
	</c:if>
	
	<div align="center">
		<table class="table-list">
			<tr>
<!-- 				<th>Index</th> -->
				<th>Index</th>
				<th>Order ID</th>
				<th>Ordered by</th>
				<th>Book Copies</th>
				<th>Total</th>
				<th>Payment method</th>
				<th>Status</th>
				<th>Order Date</th>
				<th>Actions</th>
				
			</tr>
			<c:forEach var="order" items="${listOrder}" varStatus="status">
			<tr>
	 			<td>${status.index + 1}</td>
				<td>${order.orderId}</td>
				<td>${order.customer.fullname}</td>
				<td>${order.bookCopies}</td>
				<td>$ ${order.total}</td>
				<td>${order.paymentMethod}</td>
				<td>${order.status}</td>
				<td>${order.orderDate}</td>
		
				<td>
					<a href="view_order?id=${order.orderId}">Details</a>
					<a href="edit_order?id=${order.orderId}">Edit</a>
					<a href="javascript:void(0);" class="deleteLink" id="${order.orderId}">Delete</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	
	<div align="center">
		
	</div>
	
	<jsp:directive.include file="footer.jsp" />
	
</body>

	<script>
	$(document).ready(function(){
		$(".deleteLink").each(function(){
			$(this).on("click", function(){
				orderId = $(this).attr("id");
				if(confirm('Are you sure you want to delete this order ?')){
					window.location = "delete_order?id=" + orderId;
				}
			});
		});
	});
	</script>
</html>