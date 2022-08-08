<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="../css/style.css"/>
	<script type="text/javascript" src="../js/jquery-3.4.0.min.js"></script>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
	<title>Edit Order - Evergreen Bookstore Admin</title>
</head>
<body>

	<jsp:directive.include file="header.jsp" />
		
	<form action="update_order" method="post" id="orderForm">
	
		<div align="center">	
		
			<table class="table-list">
			
					<h2>Order Overview :</h2>
				<tr>
					<td><b>Ordered By:</b></td>
					<td>${order.customer.fullname}</td>
				</tr>
				
				<tr>
					<td><b>Order Date:</b></td>
					<td>${order.orderDate}</td>
				</tr>
				
				<tr>
					<td><b>Payment Method:</b></td>
					<td>
						<select name="paymentMethod">
							<option value="Cash On Delivery" <c:if test="${order.paymentMethod eq 'Cash On Delivery'}">selected='selected'</c:if>>Cash On Delivery</option>
							<option value="paypal" <c:if test="${order.paymentMethod eq 'Paypal'}">selected='selected'</c:if>>Paypal or Credit card</option>	
						</select>
					</td>
				</tr>
				
				<tr>
					<td><b>Order Status:</b></td>
					<td>
						<select name="orderStatus">
								<option value="Processing" <c:if test="${order.status eq 'Processing'}">selected='selected'</c:if> >Processing</option>
								<option value="Shipping"  <c:if test="${order.status eq 'Shipping'}">selected='selected'</c:if> >Shipping</option>
								<option value="Delivered" <c:if test="${order.status eq 'Delivered'}">selected='selected'</c:if> >Delivered</option>
								<option value="Completed" <c:if test="${order.status eq 'Completed'}">selected='selected'</c:if> >Completed</option>
								<option value="Cancelled" <c:if test="${order.status eq 'Cancelled'}">selected='selected'</c:if> >Cancelled</option>
						</select>
					</td>
				</tr>
			</table>
			
			<h2>Recipient Information : </h2>
			
			<table class="table-list">
			
				<tr>
					<td><b>First name:</b></td>
					<td><input type="text" name="firstname" id="firstname" value="${order.firstname}" size="45" /></td>
				</tr>
				
				<tr>
					<td><b>Last name:</b></td>
					<td><input type="text" name="lastname" id="lastname" value="${order.lastname}" size="45" /></td>
				</tr>
				
				<tr>
					<td><b>Phone number:</b></td>
					<td><input type="text" name="phone" id="phone" value="${order.phone}" size="45" /></td>
				</tr>
				
				<tr>
					<td><b>Address Line 1:</b></td>
					<td><input type="text"  name="address1" value="${order.addressLine1}" size="45" /></td>
				</tr>
				
				<tr>
					<td><b>Address Line 2:</b></td>
					<td><input type="text" name="address2" value="${order.addressLine2}" size="45" /></td>
				</tr>
				
				<tr>
					<td><b>City:</b></td>
					<td><input type="text" name="city" name="city" value="${order.city}" size="45" /></td>
				</tr>
				
				<tr>
					<td><b>State:</b></td>
					<td><input type="text" name="state" name="state" value="${order.state}" size="45" /></td>
				</tr>
				
				<tr>
					<td><b>Zip code:</b></td>
					<td><input type="text" name="zipcode" name="zipcode" value="${order.zipcode}" size="45" /></td>
				</tr>
				
				<tr>
					<td align="right">Country:</td>
					<td align="left">
						<select name="country" id="country">
							<c:forEach items="${mapCountries}" var="country">
								<option value="${country.value}" <c:if test='${order.country eq country.value}'>selected='selected'</c:if>>${country.key}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				
			</table>
		
		</div>
		
		<div align="center">
			<h2>Ordered Books:</h2>
			<table border="1">
				<tr>
					<th>Index</th>
					<th>Book Title</th>
					<th>Author</th>
					<th>Price</th>
					<th>Quantity</th>
					<th>Subtotal</th>
					<th>Actions</th>
				</tr>
				<c:forEach items="${order.orderDetails}" var="orderDetail" varStatus="status">
				<tr>
					<td>${status.index + 1}</td>
					<td>${orderDetail.book.title}</td>
					<td>${orderDetail.book.author}</td>
					<td>
						<input type="hidden" name="price" value="${orderDetail.book.price}"/><fmt:setLocale value="en_US" scope="session"/>	
						<fmt:formatNumber groupingUsed="false" value="${orderDetail.book.price}" type="currency" currencySymbol="$"/>
					</td>
					<td>
						<input type="hidden" name="bookId" value="${orderDetail.book.bookId}"/>
						<input type="text" name="quantity${status.index + 1}" value="${orderDetail.quantity}" size="5"/>
					</td>
					<td><fmt:formatNumber groupingUsed="false" value="${orderDetail.subtotal}" type="currency" currencySymbol="$"  /></td>
					<td><a href="remove_book_from_order?id=${orderDetail.book.bookId}">Remove</a></td>
				</tr>
				</c:forEach>
				<tr>
					<td colspan="7" align="right">
						<p>Subtotal: $${order.subtotal}</p>
						<p>Tax($): <input type="text" name="tax" id="tax" value="${order.tax}" size="5"/></p>
						<p>Shipping Fee($): <input type="text" name="shippingFee" id="shippingFee" value="${order.shippingFee}" size="5"/></p>
						<p>TOTAL: <fmt:formatNumber groupingUsed="false" type="currency" value="${order.total}" currencySymbol="$"/></p>
					</td>
				</tr>
			</table>
		</div>
		<div align="center"><br/><br/>
			<a href="javascript:showAddBookPopup()">Add Books</a>&nbsp;&nbsp;&nbsp;
			<input type="submit"  class="button green" value="Save"/>&nbsp;&nbsp;&nbsp;
			<input type="button" id="buttonCancel" class="button red" value="Cancel" onclick="javascript:window.location.href='list_order';" />			
		</div>
	</form>
	
	<jsp:directive.include file="footer.jsp" />
	
