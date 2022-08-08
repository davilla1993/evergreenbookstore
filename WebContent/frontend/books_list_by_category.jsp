<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="css/style.css"/>
	<title>Books in ${category.name}- Online Books Store</title>
</head>
<body>
	<jsp:directive.include file="header.jsp"/>
	
	<div class="center">
		<h2>${category.name}</h2>
	</div>
	
	<div class="book-group">
		<c:forEach items="${listBooks}" var="book">
			<div class="book">
				<div>
					<a href="view_book?id=${book.bookId}">
						<img src="data:image/jpg;base64,${book.base64Image}" class="book-small" />				
					</a>
				</div>
				<div class="book-title">
					<a href="view_book?id=${book.bookId}">
						<b>${book.title}</b>
					</a>
				</div>
				<div>
					<jsp:directive.include file="book_rating.jsp"/>
				</div>
				<div><i>by ${book.author}</i></div>
				<div><b>$ ${book.price}</b></div>
				
			</div>
		</c:forEach>
	</div><br/><br/>
	
		<jsp:directive.include file="footer.jsp"/>
	
</body>
</html>>