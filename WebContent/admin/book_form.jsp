<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="../css/style.css"/>
	<link rel="stylesheet" href="../css/jquery-ui.min.css" />
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="../css/richtext.min.css">
	
	
	<script type="text/javascript" src="../js/jquery-3.4.0.min.js"></script>
	<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
	<script type="text/javascript" src="../js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="../js/jquery.richtext.min.js"></script>
	
	<title>Manage Books - Evergreen Bookstore Admin</title>
</head>
<body>
	<jsp:directive.include file="header.jsp" />
	
	<div>
	
		<h2 class="pageheading">
			<c:if test="${book != null}">Edit Book</c:if>
			<c:if test="${book == null }">Create New Book</c:if>
		</h2>
	</div>
	
	<div align="center">
	
		<c:if test="${book == null}">
		<form action="create_book" method="post" id="bookForm" enctype="multipart/form-data">
		</c:if>
		
		<c:if test="${book != null}">
		<form action="update_book" method="post" id="bookForm" enctype="multipart/form-data">	
		<input type="hidden" name="bookId" value="${book.bookId}"/>
		</c:if>
			
			<table class="table-form">
				<tr>
					<td align="right">Category:</td>
					<td align="left">
						<select name="category" class="dropbox">
							<c:forEach items="${listCategory}" var="category">
								<c:if test="${category.categoryId eq book.category.categoryId}">
									<option value="${category.categoryId}" selected>
								</c:if>
								<c:if test="${category.categoryId ne book.category.categoryId}">
									<option value="${category.categoryId}">
								</c:if> 
									${category.name}
								</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right">Title:</td>
					<td align="left"><input type="text" name="title" id="title" value="${book.title}"/></td>
				</tr>
				<tr>
					<td align="right">Author</td>
					<td align="left"><input type="text" name="author"  id="author" value="${book.author}"/></td>
				</tr>
				<tr>
					<td align="right">ISBN:</td>
					<td align="left"><input type="text" name="isbn"  id="isbn" value="${book.isbn}"/></td>
				</tr>
				<tr>
					<td align="right">Publish Date:</td>
					<td align="left"><input type="text" name="publishDate"  id="publishDate"  value="<fmt:formatDate pattern='MM/dd/yyyy' value='${book.publishDate}'/>" /> </td>
				</tr>
				<tr>
					<td align="right">Book Image:</td>
					<td align="left">
						<input type="file" name="bookImage"  id="bookImage"/><br/>
						<img id="thumbnail" alt="image preview" class="thumbnail" src="data:image/jpg;base64,${book.base64Image}"/>
					</td>
				</tr>
				<tr>
					<td align="right">Price</td>
					<td align="left"><input type="number" name="price"  id="price" value="${book.price}"/></td>
				</tr>
				<tr>
					<td align="right">Description</td>
					<td align="left">
						<textarea rows="5" cols="50" name="description" id="description">${book.description}</textarea>
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
		
		$('#publishDate').datepicker();
		
		$('#description').richText();
		
		$('#bookImage').change(function(){
			showImageThumbnail(this)
		});
		
		$("#bookForm").validate({
			rules: {
				category: "required",
				title: "required",
				author: "required",
				isbn: "required",
				publishDate: "required",
				
				<c:if test="${book == null}">
				bookImage: "required",
				</c:if>
				
				price: "required",
				description: "required"
			},
			
			messages: {
				category: "Please, enter the category of the book",
				title: "Please, enter the title of the book",
				author: "Please, enter the author of the book",
				isbn: "Please, enter the isbn of the book",
				publishDate: "Please, enter the publish date of the book",
				bookImage: "You must select the book's image",
				price: "Please, enter the price of the book",
				description: "Please, enter the description of the book"
			}
		});
	});
	
	
	$("#buttonCancel").click(function(){
		history.go(-1);
	});
	
	
	function showImageThumbnail(fileInput){
		var file = fileInput.files[0];
		
		var reader = new FileReader();
		
		reader.onload = function(e){
			$('#thumbnail').attr('src', e.target.result);
		};
		
		reader.readAsDataURL(file);
	}
	
</script>
</html>