</body>

	<script type="text/javascript">
	
				function showAddBookPopup(){
					var width = 700;
					var height = 300;
					var left = (screen.width - width)/2;
					var top = (screen.height - height)/2;
					
					window.open('add_book_form', '_blank', 'width=' + width + ', height=' + height + ', top=' + top + ', left=' + left);
				}
			
			$(document).ready(function(){
				$("#orderForm").validate({
					rules: {
						firstname: "required",
						lastname: "required",
						phone: "required",
						address1: "required",
						city: "required",
						state: "required",
						zipcode: "required",
						country: "required",
						shippingFee: {
							required:true, number: true, min: 0
						},
						tax: {
							required:true, number:true, min: 0
						},
						<c:forEach items="${order.orderDetails}" var="book" varStatus="status">
								quantity${status.index + 1}: {
							required: true,
							number: true,
							min: 1
						},	 
						</c:forEach>
					},
					
					messages: {
						firstname: "You must enter recipient first name",
						lastname: "You must enter recipient last name",
						phone: "You must enter recipient phone number",
						address1: "You must enter recipient address",
						city: "You must enter recipient city",
						state: "You must enter recipient state",
						zipcode: "You must enter recipient zipcode",
						country: "You must enter recipient zipode",
						shippingFee: {
							required: "You must enter shipping fee", 
							number: "Shipping fee must be a number", 
							min: "Shipping fee must be  greater than 0"
						},
						tax: {
							required: "You must enter the tax amount", 
							number: "The tax must be a number", 
							min: "The tax must be equal or greater than 0"
						},
						<c:forEach items="${order.orderDetails}" var="book" varStatus="status">
								quantity${status.index + 1}: {	
							required: "Please enter quantity",
							number: "Quantity must be a number",
							min: "Quantity must be equal or greater than 0"
						
						},
						</c:forEach>		
					},
				
				});	
			});
		
				
	</script>
</html>