<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
	
		<h2>The book - ${book.title} - has been successfully added to the order ID ${order.orderId}</h2>
		<input type="button" class="button red" value="Close" onclick="javascript:self.close();"/>		
		
	</div>
	
	<script>
		window.onunload = function(){
			window.opener.location.reload();
		}
	</script>
</body>
</html>