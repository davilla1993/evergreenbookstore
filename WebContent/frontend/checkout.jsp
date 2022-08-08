<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="css/style.css"/>
	<script type="text/javascript" src="js/jquery-3.4.0.min.js"></script>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<title>Evergreen Bookstore - Checkout</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
	
		<c:set var="cart" value="${sessionScope['cart']}" />
		
		<c:if test="${cart.totalItems == 0}">
			<h2>There's no items in your cart</h2>
		</c:if>
		
		<c:if test="${cart.totalItems > 0}">
		
				<div>
					<h2>Review Your Order Details <a href="view_cart">Edit</a></h2>
					
					<table class="table-list">
						<tr>
						
							<th>No</th>
							<th colspan="2">Book</th>
							<th>Author</th>
							<th>Price</th>
							<th>Quantity</th>
							<th>Subtotal</th>
							
						</tr>
						<c:forEach items="${cart.items}" var="item" varStatus="status">
							<tr>
							
								<td>${status.index + 1}</td>
								
								<td><img src="data:image/jpg;base64,${item.key.base64Image}" class="image-cart"/></td>
								
								<td><span id="book-title">${item.key.title}</span></td>
								
								<td>${item.key.author}</td>
								
								<fmt:setLocale value="en_US"/>
								<td><fmt:formatNumber groupingUsed="false" value="${item.key.price}" type="currency" currencySymbol="$" /></td>		
								
								<td><input type="text" name="quantity${status.index + 1}" value="${item.value}" size="5" readonly="readonly"/></td>
								
								<fmt:setLocale value="en_US"/>
								<td><fmt:formatNumber groupingUsed="false" value="${item.value*item.key.price}" type="currency" currencySymbol="$"/></td>
						
							</tr>
						</c:forEach>
						
						<tr>
							<td colspan="7" align="right">
								<p>Number of copies: ${cart.totalQuantity}</p>
								
								<fmt:setLocale value="en_US"/>
								<p>Subtotal: <fmt:formatNumber groupingUsed="false" value="${cart.totalAmount}" type="currency" currencySymbol="$"/></p>
								<p>Tax: <fmt:formatNumber groupingUsed="false" value="${tax}" type="currency" currencySymbol="$"/></p>
								<p>Shipping Fee: <fmt:formatNumber groupingUsed="false" value="${shippingFee}" type="currency" currencySymbol="$"/></p>
								<p>TOTAL: <fmt:formatNumber groupingUsed="false" value="${total}" type="currency" currencySymbol="$"/></p>
	
							</td>
						</tr>
					</table>
					<h2>Recipient Information</h2>
					
					<form id="orderForm" action="place_order" method="post">
					
						<table class="table-list">
						
							<tr>
								<td align="left">Firstname:</td>
								<td align="right"><input type="text" name="firstname" value="${loggedCustomer.firstname}" size="45"/></td>
							</tr>
							<tr>
								<td align="left">Lastname:</td>
								<td align="right"><input type="text" name="lastname" value="${loggedCustomer.lastname}" size="45"/></td>
							</tr>
							<tr>
								<td align="left">Phone number:</td>
								<td align="right"><input type="text" name="phone" value="${loggedCustomer.phone}" size="45"/></td>
							</tr>
							<tr>
								<td align="left">Address Line1:</td>
								<td align="right"><input type="text" name="address1" value="${loggedCustomer.addressLine1}" size="45"/></td>
							</tr>
							<tr>
								<td align="left">Address Line2:</td>
								<td align="right"><input type="text" name="address2" value="${loggedCustomer.addressLine2}" size="45"/></td>
							</tr>
							<tr>
								<td align="left">City:</td>
								<td align="right"><input type="text" name="city" value="${loggedCustomer.city}" size="45"/></td>
							</tr>
							<tr>
								<td align="left">State:</td>
								<td align="right"><input type="text" name="state" value="${loggedCustomer.state}" size="45"/></td>
							</tr>
							<tr>
								<td align="left">Zip Code:</td>
								<td align="right"><input type="text" name="zipCode" value="${loggedCustomer.zipcode}" size="45"/></td>
							</tr>
							<tr>
								<td align="left">Country:</td>
								<td>
									<select name="country" id="country">
										<c:forEach items="${mapCountries}" var="country">
											<option value="${country.value}" <c:if test='${loggedCustomer.country eq country.value}'>selected='selected'</c:if>>${country.key}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
						
						</table>
						<div>
							<h2>Payment</h2>
							Choose your payment method:
							&nbsp;&nbsp;&nbsp;
							<select name="paymentMethod">
								<option value="Cash On Delivery">Cash On Delivery</option>
								<option value="paypal">Paypal or Credit card</option>
							</select>
						</div>
					&nbsp;&nbsp;&nbsp;	
					<div>
						<button type="submit" class="button green">Place Order</button>&nbsp;&nbsp;
						<a href="${pageContext.request.contextPath}/">Continue-shopping</a>&nbsp;&nbsp;
					</div>
				</form>
			</div>
							
		 </c:if>
		
	</div>
	
	<jsp:directive.include file="footer.jsp" />
	
</body>

 <script type="text/javascript">

	$(document).ready(function(){
		
		$("#orderForm").validate({
			rules: {
				firstname: "required",
				lastname: "required",
				phone: "required",
				address1: "required",
				city: "required",
				state: "required",
				zipCode: "required",
				country: "required"
			},
			
			messages: {
				firstname: " You must enter recipient firstname",
				lastname: " You must enter recipient lastname",
				phone: "You must enter recipient phone",
				address1: "You must enter recipient address",
				city: "You must enter recipient city",
				state: "You must enter recipient state",
				zipCode: "You must enter recipient zip code",
				country: "You must enter recipient country name"
			}
		});
	});
	
</script>
</html>