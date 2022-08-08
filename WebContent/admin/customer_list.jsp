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
	<title>Manage Customers - Evergreen Bookstore Admin</title>
</head>
<body>

	<jsp:directive.include file="header.jsp" />
	
	<div>
		<h1 class="pageheading">Customers Management</h1>
		<h3><a href="new_customer">Create New Customer</a></h3>
	</div>
	
	<c:if test="${message != null}">
	<div>
		<h4 class="message">${message}</h4>
	</div>
	</c:if>
	
	<div align="center">
		<table class="table-list">
			<tr>
<!-- 				<th>Index</th> -->
				<th>ID</th>
				<th>First name</th>
				<th>Last name</th>
				<th>Email</th>
				<th>Phone</th>
				<th>Address1</th>
				<th>Address2</th>
				<th>City</th>
				<th>State</th>
				<th>Zip code</th>
				<th>Country</th>
				<th>Registered Date</th>
				<th>Actions</th>
			</tr>
			<c:forEach var="customer" items="${listCustomer}" varStatus="status">
			<tr>
<%-- 			<td>${status.index + 1}</td> --%>
				<td>${customer.customerId}</td>
				<td>${customer.firstname}</td>
				<td>${customer.lastname}</td>
				<td>${customer.email}</td>
				<td>${customer.phone}</td>
				<td>${customer.addressLine1}</td>
				<td>${customer.addressLine2}</td>
				<td>${customer.city}</td>
				<td>${customer.state}</td>
				<td>${customer.zipcode}</td>
				<td>${customer.countryName}</td>
				<td><fmt:formatDate pattern='MM/dd/yyyy' value="${customer.registerDate}"/></td>
				<td>
					<a href="edit_customer?id=${customer.customerId}">Edit</a>
					<a href="javascript:void(0);" class="deleteLink" id="${customer.customerId}">Delete</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	
	<jsp:directive.include file="footer.jsp" />
	
</body>

	<script>
		$(document).ready(function(){
			$(".deleteLink").each(function(){
				$(this).on("click", function(){
					customerId = $(this).attr("id");
					if(confirm('Are you sure you want to delete this book ?')){
						window.location = "delete_customer?id=" + customerId;
					}
				});
			});
		});
	</script>
</html>