package com.bookstore.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bookstore.entities.Users;

public class UserDao extends JpaDao<Users> implements GenericDao<Users>{

	public UserDao() {

	}

	@Override
	public Users create(Users user) {
		return super.create(user);
	}

	@Override
	public Users update(Users user) {
		return super.update(user);
	}

	@Override
	public Users get(Object userId) {
		return super.find(Users.class, userId);
	}
	
	public Users findByEmail(String email){
		 List<Users> listUsers = super.findWithNamedQuery("Users.findByEmail", "email", email);
		 
		 if(listUsers != null && listUsers.size() > 0) {
			 return listUsers.get(0);
		 }
		 
		 return null;
	}

	@Override
	public void delete(Object userId) {
		super.delete(Users.class, userId);
		
	}

	@Override
	public List<Users> listAll() {
		return super.findWithNamedQuery("Users.findAll");
	}

	@Override
	public long count() {
		return super.countWithNamedQuery("Users.countAll");
	}
	
	public boolean checkLogin(String email, String password){
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("email", email);
		parameters.put("password", password);
		
		List<Users> listUsers = super.findWithNamedQuery("Users.checkLogin", parameters);
		
		if(listUsers.size() == 1) {
			return true;
		}
		
		return false;
	}

}
