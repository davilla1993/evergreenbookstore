<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="css/style.css"/>
	<script type="text/javascript" src="js/jquery-3.4.0.min.js"></script>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
	<title>Evergreen Bookstore - Login</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div align="center">
	
		<h2>Login</h2>
	</div>
	
	<c:if test="${message != null}">
		<div>
			<h4>${message}</h4>
		</div>
	</c:if>
	
	<div align="center">
	
		<form action="login" id="formLogin" method="post">
		
			<table class="normal">
	
				<tr>
					<td align="right">Email</td>
					<td align="left"><input type="text" name="email"  id="email" /></td>
				</tr>
				<tr>
					<td align="right">Password</td>
					<td align="left"><input type="password" name="password" id="password" /></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td colspan="2" align="center">
					
						<button type="submit" class="green">Login</button>
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
		$("#formLogin").validate({
			rules: {
				email: {
					required: true,
					email: true	
					
				},
				
				password: "required",
			},
			
			messages: {
				email: {
					required: "You must enter you email address",
					email: "Please, enter an valid email address"
				},
			
				password: "You must enter your password"
			}
		});
	});
	
	
	$("#buttonCancel").click(function(){
		history.go(-1);
	});
	
</script>
</html>