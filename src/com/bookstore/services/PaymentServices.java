package com.bookstore.services;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.entities.Book;
import com.bookstore.entities.BookOrder;
import com.bookstore.entities.Customer;
import com.bookstore.entities.OrderDetail;
import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Details;
import com.paypal.api.payments.Item;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.ShippingAddress;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;

public class PaymentServices {
	
	private static final String CLIENT_ID = "AYNKdFcBMKjxbKcD74Nn-jbUipvKjulmHpjV_1aWx413Qn0XdIsDJ_LEgNRPMdpr3Yty5--cGTmmP52h";
	private static final String CLIENT_SECRET = "EBfPOrzmHa2Op8jNnb-d5XA3nNLm4DuFI2X43nOSoN_2DAkonfi5X-wZ12FWak1__CXD4OvYwWZJybq3";
	private String mode = "sandbox";
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	DecimalFormatSymbols symbols = new DecimalFormatSymbols(Locale.US);
	DecimalFormat formatter = new DecimalFormat("#.##", symbols);
	
	public PaymentServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
	}
	
	public void authorizePayment(BookOrder order) throws ServletException, IOException{
		
		// Get payer information
		Payer payer = getPayerInformation(order);
		
		// Get redirect URLs
		RedirectUrls redirectUrls = getRedirectURLs();
						
		
		// Request payment
		List<Transaction> transactions = getTransactionInformation(order);

		Payment requestPayment = new Payment(); 
		requestPayment.setPayer(payer)
					  .setRedirectUrls(redirectUrls)
					  .setIntent("authorize")
					  .setTransactions(transactions);
		
		System.out.println("=========REQUEST PAYMENT==============");
		System.out.println(requestPayment);
		
		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);
		
		try {
			
			Payment authorizedPayment = requestPayment.create(apiContext);
			
			System.out.println("=======AUTHORIZED PAYMENT=========");
			System.out.println(authorizedPayment);
			
			String approvalURL = getApprovalURL(authorizedPayment);
			response.sendRedirect(approvalURL);
			
		} catch (PayPalRESTException e) {

			e.printStackTrace();
			throw new ServletException("Error in authorizing payment");
		}
		
		
		
		// Get approval link
		
		// Redirect to Paypal's payment page
	}
	
	private String getApprovalURL(Payment authorizedPayment) {
		
		String approvalURL = null;
		
		List<Links> links =  authorizedPayment.getLinks();
		
		for(Links link : links) {
			
			if(link.getRel().equalsIgnoreCase("approval_url")) {
				approvalURL = link.getHref();
				break;
			}
		}
		return approvalURL;
	}

	private Payer getPayerInformation(BookOrder order){
		
		// Get payer information
		
		Payer payer = new Payer();
		payer.setPaymentMethod("paypal");
				
		Customer customer = order.getCustomer();
				
		PayerInfo payerInfo = new PayerInfo();
		payerInfo.setFirstName(customer.getFirstname());
		payerInfo.setLastName(customer.getLastname());
		payerInfo.setEmail(customer.getEmail());
		payer.setPayerInfo(payerInfo);
		
		return payer;
	}
	
	private RedirectUrls getRedirectURLs(){
		
		// Get redirect URLs
		
		String requestURL = request.getRequestURL().toString();
		String requestURI = request.getRequestURI();
		String baseURL = requestURL.replace(requestURI, "").concat(request.getContextPath());
				
		RedirectUrls redirectUrls = new RedirectUrls();
		String cancelUrl = baseURL.concat("/view_cart");
		String returnUrl = baseURL.concat("/review_payment");
				
		System.out.println("Return URL : " + returnUrl);
		System.out.println("Cancel URL : " + cancelUrl);
		
		redirectUrls.setCancelUrl(cancelUrl);
		redirectUrls.setReturnUrl(returnUrl);	
		
		return redirectUrls;
	}
	
	
	private Amount getAmountDetails(BookOrder order){
		
		// Get amount details
		
		Details details = new Details();
		details.setShipping(formatter.format(order.getShippingFee()));
		details.setTax(formatter.format(order.getTax()));
		details.setSubtotal(formatter.format(order.getSubtotal()));
				
		Amount amount = new Amount();
		amount.setCurrency("USD");
		amount.setDetails(details);
		amount.setTotal(formatter.format(order.getTotal()));
		
		return amount;
	}
	
	private ShippingAddress getRecipientInformation(BookOrder order){
		
		// Shipping address (recipient info)
		
		ShippingAddress shippingAddress = new ShippingAddress();
		String recipientName = order.getFirstname() + " " + order.getLastname();
		
		shippingAddress.setRecipientName(recipientName)
						.setPhone(order.getPhone())
						.setLine1(order.getAddressLine1())
						.setLine2(order.getAddressLine2())
						.setCity(order.getCity())
						.setState(order.getState())
						.setCountryCode(order.getCountry())
						.setPostalCode(order.getZipcode());
		
			return shippingAddress;

	}
	
	private List<Transaction> getTransactionInformation(BookOrder order){
		
		// Get transaction details

		Transaction transaction = new Transaction();
		transaction.setDescription("Books ordered on Evergreen Books");
		Amount amount = getAmountDetails(order);
		transaction.setAmount(amount);
		
		ItemList itemList = new ItemList();
		ShippingAddress shippingAddress = getRecipientInformation(order);
		itemList.setShippingAddress(shippingAddress);
		
		List<Item> paypalItems = new ArrayList<>();
		Iterator<OrderDetail> iterator = order.getOrderDetails().iterator();
		
		while(iterator.hasNext()){
			OrderDetail orderDetail = iterator.next();
			Book book = orderDetail.getBook();
			Integer quantity = orderDetail.getQuantity();
			
			Item paypalItem = new Item();
			paypalItem.setCurrency("USD")
					  .setName(book.getTitle())
					  .setQuantity(String.valueOf(quantity))
					  .setPrice(formatter.format(book.getPrice()));
			
			paypalItems.add(paypalItem);
						
		}
		
		itemList.setItems(paypalItems);
		transaction.setItemList(itemList);
		
		List<Transaction> listTransaction = new ArrayList<>();
		listTransaction.add(transaction);
		
		return listTransaction;
		
	}

	public void reviewPyament() throws ServletException, IOException {
		String paymentId = request.getParameter("paymentId");
		String payerId = request.getParameter("PayerID");
		
		if(paymentId == null || payerId == null) {
			throw new ServletException("Error in displaying payment review");
		}
		
		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);
		
		try {
			
			Payment payment = Payment.get(apiContext, paymentId);
			
			PayerInfo payerInfo = payment.getPayer().getPayerInfo();
			Transaction transaction = payment.getTransactions().get(0);
			ShippingAddress shippingInfoAddress =  transaction.getItemList().getShippingAddress();
			
			request.setAttribute("payer", payerInfo);
			request.setAttribute("recipient", shippingInfoAddress);
			request.setAttribute("transaction", transaction);

			String reviewPage = "frontend/review_payment.jsp?paymentId=" + paymentId + "&PayerID=" + payerId;
			RequestDispatcher dispatcher = request.getRequestDispatcher(reviewPage);
			dispatcher.forward(request, response);
			
		} catch (PayPalRESTException | IOException e) {
			
			e.printStackTrace();
			throw new ServletException("Error in getting payment details from Paypal");
		}
	}

	public Payment executePayment() throws PayPalRESTException {
		
		String paymentId = request.getParameter("paymentId");
		String payerId = request.getParameter("PayerID");
		
		PaymentExecution paymentExecution = new PaymentExecution();  
		paymentExecution.setPayerId(payerId);
		
		Payment payment = new Payment().setId(paymentId);
		
		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);
		
		return payment.execute(apiContext, paymentExecution);
	}
		
}
