package com.bookstore.controllers.admin.users;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.security.HashGenerationException;
import com.bookstore.services.UserServices;


@WebServlet("/admin/create_user")
public class CreateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public CreateUserServlet() {
        super();
        
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		UserServices userServices = new UserServices(request, response);
		try {
			
			userServices.createUser();
			
		} catch (HashGenerationException e) {
			
			System.out.println("Problem from CreateUserServlet");
			e.printStackTrace();
		}
		
	}

}
