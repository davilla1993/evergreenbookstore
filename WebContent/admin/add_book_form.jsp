<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="../css/style.css"/>
<script type="text/javascript" src="../js/jquery-3.4.0.min.js"></script>
<title>Add Book to Order</title>
</head>
<body>
	<div align="center">
	
		<h1>Add book to Order ID : ${order.orderId}</h1>
		
		<form action="add_book_to_order" method="post">
		
			<table>
				<tr>
					<td>Select a book: </td>
					<td>
						<select name="bookId">
						
							<c:forEach items="${listBook}" var="book" varStatus="status">
								<option value="${book.bookId}">${book.title} - ${book.author}</option>
							</c:forEach>
							
						</select>
					</td>
				</tr>
				<tr><td>&nbsp;&nbsp;</td></tr>
				<tr>
					<td>Quantity</td>
					<td>
						<select name="quantity" width="40">
						
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							
						</select>
					</td>
				</tr>
				<tr><td>&nbsp;&nbsp;</td></tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit"  class="button green" value="Add"/>&nbsp;&nbsp;&nbsp;
						<input type="button" id="buttonCancel" class="button red" value="Cancel" onclick="javascript:self.close();"/>		
					</td>
				</tr>
				
			</table>
			
		</form>
		
	</div>
	
</body>
</html>