<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="css/style.css"/>
	
	<script type="text/javascript" src="js/jquery-3.4.0.min.js"></script>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>

	<title>Edit profile</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div>
	
		<h2 class="pageheading">
			Edit My Profile
		</h2>
	</div>
	
	<div class="center">
	
		<form action="update_profile" method="post" id="registerForm">
		
			<table>
			
				<tr>
					<td align="right">Email:</td>
					<td align="left"><input type="email" name="email" id="email" size="45" value="${loggedCustomer.email}" readonly/>(Cannot be changed)</td>
				</tr>
				
				<tr>
					<td align="right">First name:</td>
					<td align="left"><input type="text" name="firstname" id="firstname" size="45" value="${loggedCustomer.firstname}"/></td>
				</tr>
				
				<tr>
					<td align="right">Last name:</td>
					<td align="left"><input type="text" name="fullName" id="fullName" size="45" value="${loggedCustomer.lastname}"/></td>
				</tr>
				
				<tr>
					<td align="right">Phone number:</td>
					<td align="left"><input type="text" name="phone"  id="phone"  size="45" value="${loggedCustomer.phone}"/></td>
				</tr>
				
				<tr>
					<td align="right">Address Line 1:</td>
					<td align="left"><input type="text" name="address1"  id="address1" value="${loggedCustomer.addressLine1}" size="45" /></td>
				</tr>
				
				<tr>
					<td align="right">Address Line 2:</td>
					<td align="left"><input type="text" name="address2"  id="address2" value="${loggedCustomer.addressLine2}" size="45" /></td>
				</tr>
				
				<tr>
					<td align="right">City:</td>
					<td align="left"><input type="text" name="city"  id="city" size="45" value="${loggedCustomer.city}"/></td>
				</tr>
				
				<tr>
					<td align="right">State:</td>
					<td align="left"><input type="text" name="state"  id="state" value="${loggedCustomer.state}" size="45" /></td>
				</tr>
				
				<tr>
					<td align="right">ZipCode:</td>
					<td align="left"><input type="text" name="zipCode"  id="zipCode" size="45" value="${loggedCustomer.zipcode}"/></td>
				</tr>
				
				<tr>
					<td align="right">Country:</td>
					<td align="left">
						<select name="country" id="country">
							<c:forEach items="${mapCountries}" var="country">
								<option value="${country.value}" <c:if test='${loggedCustomer.country eq country.value}'>selected='selected'</c:if>>${country.key}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr><td align="center"><i>(Leave password fields blank if you don't want to change password)</i></td></tr>
				
				<tr>
					<td align="right">Password:</td>
					<td align="left"><input type="password" name="password"  id="password"  size="45" /></td>
				</tr>
				
				<tr>
					<td align="right">Confirm Password:</td>
					<td align="left"><input type="password" name="confirmPassword"  id="confirmPassword" size="45" /></td>
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
	
	$("#registerForm").validate({
		rules: {
			
			firstname: "required",
			lastname: "required",
			confirmPassword: {
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
			
			firstname: "Please, enter your first name",
			lastname: "Please, enter your first last name",
			password: "Please, enter your password",
			confirmPassword: {
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