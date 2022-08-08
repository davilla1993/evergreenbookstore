package com.bookstore.services;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bookstore.dao.UserDao;
import com.bookstore.entities.Users;
import com.bookstore.security.HashGenerationException;
import com.bookstore.security.HashGeneratorUtils;

public class UserServices {

	private HttpServletRequest request;
	private HttpServletResponse response;
	private UserDao userDao;
	
	public UserServices(HttpServletRequest request, HttpServletResponse response) {
		
		this.request = request;
		this.response = response;
		
		userDao = new UserDao();
	}
	
	public void listUser(String message)  throws ServletException, IOException {
		
		List<Users> listUsers = userDao.listAll();
		
		request.setAttribute("listUsers", listUsers);
		
		if(message != null) {
			request.setAttribute("message", message);
		}
		
		String listPage = "user_list.jsp";
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
		dispatcher.forward(request, response);
		
	}
	
   public void listUser() throws ServletException, IOException {
	   
	   listUser(null);
   }
	
	public void createUser() throws ServletException, IOException, HashGenerationException {
		
		String email = request.getParameter("email");
		String fullName = request.getParameter("fullname");
		String password = HashGeneratorUtils.generateSHA256(request.getParameter("password"));
		
		Users existUser = userDao.findByEmail(email);
		
		if(existUser != null) {
			String message = "The user you are trying to create already exists";
			
			request.setAttribute("message", message);
			RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
			dispatcher.forward(request, response);
			
		} else {
			
			
		
		Users newUser = new Users(email, password, fullName);
		userDao.create(newUser);
		listUser("New user created successfully");
		
		}
	}

	public void editUser() throws ServletException, IOException {
		
		int userId = Integer.parseInt(request.getParameter("id"));	
		
		Users user = userDao.get(userId);
		request.setAttribute("user", user);

		String editPage = "user_form.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(editPage);
		dispatcher.forward(request, response);
		
	}

	public void updateUser() throws ServletException, IOException, HashGenerationException {
		
		int userId = Integer.parseInt(request.getParameter("userId"));
		String email = request.getParameter("email");
		String fullName = request.getParameter("fullname");
		String password = HashGeneratorUtils.generateSHA256(request.getParameter("password"));
		
		Users userById = userDao.get(userId);
		Users userByEmail = userDao.findByEmail(email);
		
		if(userByEmail != null && userByEmail.getUserId() != userById.getUserId()) {
			
			String message = "Sorry, this email is already in use by another user";
			request.setAttribute("message", message);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
			dispatcher.forward(request, response);
			
		} else {
		
		Users user = new Users(userId, email, password, fullName);
		userDao.update(user);
		
		String message = "User has been updated successfully";
		listUser(message);
		
		}
				
	}

	public void deleteUser() throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("id"));
		userDao.delete(userId);
		
		String message = "User has been deleted successfully";
		listUser(message);
	}

	public void login() throws ServletException, IOException, HashGenerationException {
		String email = request.getParameter("email");
		String password = HashGeneratorUtils.generateSHA256(request.getParameter("password"));
		
		System.out.println("--------------------------------------------------------------------------------");
		System.out.println(HashGeneratorUtils.generateSHA256("123"));
		System.out.println("--------------------------------------------------------------------------------");

		
		boolean loginResult = userDao.checkLogin(email, password);
		
		if(loginResult) {
			
			request.getSession().setAttribute("useremail", email);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/");
			dispatcher.forward(request, response);
			
		} else {
			
			String message = "Login Failed. Email or password is incorrect.";
			request.setAttribute("message", message);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}
	}

	public void logout() throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.removeAttribute("useremail");
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);
		
	}		
}
 