package com.bookstore.services;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.BookDao;
import com.bookstore.dao.CategoryDao;
import com.bookstore.entities.Category;

public class CategoryServices {
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	CategoryDao categoryDao;
	
	public CategoryServices(HttpServletRequest request, HttpServletResponse response) {

		this.request = request;
		this.response = response;
		
		categoryDao = new CategoryDao();
	}
	
	public void listCategory(String message) throws ServletException, IOException {
		List<Category> listCategory = categoryDao.listAll();
		
		request.setAttribute("listCategory", listCategory);
		
		if(message != null) {
			request.setAttribute("message", message);
		}
		
		String listPage = "category_list.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
		dispatcher.forward(request, response);
	}
	
	public void listCategory() throws ServletException, IOException {
		listCategory(null);
	}

	public void createCategory() throws ServletException, IOException {
		
		String name= request.getParameter("name");
		Category existCategory = categoryDao.findByName(name);
		
		if(existCategory != null){
			
			String message = "Category you are trying to create already exists.";
			request.setAttribute("message", message);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
			dispatcher.forward(request, response);
			
		} else {
			
			Category newCategory = new Category(name);
			categoryDao.create(newCategory);
			
			listCategory("New category created successfully");
		}
		
	}

	public void editCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("id"));
		
		Category category = categoryDao.get(categoryId);		
		request.setAttribute("category", category);
		
		String editPage = "category_form.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(editPage);
		dispatcher.forward(request, response);
	
		
	}

	public void updateCategory() throws ServletException, IOException {
		
		int categoryId = Integer.parseInt(request.getParameter("categoryId"));
		String categoryName = request.getParameter("name");
				
		Category categoryById = categoryDao.get(categoryId);
		Category categoryByName = categoryDao.findByName(categoryName);
		
		if(categoryByName != null && categoryById.getCategoryId() != categoryByName.getCategoryId()) {
			
			String message = "Could not update, this category already exists !!";
			request.setAttribute("message", message);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
			
			dispatcher.forward(request, response);
			
		} else {
			
			/*Category newCategory = new Category(categoryName);
			categoryDao.update(newCategory);*/
			
			categoryById.setName(categoryName);
			categoryDao.update(categoryById);
			
			String message = "Category has been upadted successfully";
			listCategory(message);
		}

	}

	public void deleteCategory() throws ServletException, IOException {
		
		int categoryId = Integer.parseInt(request.getParameter("id"));
		BookDao bookDao = new BookDao();
		long numOfBooks = bookDao.countByCategory(categoryId);
		String message;
		
		if(numOfBooks > 0) {
			message = "Could not delete this category beccause it contains " + numOfBooks + " books.";
		} else {
		
			categoryDao.delete(categoryId);
			message = "Category has been removed successfully";					
		}
		listCategory(message);

	}
		
}
