<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="../css/style.css"/>
	<script type="text/javascript" src="../js/jquery-3.4.0.min.js"></script>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
	<title>Manage Users - Evergreen Bookstore Admin</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div>
	
		<h2 class="pageheading">
			<c:if test="${user != null}">Edit User</c:if>
			<c:if test="${user == null }">Create New User</c:if>
		</h2>
	</div>
	
	<div align="center">
	
		<c:if test="${user == null}">
		<form action="create_user" method="post" id="userForm">
		</c:if>
		
		<c:if test="${user != null}">
		<form action="update_user" method="post" id="userForm">
		
		<input type="hidden" name="userId" value="${user.userId}"/>
		</c:if>
			
			<table class="table-form">
			
				<tr>
					<td align="right">Full name</td>
					<td align="left"><input type="text" name="fullname" id="fullname" value="${user.fullName}"/></td>
				</tr>
				<tr>
					<td align="right">Email</td>
					<td align="left"><input type="text" name="email"  id="email" value="${user.email}"/></td>
				</tr>
				<tr>
					<td align="right">Password</td>
					<td align="left"><input type="password" name="password" id="password" value="${user.password}"/></td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr>
					<td colspan="2" align="center">
					
						<button type="submit" class="green">Save</button>
						<input  type="button" id="buttonCancel" class="button red" value="Cancel" />
					
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<jsp:directive.include file="footer.jsp" />
</body>

<script type="text/javascript">

	$(document).ready(function(){
		$("#userForm").validate({
			rules: {
				email: {
					required: true,
					email: true	
					
				},
				
				fullname: "required",
				password: "required",
			},
			
			messages: {
				email: {
					required: "You must enter you email address",
					email: "Please, enter an valid email address"
				},
			
				fullname: "You must enter your fullname",
				password: "You must enter your password"
			}
		});
	});
	
	
	$("#buttonCancel").click(function(){
		history.go(-1);
	});
	
</script>
</html>