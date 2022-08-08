package com.bookstore.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.bookstore.entities.Book;

public class BookDao extends JpaDao<Book> implements GenericDao<Book>{

	public BookDao() {
		
	}

	@Override
	public Book create(Book book) {
		book.setLastUpdateTime(new Date());
		
		return super.create(book);
	}

	@Override
	public Book update(Book book) {
		book.setLastUpdateTime(new Date());
		
		return super.update(book);
	}

	@Override
	public Book get(Object bookId) {
		return super.find(Book.class, bookId);
	}

	@Override
	public void delete(Object bookId) {
		super.delete(Book.class, bookId);
		
	}

	@Override
	public List<Book> listAll() {
		return super.findWithNamedQuery("Book.findAll");
	}
	
	public Book findByTitle(String title){
		List<Book> result = super.findWithNamedQuery("Book.findByTitle", "title", title);
		
		if(!result.isEmpty()) {
			return result.get(0);
		}
		
		return null;
	}

	public List<Book> listByCategory(int categoryId) {
		
		return super.findWithNamedQuery("Book.findByCategory", "catId", categoryId);
	}
	
	public List<Book> listNewBooks(){
		return super.findWithNamedQuery("Book.listNew", 0, 6);
		
	}
	
	public List<Book> search(String keyword){
		return super.findWithNamedQuery("Book.search", "keyword", keyword);
	}

	
	@Override
	public long count() {
		return super.countWithNamedQuery("Book.countAll");
	}
	
	
	public long countByCategory(int categoryId){
		return super.countWithNamedQuery("Book.countByCategory", "catId", categoryId);
	}
	
	
	public List<Book> listBestSellingBooks(){
		return super.findWithNamedQuery("OrderDetail.bestSelling", 0, 4);
	}
	
	public List<Book> listMostFavouredBooks(){
		List<Book> mostFavouredBooks = new ArrayList<>();
		
		List<Object[]> result = super.findWithNamedQueryObjects("Review.mostFavouredBooks", 0, 4);
		
		if(!result.isEmpty()){
			for(Object[] elements : result){
				Book book = (Book) elements[0];
				mostFavouredBooks.add(book);
			}
		}
		
		return mostFavouredBooks;
	}


}
