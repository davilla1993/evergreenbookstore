<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div align = "center">
	<div>
		<a href="${pageContext.request.contextPath}"><img src="images/BookstoreLogo.png"/></a>
	</div>
	
	<div>
		<form action="search" method="get">
			<input type="text" name="keyword" size="50"/>
			<input type="submit" value="Search"/>
		</form>
		<div style="height:50px"></div>
		
		<c:if test="${loggedCustomer == null}">
			<a href="login">Sign In</a> |
			<a href="register">Register</a> |
			<a href="view_cart">Cart</a>		
		</c:if>
		
		<c:if test="${loggedCustomer != null}">
			<a href="view_profile">Welcome, ${loggedCustomer.lastname}</a> |
			<a href="view_orders">My Orders</a> |
			<a href="view_cart">Cart</a> |
			<a href="logout">Logout</a> 
		</c:if>
		
	</div>&nbsp;&nbsp;
	
	<div> 
		<c:forEach var="category" items="${listCategory}" varStatus="status">
		
			<a href="view_category?id=${category.categoryId}">
				<b><c:out value="${category.name}" /></b> 
			</a> 
			
			<c:if test="${not status.last}">
				&nbsp; | &nbsp;
			</c:if>
			
		</c:forEach>
	</div>
</div>