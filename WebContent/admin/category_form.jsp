<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="../css/style.css"/>
	<script type="text/javascript" src="../js/jquery-3.4.0.min.js"></script>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
	<title>Manage categories - Evergreen Bookstore Admin</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div>
		<h2 class="pageheading">
			<c:if test="${category != null}">Edit category</c:if>
			<c:if test="${category == null }">Create New category</c:if>
		</h2>
	</div>
	
	<div align="center">
	
		<c:if test="${category == null}">
		<form action="create_category" method="post" id="categoryForm">
		</c:if>
		
		<c:if test="${category != null}">
		<form action="update_category" method="post" id="categoryForm">
		<input type="hidden" name="categoryId" value="${category.categoryId}"/>
		</c:if>
			
			<table class="table-form">
			
				<tr>
					<td align="right">Category Name</td>
					<td align="left"><input type="text" name="name" id="name" size="20" value="${category.name}"/></td>
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
	$("#categoryForm").validate({
		rules: {
			
			name: "required",
		},
		
		messages: {
			name: "You must enter a category name",
			
		}
	});
});

$("#buttonCancel").click(function(){
	history.go(-1);
});

</script>
</html>