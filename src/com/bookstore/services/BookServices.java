package com.bookstore.services;

import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.bookstore.dao.BookDao;
import com.bookstore.dao.CategoryDao;
import com.bookstore.entities.Book;
import com.bookstore.entities.Category;

public class BookServices {

	private HttpServletRequest request;
	private HttpServletResponse response;
	BookDao bookDao;
	CategoryDao categoryDao;
	
	
	public BookServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
		bookDao = new BookDao();
		categoryDao = new CategoryDao();
	}

	public void listBooks(String message) throws ServletException, IOException {
		List<Book> listBooks = bookDao.listAll();
		
		request.setAttribute("listBooks", listBooks);
		
		if(message != null) {
			request.setAttribute("message", message);
		}
		
		String listPage = "book_list.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
		dispatcher.forward(request, response);
	}
	
	public void listBooks() throws ServletException, IOException {
		listBooks(null);
	}
	
	

	public void showBookNewForm() throws ServletException, IOException {
		List<Category> listCategory = categoryDao.listAll();
		request.setAttribute("listCategory", listCategory);
		
		String newPage = "book_form.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(newPage);
		dispatcher.forward(request, response);
		
	}
	
	public void readBookFields(Book book) throws ServletException, IOException{
		
		Integer categoryId =Integer.parseInt(request.getParameter("category"));
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String description = request.getParameter("description");
		String isbn = request.getParameter("isbn");
		float price = Float.parseFloat(request.getParameter("price"));
		
		DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		Date publishDate = null;
		
			try {
				  publishDate = dateFormat.parse(request.getParameter("publishDate"));
				
			} catch (ParseException e) {
				e.printStackTrace();
				throw new ServletException("Error parsing publish date(format is MM/dd/yyyy)");
			} 
			
			
			book.setTitle(title);
			book.setAuthor(author);
			book.setDescription(description);
			book.setIsbn(isbn);
			book.setPublishDate(publishDate);
			book.setPrice(price);
			
			Category category = categoryDao.get(categoryId);
			book.setCategory(category);
			
			Part part = request.getPart("bookImage");
			
			if(part != null && part.getSize() > 0){
				long size = part.getSize();
				byte[] imageBytes = new byte[(int) size];
				
				InputStream inputStream = part.getInputStream();
				inputStream.read(imageBytes);
				inputStream.close();
				
				book.setImage(imageBytes);
			}
	}

	public void createBook() throws ServletException, IOException {
		
		String title = request.getParameter("title");
		
		Book existBook = bookDao.findByTitle(title);
		
		if(existBook != null){
			String message = "The book " + title + " you try to create already exist";
			listBooks(message);
			return;
		}
		
			Book newBook = new Book();
			readBookFields(newBook);
			
			Book createdBook = bookDao.create(newBook);
			
			if(createdBook.getBookId() > 0) {
				
				String message = "A new book has created sucessfully";
				listBooks(message);
	
			}
	}

	public void editBook() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("id"));

		Book existBook = bookDao.get(bookId);
		
		Book book = bookDao.get(bookId);
		List<Category> listCategory = categoryDao.listAll();

		request.setAttribute("book", book);
		request.setAttribute("listCategory", listCategory);
		
		String editPage = "book_form.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(editPage);
		dispatcher.forward(request, response);
		
	}

	public void updateBook() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("bookId"));
		String title = request.getParameter("title");

		
		Book existBook = bookDao.get(bookId);
		Book bookByTitle = bookDao.findByTitle(title);
		
		if(bookByTitle != null && !existBook.equals(bookByTitle)){
			String message = "Could not update book because there's another book having same title";
			listBooks(message);
			return;
		}
		
		readBookFields(existBook);
		
		bookDao.update(existBook);
		String message = "The book has been updated successfully";
		listBooks(message);
		
	}

	public void deleteBook() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("id"));
		
		bookDao.delete(bookId);
		
		String message = "The book has been deleted successfully";
		listBooks(message);
	}

	public void listBooksByCategory() throws ServletException, IOException {
		Integer categoryId = Integer.parseInt(request.getParameter("id"));
		List<Book> listBooks = bookDao.listByCategory(categoryId);
		Category category = categoryDao.get(categoryId);
		
		request.setAttribute("listBooks", listBooks);
		request.setAttribute("category", category);

		String listPage = "frontend/books_list_by_category.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
		dispatcher.forward(request, response);
		
	}

	public void viewBookDetail() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("id"));
		Book book = bookDao.get(bookId);
						
		request.setAttribute("book", book);
		
		String detailPage = "frontend/book_detail.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(detailPage);
		dispatcher.forward(request, response);		
		
	}

	public void search() throws ServletException, IOException {
		String keyword = request.getParameter("keyword");
		
		List<Book> result = null;
		
		if(keyword.equals("")) {
			result = bookDao.listAll();
			
		}else {
			result = bookDao.search(keyword);
		}
		
		request.setAttribute("result", result);
		request.setAttribute("keyword", keyword);

		String resultPage = "frontend/search_result.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(resultPage);
		dispatcher.forward(request, response);		
		
	}
}
