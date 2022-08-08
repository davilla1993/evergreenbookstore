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
	
	<title>Create Customer - Evergreen Bookstore Admin</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div>
	
		<h2 class="pageheading">
			<c:if test="${customer != null}">Edit Customer</c:if>
			<c:if test="${customer == null }">Create New Customer</c:if>
		</h2>
	</div>
	
	<div align="center">
	
		<c:if test="${customer == null}">
		<form action="create_customer" method="post" id="customerForm">
		</c:if>
		
		<c:if test="${customer != null}">
		<form action="update_customer" method="post" id="customerForm">	
		<input type="hidden" name="customerId" value="${customer.customerId}"/>
		</c:if>
			
			<table class="table-form">
				
				<tr>
					<td align="right">First Name:</td>
					<td align="left"><input type="text" name="firstname" id="firstname" value="${customer.firstname}" size="45" /></td>
				</tr>
				<tr>
					<td align="right">Last Name:</td>
					<td align="left"><input type="text" name="lastname" id="lastname" value="${customer.lastname}" size="45" /></td>
				</tr>
				<tr>
					<td align="right">Email:</td>
					<td align="left"><input type="text" name="email"  id="email" value="${customer.email}" size="45" /></td>
				</tr>
				<tr>
					<td align="right">Password:</td>
					<td align="left"><input type="password" name="password"  id="password" value="${customer.password}" size="45" /></td>
				</tr>
				<tr>
					<td align="right">Confirm Password:</td>
					<td align="left"><input type="password" name="confirmPassword"  id="confirmPassword" value="${customer.password}" size="45" /></td>
				</tr>
				<tr>
					<td align="right">Phone number:</td>
					<td align="left"><input type="text" name="phone"  id="phone" value="${customer.phone}" size="45" /></td>
				</tr>
				<tr>
					<td align="right">Address Line 1:</td>
					<td align="left"><input type="text" name="address1"  id="address1" value="${customer.addressLine1}" size="45" /></td>
				</tr>
				<tr>
					<td align="right">Address Line 2:</td>
					<td align="left"><input type="text" name="address2"  id="address2" value="${customer.addressLine2}" size="45" /></td>
				</tr>
				<tr>
					<td align="right">City:</td>
					<td align="left"><input type="text" name="city"  id="city" value="${customer.city}" size="45" /></td>
				</tr>
				<tr>
					<td align="right">State:</td>
					<td align="left"><input type="text" name="state"  id="state" value="${customer.state}" size="45" /></td>
				</tr>
				<tr>
					<td align="right">ZipCode:</td>
					<td align="left"><input type="text" name="zipCode"  id="zipCode" value="${customer.zipcode}" size="45" /></td>
				</tr>
				<tr>
					<td align="right">Country:</td>
					<td align="left">
						<select name="country" id="country">
							<c:forEach items="${mapCountries}" var="country">
								<option value="${country.value}" <c:if test='${customer.country eq country.value}'>selected='selected'</c:if>>${country.key}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
		
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td colspan="2" align="center">
					
						<button type="submit" class="green">Save</button>
						<input type="button" id="buttonCancel" class="button red" value="Cancel" />
					
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<jsp:directive.include file="footer.jsp" />
</body>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("#customerForm").validate({
			rules: {
				email: {
					required: true,
					email: true
				},
				firstname: "required",
				lastname: "required",
				password: "required",
				confirmPassword: {
					required: true,
					equalTo: "#password"
				},
				phone: "required",
				address1: "required",
				city: "required",
				state: "required",
				country: "required",
				zipCode: "required"
			},
			
			messages: {
				email:{
					required: "Please, enter your e-mail address",
					email: "Please, enter an valid e-mail address"
				},
				
				firstname: "Please, enter your first name",
				lastname: "Please, enter your first last name",
				password: "Please, enter your password",
				confirmPassword: {
					required : "Please, confirm your password",
					equalTo: "The two passwords do not match"
				},
				phone: "Please, enter your phone number",
				address1: "Please, enter your address line 1",
				city: "Please, enter your city",
				state: "Please, enter your state",
				country: "Please, enter your country",
				zipCode: "Please, enter your zip code"

			}
			
			});
		});
	
	
	
	$("#buttonCancel").click(function(){
		history.go(-1);
	});
	
	
</script>
</html>