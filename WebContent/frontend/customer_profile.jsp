<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/style.css"/>
<title>Evergreen Bookstore - Profile</title>
</head>
<body>
	
		<jsp:directive.include file="header.jsp" />
		
		<div align="center">
					
			<table class="normal">
				<tr>
					<td><b>First name:</b></td>
					<td>${loggedCustomer.firstname}</td>
				</tr>
				
				<tr>
					<td><b>Last name:</b></td>
					<td>${loggedCustomer.lastname}</td>
				</tr>
				
				<tr>
					<td><b>E-mail:</b></td>
					<td>${loggedCustomer.email}</td>
				</tr>
				
				<tr>
					<td><b>Phone Number:</b></td>
					<td>${loggedCustomer.phone}</td>
				</tr>
				
				<tr>
					<td><b>Address Line 1:</b></td>
					<td>${loggedCustomer.addressLine1}</td>
				</tr>
				
				<tr>
					<td><b>Address Line 2:</b></td>
					<td>${loggedCustomer.addressLine2}</td>
				</tr>
				
				<tr>
					<td><b>City:</b></td>
					<td>${loggedCustomer.city}</td>
				</tr>
				
				<tr>
					<td><b>State:</b></td>
					<td>${loggedCustomer.state}</td>
				</tr>
				
				<tr>
					<td><b>Country:</b></td>
					<td>${loggedCustomer.country}</td>
				</tr>
				
				<tr>
					<td><b>Zip code:</b></td>
					<td>${loggedCustomer.zipcode}</td>
				</tr>
				
				<tr><td>&nbsp;</td></tr>
				
				<tr>
					<td colspan="2"><span><a href="edit_profile">Edit My Profile</a></span></td>
				</tr>
			</table>
			
		</div>
		
		<jsp:directive.include file="footer.jsp" />
		
</body>
</html>