<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/style.css"/>
<script type="text/javascript" src="js/jquery-3.4.0.min.js"></script>
<title>Payment Receipt- Online Bookstore</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
		<h2><b>You have made payment successfully. Thank you for purchasing !!</b></h2>
		<h2>Your Payment Receipt:</h2>
		
		<table class="table-list">
			<h2>Seller Information:</h2>
			
			<tr>
				<td><b>E-mail:</b></td>
				<td>sales@evergreenbooks.com</td>
			</tr>
			<tr>
				<td><b>Phone:</b></td>
				<td>+228 91-55-48-74</td>
			</tr>
		</table>
		
		<h2>Buyer Information:</h2>
		<table class="table-list">
			<tr>
				<td><b>Firstname:</b></td>
				<td>${payer.firstName}</td>
			</tr>
			<tr>
				<td><b>Lastname:</b></td>
				<td>${payer.lastName}</td>
			</tr>
			<tr>
				<td><b>E-mail:</b></td>
				<td>${payer.email}</td>
			</tr>
		</table>
		
		<h2>Order Details:</h2>
		<table>
			<tr>
				<td><b>Order ID:</b></td>
				<td>${orderId}</td>
			</tr>
			<tr>
				<td><b>Ordered by:</b></td>
				<td>${loggedCustomer.fullname}</td>
			</tr>
			<tr>
				<td><b>Transaction Description:</b></td>
				<td>${transaction.description}</td>
			</tr>
			<tr><td colspan="2"><b>Items:</b></td></tr>
			<tr>
				<td colspan="2">
					<table class="table-list">
						<tr>
							<th>No.</th>
							<th>Name</th>
							<th>Quantity</th>
							<th>Price</th>
							<th>Subtotal</th>
						</tr>
						<c:forEach items="${transaction.itemList.items}" var="item" varStatus="var">
							<tr>
								<td>${var.index+1}</td>
								<td>${item.name}</td>
								<td>${item.quantity}</td>
								<fmt:setLocale value="en_US" scope="session"/>
								<td><fmt:formatNumber groupingUsed="false" value="${item.price}" type="currency" currencySymbol="$"/></td>
								<fmt:setLocale value="en_US" scope="session"/>
								<td><fmt:formatNumber groupingUsed="false" value="${item.price * item.quantity}" type="currency" currencySymbol="$"/></td>		
							</tr>
						</c:forEach>
						<tr>
							<td colspan="5" align="right">
								<fmt:setLocale value="en_US" scope="session"/>
								<p>Subtotal: <fmt:formatNumber groupingUsed="false" value="${transaction.amount.details.subtotal}" type="currency" currencySymbol="$"/></p>
								<p>Tax: <fmt:formatNumber groupingUsed="false" value="${transaction.amount.details.tax}" type="currency" currencySymbol="$"/></p>
								<p>Shipping Fee: <fmt:formatNumber groupingUsed="false" value="${transaction.amount.details.shipping}" type="currency" currencySymbol="$"/></p>
								<p>TOTAL: <fmt:formatNumber groupingUsed="false" value="${transaction.amount.total}" type="currency" currencySymbol="$"/></p>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div>
			<br/>
			<input type="button" value="Print Receipt" onclick="javascript:showPrintReceiptPopup();"/>
		</div>
	</div>

	<jsp:directive.include file="footer.jsp" />
	
	<script type="text/javascript">
		function showPrintReceiptPopup(){
			var width = 600;
			var height = 250;
			var left = (screen.width - width) / 2;
			var top = (screen.width - width) / 2;
			
			window.open('frontend/print_receipt.jsp', ' blank', 'width=' + width + ', height=' + height + ', top=' + top + ', left=' + left);
		}
	</script>
	
</body>
</html>