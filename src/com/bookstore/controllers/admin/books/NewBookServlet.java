package com.bookstore.controllers.admin.books;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.services.BookServices;

@WebServlet("/admin/new_book")
public class NewBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public NewBookServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BookServices bookServices = new BookServices(request, response);
		bookServices.showBookNewForm();
	}


}
