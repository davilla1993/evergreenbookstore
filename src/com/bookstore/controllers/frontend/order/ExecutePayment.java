package com.bookstore.controllers.frontend.order;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bookstore.services.OrderServices;
import com.bookstore.services.PaymentServices;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;


@WebServlet("/execute_payment")
public class ExecutePayment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public ExecutePayment() {
        super();
        
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PaymentServices paymentServices = new PaymentServices(request, response);
		
		try {
			Payment payment = paymentServices.executePayment();
			
			OrderServices orderServices = new OrderServices(request, response);
			Integer orderId = orderServices.placeOrderPaypal(payment);
			
			response.getWriter().print("PAYMENT SUCCESSFUL. ORDER: " + orderId);
			
			HttpSession session = request.getSession();
			session.setAttribute("orderId", orderId);
			
			PayerInfo payerInfo = payment.getPayer().getPayerInfo();
			Transaction transaction = payment.getTransactions().get(0);
			
			session.setAttribute("payer", payerInfo);
			session.setAttribute("transaction", transaction);

			String receiptPage = "frontend/payment_receipt.jsp";
			RequestDispatcher dispatcher = request.getRequestDispatcher(receiptPage);
			dispatcher.forward(request, response);
			
		} catch (PayPalRESTException e) {
			e.printStackTrace();
			throw new ServletException("Error in executing payment.");
		}
	}

}
