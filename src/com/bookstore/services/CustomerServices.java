package com.bookstore.services;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bookstore.dao.CustomerDao;
import com.bookstore.entities.Customer;
import com.bookstore.security.HashGenerationException;
import com.bookstore.security.HashGeneratorUtils;

public class CustomerServices {

	private HttpServletRequest request;
	private HttpServletResponse response;
	CustomerDao customerDao;
	
	
	public CustomerServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
		customerDao = new CustomerDao();
	}


	public void listCustomer(String message) throws ServletException, IOException {
		List<Customer> listCustomer = customerDao.listAll();
		
		if(message != null) {
			request.setAttribute("message", message);
		}
		
		request.setAttribute("listCustomer", listCustomer);
		
		String listPage = "customer_list.jsp";
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
		dispatcher.forward(request, response);
	}
	
	public void listCustomer() throws ServletException, IOException {
		listCustomer(null);
	}
	
	public void customerFieldsFromForm(Customer customer) throws HashGenerationException{
		
		String email = request.getParameter("email");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String password = HashGeneratorUtils.generateSHA256(request.getParameter("password"));
		String phone = request.getParameter("phone");
		String addressLine1 = request.getParameter("address1");
		String addressLine2 = request.getParameter("address2");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zipCode = request.getParameter("zipCode");
		String country = request.getParameter("country");
			
		if(email != null && !email.equals("")){
			customer.setEmail(email);
		}
		
		if(password != null && !password.equals("")){
			customer.setPassword(password);
		}
		customer.setFirstname(firstname);
		customer.setLastname(lastname);
		customer.setPhone(phone);
		customer.setAddressLine1(addressLine1);
		customer.setAddressLine2(addressLine2);
		customer.setCity(city);
		customer.setState(state);
		customer.setZipcode(zipCode);
		customer.setCountry(country);
		
	}


	public void createCustomer() throws ServletException, IOException, HashGenerationException {
		
		String email = request.getParameter("email");
		Customer existCustomer = customerDao.findByEmail(email);
		
		String message;
		
		if(existCustomer != null) {
			
			message = "<span id='red'>" + "Could not create new customer with the email " + email + " because it already registered by another customer"  + "</span>"; 
			
		} else {
			
			Customer newCustomer = new Customer();
			customerFieldsFromForm(newCustomer);
			customerDao.create(newCustomer);
			
			message = "<span id='green'>" +"New customer has been created successfully" + "</span>";
			
		}
		
		listCustomer(message);
		
	}


	public void editCustomer() throws ServletException, IOException {
		Integer customerId = Integer.parseInt(request.getParameter("id"));
		
		Customer customer = customerDao.get(customerId);
		request.setAttribute("customer", customer);
		
		CommonUtility.generateCountryList(request);
		
		String editPage = "customer_form.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(editPage);
		dispatcher.forward(request, response);
	}


	public void updateCustomer() throws ServletException, IOException, HashGenerationException {
		
		Integer customerId = Integer.parseInt(request.getParameter("customerId"));
		String email = request.getParameter("email");
		
		Customer customerById = customerDao.get(customerId);
		Customer customerByEmail = customerDao.findByEmail(email);
		
		String message;
		
		if(customerByEmail != null && customerByEmail.getCustomerId() != customerById.getCustomerId()){
			
			message =  "<span id='red'>" + "Could not update the customer because there's an existing customer having the same email"  + "</span>";
			
		} else {
			
			customerFieldsFromForm(customerById);
			customerDao.update(customerById);
			
			message = "<span id='green'>" +"Customer has been updated successfully" + "</span>";
		}
		
		listCustomer(message);

	}
	
	public void showCustomerRegistrationForm() throws ServletException, IOException{
		
		CommonUtility.generateCountryList(request);
		
		String registerForm = "frontend/register_form.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(registerForm);
		dispatcher.forward(request, response);
	}
	
	
	public void registerCustomer() throws ServletException, IOException, HashGenerationException {
		
		String email = request.getParameter("email");
		Customer existCustomer = customerDao.findByEmail(email);
		
		String message;
		
		if(existCustomer != null) {
			
			message = "<span id='red'>" + "Could not create new account with the email " + email + " because it already registered by another customer" + "</span>"; 
			
		} else {
			
			Customer newCustomer = new Customer();
			customerFieldsFromForm(newCustomer);
			customerDao.create(newCustomer);
			
			message = "<span id='green'>" + "You have registered successfully ! Thank you." + "</span>" + "<a href='login' class='button'>Click here</a> to login";
			
		}
		
		
		String messagePage = "frontend/message.jsp";
		request.setAttribute("message", message);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(messagePage);
		dispatcher.forward(request, response);
		
	}


	public void deleteCustomer() throws ServletException, IOException {
		Integer customerId = Integer.parseInt(request.getParameter("id"));
		customerDao.delete(customerId);
		
		String message = "Customer has been removed successfully";
		listCustomer(message);
	}


	public void showLogin() throws ServletException, IOException {
		
		String loginPage = "frontend/login.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(loginPage);
		dispatcher.forward(request, response);		
	}


	public void doLogin() throws ServletException, IOException, HashGenerationException {
		String email = request.getParameter("email");
		String password = HashGeneratorUtils.generateSHA256(request.getParameter("password"));
		
		Customer customer = customerDao.checkLogin(email, password);
		
		if(customer  == null) {
			
			String message = "<span id='red'>" + "Login fialed. Email or password incorrect" + "</span>";
			request.setAttribute("message", message);
			
			showLogin();
			
		} else {
			
			HttpSession session = request.getSession();
			session.setAttribute("loggedCustomer", customer);

			Object objRedirectURL = session.getAttribute("redirectURL");
			
			if(objRedirectURL != null){
				
				String redirectURL = (String) objRedirectURL;
				session.removeAttribute("redirectURL");
				response.sendRedirect(redirectURL);
				
			} else {
				
			showCustomerProfile();	
			
			}
		}
	}


	public void logout() throws IOException {
		request.getSession().removeAttribute("loggedCustomer");
		
		response.sendRedirect(request.getContextPath());
	}

	public void showCustomerProfile() throws ServletException, IOException {
		
		String profilePage = "frontend/customer_profile.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(profilePage);
		dispatcher.forward(request, response);
	}


	public void showCustomerProfileEditForm() throws ServletException, IOException {
		
		CommonUtility.generateCountryList(request);
		
		String editPage = "frontend/edit_profile.jsp";
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(editPage);
		dispatcher.forward(request, response);
		
	}


	public void updateCustomerProfile() throws ServletException, IOException, HashGenerationException {
		Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");
		customerFieldsFromForm(customer);
		customerDao.update(customer);
		
		showCustomerProfile();
	}


	public void newCustomer() throws ServletException, IOException {
		
		CommonUtility.generateCountryList(request);
		
		String customerForm = "customer_form.jsp";
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(customerForm);
		dispatcher.forward(request, response);
	}
	
}
