<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="css/book_detail.css"/>
	
	<script type="text/javascript" src="js/jquery-3.4.0.min.js"></script>
	
	<title>${book.title} - Online Books Store</title>
</head>
<body>
	<jsp:directive.include file="header.jsp"/>
	
	<div class="center">
	
		<table class="book">
			<tr>
				<td colspan="3" class="left">
					<p id="book-title">${book.title}</p> by <span id="author">${book.author}</span>
				</td>
			</tr>
			
			<tr>
				<td rowspan="2">
					<img src="data:image/jpg;base64,${book.base64Image}" class="image"/>	
				</td>
				<td class="top left">
					<jsp:directive.include file="book_rating.jsp"/>
					<a href="#reviews">${fn:length(book.reviews)} Reviews</a>
				</td>
				<td  id="price" rowspan="2">
					<h2>$${book.price}</h2> 
					<br/>
					<button id="buttonAddToCart">Add to cart</button>
				</td>
			</tr>
			<tr>
				<td id="description">
					${book.description}
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td><h3>Customer Reviews</h3></td>
				<td colspan="2">
					<button id="buttonWriteReview" class="btn-center">Write a customer review</button>
				</td>
			</tr>
			<tr>
				<td colspan="3">
					<table border="0">
						<c:forEach items="${book.reviews}" var="review">
							<tr>
								<td>
									<c:forTokens items="${review.stars}" delims="," var="star">
										<c:if test="${star eq 'on'}">
											<img src="images/rating_on.png" />
										</c:if>
																
										<c:if test="${star eq 'half'}">
											<img src="images/rating_half.png" />
										</c:if>
									</c:forTokens>
									- <b>${review.headline}</b>
								</td>
							</tr>
							<tr>
								<td>by ${review.customer.fullname} on ${review.reviewTime}</td>
							</tr>
							<tr><td><i>${review.comment}</i></td></tr>
						</c:forEach>
					</table>
				</td>
			</tr>		
		</table>	
	</div>
	
		<jsp:directive.include file="footer.jsp"/>
	
		<script type="text/javascript">
		
		$(document).ready(function(){

			$("#buttonWriteReview").click(function(){
				window.location = "write_review?book_id=" + ${book.bookId};
			});
			
			$("#buttonAddToCart").click(function(){
				window.location = "add_to_cart?book_id=" + ${book.bookId};
			});
		});
			
			
		</script>
</body>
</html>