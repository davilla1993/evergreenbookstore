<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="css/style.css"/>
	<title>My Orders History - Evergreen Bookstore</title>
</head>
<body>

	<jsp:directive.include file="header.jsp" />
	
	<div>
		<h1 class="pageheading">My Orders History</h1>
	</div>
	
	<div align="center">
	
		<c:if test="${fn:length(listOrders) == 0}">
			<h3>You have not placed any order.</h3>
		</c:if>	
		
	</div>
	
	<c:if test="${fn:length(listOrders) > 0}">
		
		<div align="center">
		
			<table class="table-list">
			
				<tr>
	<!-- 				<th>Index</th> -->
					<th>Index</th>
					<th>Order ID</th>
					<th>Qantity</th>
					<th>Total Amount</th>
					<th>Order Date</th>
					<th>Status</th>
					<th>Actions</th>
					
				</tr>
				<c:forEach var="order" items="${listOrders}" varStatus="status">
				<tr>
		 			<td>${status.index + 1}</td>
					<td>${order.orderId}</td>
					<td>${order.bookCopies}</td>
					<td><fmt:formatNumber groupingUsed="false" value="${order.total}" type="currency" currencySymbol="$"/></td>
					<td>${order.orderDate}</td>	
					<td>${order.status}</td>
					<td>
						<a href="show_order_detail?id=${order.orderId}">Views Details</a>
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		
	</c:if>	
	
	<jsp:directive.include file="footer.jsp" />
	
</body>

</html>