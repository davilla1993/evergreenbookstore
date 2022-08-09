package com.bookstore.controllers.frontend;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.bookstore.dao.BookDao;
import com.bookstore.entities.Book;

@WebServlet("")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public HomeServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BookDao bookDao = new BookDao();
		
/*		List<Book> listNewBooks = bookDao.listNewBooks();
*/		List<Book> listBestSellingBooks = bookDao.listBestSellingBooks();
		List<Book> listFavouredBooks = bookDao.listMostFavouredBooks();
		
/*		request.setAttribute("listNewBooks", listNewBooks);
*/		request.setAttribute("listBestSellingBooks", listBestSellingBooks);
		request.setAttribute("listFavouredBooks", listFavouredBooks);

		
		String homePage = "frontend/index.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(homePage);
		dispatcher.forward(request, response);
	}


}
