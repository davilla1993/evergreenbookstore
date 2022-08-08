<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="css/style.css"/>
	<title>My Order Details - Evergreen Bookstore</title>
</head>
<body>

	<jsp:directive.include file="header.jsp" />
	
	<div>
		<h1 class="pageheading"> Your Order ID: ${order.orderId}</h1>
	</div>
	
	<div align="center" class="red">
	
		<c:if test="${order == null}">
			<h2>Sorry, you are not authorized to view this order</h2>
		</c:if>
		 
	</div>
		
	<c:if test="${order != null}">
			
		<div align="center">	
		
		<h2>Order Overview</h2>	
		
		<table class="table-list">
			<tr>
				<td><b>Ordered By:</b></td>
				<td>${order.customer.fullname}</td>
			</tr>
			
			<tr>
				<td><b>Order Status:</b></td>
				<td>${order.status}</td>
			</tr>
			<tr>
				<td><b>Order Date:</b></td>
				<td>${order.orderDate}</td>
			</tr>
				<tr>
				<td><b>Payment Method:</b></td>
				<td>${order.paymentMethod}</td>
			</tr>
			<tr>
				<td><b>Book Copies:</b></td>
				<td>${order.bookCopies}</td>
			</tr>
			<tr>
				<td><b>Total Amount:</b></td>
				<td><fmt:formatNumber groupingUsed="false" value="${order.total}" type="currency" currencySymbol="$"/></td>
			</tr>
		</table>
		
		<h2>Recipient Information:</h2>
		<table class="table-list">
		
			<tr>
				<td><b>Firstname:</b></td>
				<td>${order.firstname}</td>
			</tr>
			<tr>
				<td><b>Lastname:</b></td>
				<td>${order.lastname}</td>
			</tr>
			<tr>
				<td><b>Phone:</b></td>
				<td>${order.phone}</td>
			</tr>
		
			<tr>
				<td><b>Address Line1:</b></td>
				<td>${order.addressLine1}</td>
			</tr>
			<tr>
				<td><b>Address Line2:</b></td>
				<td>${order.addressLine2}</td>
			</tr><tr>
				<td><b>City:</b></td>
				<td>${order.city}</td>
			</tr><tr>
				<td><b>State:</b></td>
				<td>${order.state}</td>
			</tr>
			<tr>
				<td><b>Country:</b></td>
				<td>${order.countryName}</td>
			</tr>
			<tr>
				<td><b>Zip code:</b></td>
				<td>${order.zipcode}</td>
			</tr>
			
			
		</table>
	</div>
	
	<div align="center">
		<h2>Ordered Books:</h2>
		<table border="1">
			<tr>
				<th>Index</th>
				<th colspan="2">Book</th>
				<th>Author</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>Subtotal</th>
			</tr>
			<c:forEach items="${order.orderDetails}" var="orderDetail" varStatus="status">
			<tr>
				<td>${status.index + 1}</td>
				<td><img src="data:image/jpg;base64,${orderDetail.book.base64Image}" class="image-cart"/></td>
				<td>${orderDetail.book.title}</td>
				<td>${orderDetail.book.author}</td>
				<td><fmt:formatNumber groupingUsed="false" value="${orderDetail.book.price}" type="currency" currencySymbol="$"/></td>
				<td>${orderDetail.quantity}</td>
				<td><fmt:formatNumber groupingUsed="false" value="${orderDetail.subtotal}" type="currency" currencySymbol="$"/></td>
				
			</tr>
			</c:forEach>
			<tr>
				<td colspan="7" align="right">
					<p>Subtotal: $${order.subtotal}</p>
					<p>Tax: <fmt:formatNumber groupingUsed="false" type="currency" value="${order.tax}" currencySymbol="$" /></p>
					<p>Shipping Fee: <fmt:formatNumber groupingUsed="false" type="currency" value="${order.shippingFee}" currencySymbol="$" /></p>
					<p>TOTAL: <fmt:formatNumber groupingUsed="false" type="currency" value="${order.total}" currencySymbol="$"/></p>
				</td>
				
			</tr>
		</table>
	</div>
	
	</c:if>
	
	<jsp:directive.include file="footer.jsp" />
	
</body>

</html>