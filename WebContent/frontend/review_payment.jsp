<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/style.css"/>
<script type="text/javascript" src="js/jquery-3.4.0.min.js"></script>
<title>Review Payment - Online Bookstore</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
		<h3><i>Please carefully  review the following information before making payment</i></h3>
		<h2>Payer Information:</h2>
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
		<h2>Recipient Information:</h2>
		<table class="table-list">
			<tr>
				<td><b>Recipient Name:</b></td>
				<td>${recipient.recipientName}</td>
			</tr>
			<tr>
				<td><b>Address Line 1:</b></td>
				<td>${recipient.line1}</td>
			</tr>
			<tr>
				<td><b>Address Line 2:</b></td>
				<td>${recipient.line2}</td>
			</tr>
			<tr>
				<td><b>City:</b></td>
				<td>${recipient.city}</td>
			</tr>
			<tr>
				<td><b>State:</b></td>
				<td>${recipient.state}</td>
			</tr>
			<tr>
				<td><b>Country Code:</b></td>
				<td>${recipient.countryCode}</td>
			</tr>
			<tr>
				<td><b>Postal Code:</b></td>
				<td>${recipient.postalCode}</td>
			</tr>
		</table>
		<h2>Transaction Details:</h2>
		<table class="table-list">
			<tr>
				<td><b>Description:</b></td>
				<td>${transaction.description}</td>
			</tr>
			<tr>
				<td colspan="2"><b>Item List:</b></td>
			</tr>
			<tr>
				<td colspan="2">
					<table>
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
								<td><fmt:formatNumber groupingUsed="false"  value="${item.price}" type="currency" currencySymbol="$"/></td>
								<fmt:setLocale value="en_US" scope="session"/>
								<td><fmt:formatNumber  groupingUsed="false" value="${item.price * item.quantity}" type="currency" currencySymbol="$"/></td>
							</tr>
						</c:forEach>
						<tr>
							<td colspan="5" align="right">
							
								<fmt:setLocale value="en_US" scope="session"/>
								<p>Subtotal: <fmt:formatNumber groupingUsed="false" value="${transaction.amount.details.subtotal}" type="currency" currencySymbol="$"/></p>
								<fmt:setLocale value="en_US" scope="session"/>
								<p>Tax: <fmt:formatNumber groupingUsed="false" value="${transaction.amount.details.tax}" type="currency" currencySymbol="$"/></p>
								<fmt:setLocale value="en_US" scope="session"/>
								<p>Shipping Fee: <fmt:formatNumber groupingUsed="false" value="${transaction.amount.details.shipping}" type="currency" currencySymbol="$"/></p>
								<fmt:setLocale value="en_US" scope="session"/>
								<p>TOTAL: <fmt:formatNumber groupingUsed="false" value="${transaction.amount.total}" type="currency" currencySymbol="$"/></p>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table><br/><br/>
			<form action="execute_payment" method="post">
				<input type="hidden" name="paymentId" value="${param.paymentId}"/>
				<input type="hidden" name="PayerID" value="${param.PayerID}"/>
				
				<input type="submit" value="Pay Now" class="button green" />
			</form>
	</div>


	<jsp:directive.include file="footer.jsp" />
	
</body>
</html>