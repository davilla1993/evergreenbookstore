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
	<title>Evergreen Bookstore - Shopping cart</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
	
		<h2>Your Cart Details</h2>
		
		<c:set var="cart" value="${sessionScope['cart']}" />
		
		<c:if test="${cart.totalItems == 0}">
			<h2>There's no items in your cart</h2>
		</c:if>
		
		<c:if test="${cart.totalItems > 0}">
			<form action="update_cart" method="post" id="cartForm">
				<div>
					<table class="table-list">
						<tr>
							<th>No</th>
							<th colspan="2">Book</th>
							<th>Quantity</th>
							<th>Price</th>
							<th>Subtotal</th>
							<th>Action</th>
						</tr>
						<c:forEach items="${cart.items}" var="item" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td><img src="data:image/jpg;base64,${item.key.base64Image}" class="image-cart"/></td>
								<td>${item.key.title}</td>
								<td>
									<input type="hidden" name="bookId" value="${item.key.bookId}"/>
									<input type="text" name="quantity${status.index + 1}" value="${item.value}" size="5"/>
								</td>
								<fmt:setLocale value="en_US" scope="session"/>
								<td><fmt:formatNumber groupingUsed="false" value="${item.key.price}" type="currency" currencySymbol="$" /></td>
								<fmt:setLocale value="en_US" scope="session"/>
								<td><fmt:formatNumber groupingUsed="false" value="${item.value*item.key.price}" type="currency" currencySymbol="$"/></td>
								<td><a href="remove_from_cart?book_id=${item.key.bookId}">Remove</a></td>
							</tr>
						</c:forEach>
                      						
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td><b>${cart.totalQuantity} book(s)</b></td>
							<td>Total:</td>
							<fmt:setLocale value="en_US" scope="session"/>
							<td colspan="2"><b><fmt:formatNumber groupingUsed="false" value="${cart.totalAmount}" type="currency" currencySymbol="$"/></b></td>
						</tr>
					</table>
				</div>
				&nbsp;&nbsp;&nbsp;
				<div>
					<table>
						<tr><td>&nbsp;</td></tr>
						<tr>
							<td></td>
							<td><button type="submit" class="button green">Update</button></td>
							<td><input type="button" id="clearCart" value="Clear-Cart"class="button red"/></td>
							<td><a href="${pageContext.request.contextPath }/">Continue Shopping</a></td>
							<td><a href="checkout">Checkout</a></td>
						</tr>
					</table>
				</div>
			</form>
			
		</c:if>
		
	</div>
		
	<jsp:directive.include file="footer.jsp" />
	
</body>

	 <script type="text/javascript">
		$(document).ready(function(){
			$("#clearCart").click(function(){
				window.location = 'clear_cart';
			});	
		
			$("#cartForm").validate({
				rules:{
					<c:forEach items="${cart.items}" var="item" varStatus="status">
						quantity${status.index + 1}: {
							required : true,
							number : true,
							min : 1
						},	 
					</c:forEach>
				},
				
				messages:{
					<c:forEach items="${cart.items}" var="item" varStatus="status">
						quantity${status.index + 1}: {	
						required : "Please enter quantity",
						number : "Quantity must be a number",
						min : "Quantity must be greater than 0"
						},
					</c:forEach>	
				}
			});
		});
		
	</script> 
</html>