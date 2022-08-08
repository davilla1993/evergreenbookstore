<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="css/style.css"/>
	<title>Evergreen Books - Online Books Store</title>
</head>
<body>
	<jsp:directive.include file="header.jsp"/>
	
	<div align="center"><br/><br/>
	
		<h2>New Books:</h2>
		
		<div class="next-row">
		
			<c:forEach items="${listNewBooks}" var="book">
				<jsp:directive.include file="book_group.jsp"/>					
			</c:forEach>
			
		</div>
		
		<div class="next-row">	
			
			<h2>Best Selling Books:</h2>
			
			<c:forEach items="${listBestSellingBooks}" var="book">
				<jsp:directive.include file="book_group.jsp"/>	
			</c:forEach>
		
		</div>
		
		
		<div class="next-row">
			<h2>Most-favored Books: </h2>
			
			<c:forEach items="${listFavouredBooks}" var="book">
				<jsp:directive.include file="book_group.jsp"/>	
			</c:forEach>
			
		</div><br/><br/>
		
	</div>
	
		<jsp:directive.include file="footer.jsp"/>
	
</body>
</html>