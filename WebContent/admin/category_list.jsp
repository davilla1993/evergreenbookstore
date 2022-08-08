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
		<h1 class="pageheading">Category Management</h1>
		<h3><a href="category_form.jsp">Create New Category</a></h3>
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
				<th>Name</th>
				<th>Actions</th>
			</tr>
			<c:forEach var="cat" items="${listCategory}" varStatus="status">
			<tr>
<%-- 			<td>${status.index + 1}</td> --%>
				<td>${cat.categoryId}</td>
				<td>${cat.name}</td>
				<td>
					<a href="edit_category?id=${cat.categoryId}">Edit</a>
					<a href="javascript:void(0);" class="deleteLink" id="${cat.categoryId}">Delete</a>
				</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	
	<div align="center">
		
	</div>
	
	<jsp:directive.include file="footer.jsp" />
	
</body>

	<script>
	$(document).ready(function(){
		$(".deleteLink").each(function(){
			$(this).on("click", function(){
				categoryId = $(this).attr("id");
				if(confirm('Are you sure you want to delete this category ?')){
					window.location = "delete_category?id=" + categoryId;
				}
			});
		});
	});
	</script>
</html>