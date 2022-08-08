package com.bookstore.services;

import java.io.IOException;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bookstore.controllers.frontend.shoppingCart.ShoppingCart;
import com.bookstore.dao.CustomerDao;
import com.bookstore.dao.OrderDao;
import com.bookstore.entities.Book;
import com.bookstore.entities.BookOrder;
import com.bookstore.entities.Customer;
import com.bookstore.entities.OrderDetail;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.ShippingAddress;

public class OrderServices {

	private HttpServletRequest request;
	private HttpServletResponse response;
	OrderDao orderDao;
	CustomerDao customerDao;
	
	public OrderServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
		orderDao = new OrderDao();
		customerDao = new CustomerDao();
	}


	public void listAllOrder(String message) throws ServletException, IOException {
		List<BookOrder> listOrder = orderDao.listAll();
		
		if(message != null){
			request.setAttribute("message", message);
		}
		
		request.setAttribute("listOrder", listOrder);
		
		String listPage = "order_list.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
		dispatcher.forward(request, response);
	}
	
	public void listAllOrder() throws ServletException, IOException {
		listAllOrder(null);
	}


	public void viewOrderDetailForAdmin() throws ServletException, IOException {
		int orderId = Integer.parseInt(request.getParameter("id"));
		
		BookOrder order = orderDao.get(orderId);
		request.setAttribute("order", order);
		
		String detailPage = "order_detail.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(detailPage);
		dispatcher.forward(request, response);
	}
	
	public void showOrderDetailForCustomer() throws ServletException, IOException {
		
		int orderId = Integer.parseInt(request.getParameter("id"));
		
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer"); 
		
		BookOrder order = orderDao.get(orderId, customer.getCustomerId());
		request.setAttribute("order", order);
		
		String detailPage = "frontend/order_detail.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(detailPage);
		dispatcher.forward(request, response);
	}


	public void showCheckoutForm() throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("cart");
		
		// tax is 10% of subtotal
		float tax = shoppingCart.getTotalAmount() * 0.1f;
		
		// shipping fee is 1.0 USD per copy
		float shippingFee = shoppingCart.getTotalQuantity() * 1.0f;
		
		float total = shoppingCart.getTotalAmount() + tax + shippingFee; 
		
		session.setAttribute("tax", tax);
		session.setAttribute("shippingFee", shippingFee);
		session.setAttribute("total", total);
		
		CommonUtility.generateCountryList(request);
		
		String checkOutPage = "frontend/checkout.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(checkOutPage);
		dispatcher.forward(request, response);
	}

	private BookOrder readOrderInfo(){
		
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String phone = request.getParameter("phone");
		String addressLine1 = request.getParameter("address1");
		String addressLine2 = request.getParameter("address2");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zipcode = request.getParameter("zipCode");
		String country = request.getParameter("country");
		String paymentMethod = request.getParameter("paymentMethod");
		
		BookOrder order = new BookOrder();
		order.setFirstname(firstname);
		order.setLastname(lastname);
		order.setPhone(phone);
		order.setAddressLine1(addressLine1);
		order.setAddressLine2(addressLine2);
		order.setCity(city);
		order.setState(state);
		order.setCountry(country);
		order.setZipcode(zipcode);
		order.setPaymentMethod(paymentMethod);
		
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		order.setCustomer(customer);
		
		ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("cart");
		Map<Book, Integer> items = shoppingCart.getItems();
		
		Iterator<Book> iterator = items.keySet().iterator();
		
		 Set<OrderDetail> orderDetails = new HashSet<>();
		 
		 while(iterator.hasNext()){
			Book book = iterator.next();
			Integer quantity = items.get(book);
			float subtotal = quantity * book.getPrice();
			
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setBook(book);
			orderDetail.setBookOrder(order);
			orderDetail.setQuantity(quantity);
			orderDetail.setSubtotal(subtotal);
			
			orderDetails.add(orderDetail);
			
		 }
		 
		 order.setOrderDetails(orderDetails);
		 
		 float tax = (float) session.getAttribute("tax");
		 float shippingFee = (float) session.getAttribute("shippingFee");
		 float total = (float) session.getAttribute("total");
		 
		 order.setSubtotal(shoppingCart.getTotalAmount());
		 order.setTax(tax);
		 order.setShippingFee(shippingFee);
		 order.setTotal(total);
		 
		 return order;
	}
	

	public void listOrderByCustomer() throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		List<BookOrder> listOrders = orderDao.listByCustomer(customer.getCustomerId());
		
		request.setAttribute("listOrders", listOrders);
		
		String historyPage = "frontend/order_list.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(historyPage);
		dispatcher.forward(request, response);
		
		
	}


	public void showEditOrderForm() throws ServletException, IOException {
		
		Integer orderId = Integer.parseInt(request.getParameter("id"));
		
		HttpSession session = request.getSession();
		
		Object isPendingBook = session.getAttribute("NewBookPendingToAddToOrder");
		
		if(isPendingBook == null){
			
			BookOrder order = orderDao.get(orderId);
			session.setAttribute("order", order);
			
		} else {
			session.removeAttribute("NewBookPendingToAddToOrder");
		}
		
		CommonUtility.generateCountryList(request);
		
		String editPage = "order_form.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(editPage);
		dispatcher.forward(request, response);
	}


	public void updateOrder() throws ServletException, IOException {
		HttpSession session = request.getSession();
		BookOrder order = (BookOrder) session.getAttribute("order");
		
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String phone = request.getParameter("phone");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zipcode = request.getParameter("zipcode");
		String country = request.getParameter("country");
		
		float shippingFee = Float.parseFloat(request.getParameter("shippingFee"));
		float tax = Float.parseFloat(request.getParameter("tax"));
		
		String paymentMethod = request.getParameter("paymentMethod");
		String orderStatus = request.getParameter("orderStatus");
		
		order.setFirstname(firstname);
		order.setLastname(lastname);
		order.setPhone(phone);
		order.setAddressLine1(address1);
		order.setAddressLine2(address2);
		order.setCity(city);
		order.setState(state);
		order.setZipcode(zipcode);
		order.setCountry(country);
		order.setShippingFee(shippingFee);
		order.setTax(tax);
		order.setPaymentMethod(paymentMethod);
		order.setStatus(orderStatus);
		
		String[] arrayBookId = request.getParameterValues("bookId");
		String[] arrayPrice = request.getParameterValues("price");
		String[] arrayQuantity = new String[arrayBookId.length];
		
		for(int i=1; i<= arrayQuantity.length; i++){
			arrayQuantity[i-1] = request.getParameter("quantity" + i);
		}
		
		Set<OrderDetail> orderDetails = order.getOrderDetails();
		orderDetails.clear();
		
		float totalAmount = 0.0f;
		
		for(int i=0; i<arrayBookId.length; i++){
			int bookId = Integer.parseInt(arrayBookId[i]);
			int quantity = Integer.parseInt(arrayQuantity[i]);
			float price = Float.parseFloat(arrayPrice[i]);
			
			float subtotal = price * quantity;
			
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setBook(new Book(bookId));
			orderDetail.setQuantity(quantity);
			orderDetail.setSubtotal(subtotal);
			orderDetail.setBookOrder(order);
			
			orderDetails.add(orderDetail);
			
			totalAmount += subtotal;
		}
		
		order.setSubtotal(totalAmount);
		totalAmount += shippingFee;
		totalAmount += tax;
		
		order.setTotal(totalAmount);
		
		orderDao.update(order);
		
		String message = "<span id='green'>" + "The order with ID " + order.getOrderId() + " has been updated sucessfully"  + "</span>";
		listAllOrder(message);
	}


	public void deleteOrder() throws ServletException, IOException {
		Integer orderId = Integer.parseInt(request.getParameter("id"));
		orderDao.delete(orderId);
		
		String message = "<span id='green'>" + "The order with ID " + orderId + " has been deleted sucessfully"  + "</span>";
		listAllOrder(message);
	}
	
	public void placeOrderCOD(BookOrder order) throws ServletException, IOException{
		 
		saveOrder(order);
		
		 String message = "Thank you. Your order has Been received. We will deliver your books within a few days";
		 
		 request.setAttribute("message", message);
		 
		 String messagePage = "frontend/message.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(messagePage);
		dispatcher.forward(request, response);
	}


	private Integer saveOrder(BookOrder order) {
		
		BookOrder savedOrder = orderDao.create(order);
		 
		 ShoppingCart shoppingCart = (ShoppingCart) request.getSession().getAttribute("cart");
		 shoppingCart.clear();
		 
		 return savedOrder.getOrderId();
	}
	

	public void placeOrder() throws ServletException, IOException {
		
		String paymentMethod = request.getParameter("paymentMethod");
		BookOrder order = readOrderInfo();
		
		if(paymentMethod.equals("paypal")){
			
			// paypal
			PaymentServices paymentServices = new PaymentServices(request, response);
			request.getSession().setAttribute("order4Paypal", order);
			
			paymentServices.authorizePayment(order);
			
		} else {
			
			// Cash on Delivery
			placeOrderCOD(order);
		}
		
	}

	public Integer placeOrderPaypal(Payment payment) {
		
		BookOrder order = (BookOrder) request.getSession().getAttribute("order4Paypal");
		ItemList itemList = payment.getTransactions().get(0).getItemList();
		ShippingAddress shippingAddress = itemList.getShippingAddress();
		String shippingPhoneNumber = itemList.getShippingPhoneNumber();
		
		String recipientName = shippingAddress.getRecipientName();
		String[] names = recipientName.split(" ");
		
		order.setFirstname(names[0]);
		order.setLastname(names[1]);
		order.setAddressLine1(shippingAddress.getLine1());
		order.setAddressLine2(shippingAddress.getLine2());
		order.setCity(shippingAddress.getCity()); 
		order.setState(shippingAddress.getState());
		order.setCountry(shippingAddress.getCountryCode());
		order.setPhone(shippingPhoneNumber);
		
		return saveOrder(order);
	}
	
}
