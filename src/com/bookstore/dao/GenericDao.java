package com.bookstore.dao;

import java.util.List;

public interface GenericDao<E> {
	
	public E create(E e);
	
	public E update(E e);
	
	public E get(Object id);
	
	public void delete(Object id);
	
	public List<E> listAll();
	
	public long count();
}
