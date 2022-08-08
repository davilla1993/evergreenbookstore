
				function showAddBookPopup(){
					var width = 700;
					var height = 300;
					var left = (screen.width - width)/2;
					var top = (screen.height - height)/2;
					
					window.open('add_book_form', '_blank', 'width=' + width + ', height=' + height + ', top=' + top + ', left=' + left);
				}
			
			$(document).ready(function(){
				$("#orderForm").validate({
					rules: {
						firstname: "required",
						lastname: "required",
						phone: "required",
						address1: "required",
						city: "required",
						state: "required",
						zipcode: "required",
						country: "required",
						shippingFee: {
							required:true, number: true, min: 0
						},
						tax: {
							required:true, number:true, min: 0
						},
						
						<c:forEach items="${order.orderDetails}" var="book" varStatus="status">
								quantity${status.index + 1}: {
							required: true,
							number: true,
							min: 1
						},	 
						</c:forEach>
					},
					
					messages: {
						firstname: "You must enter recipient first name",
						lastname: "You must enter recipient last name",
						phone: "You must enter recipient phone number",
						address1: "You must enter recipient address",
						city: "You must enter recipient city",
						state: "You must enter recipient state",
						zipcode: "You must enter recipient zipcode",
						country: "You must enter recipient zipode",
						shippingFee: {
							required: "You must enter shipping fee", 
							number: "Shipping fee must be a number", 
							min: "Shipping fee must be  greater than 0"
						},
						tax: {
							required: "You must enter the tax amount", 
							number: "The tax must be a number", 
							min: "The tax must be equal or greater than 0"
						},
						<c:forEach items="${order.orderDetails}" var="book" varStatus="status">
							quantity${status.index + 1}: {	
							required: "Please enter quantity",
							number: "Quantity must be a number",
							min: "Quantity must be equal or greater than 0"
						
						},
						</c:forEach>		
					},
				
				});	
			});
		