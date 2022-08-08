package com.bookstore.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bookstore.entities.Review;

public class ReviewDao extends JpaDao<Review> implements GenericDao<Review>{

	@Override
	public Review create(Review review) {
		review.setReviewTime(new Date());
		
		return super.create(review);
	}

	@Override
	public Review update(Review review) {
		return super.update(review);
	}

	@Override
	public Review get(Object reviewId) {
		return super.find(Review.class, reviewId);
	}

	@Override
	public void delete(Object reviewId) {
		super.delete(Review.class, reviewId);
	}

	@Override
	public List<Review> listAll() {
		return super.findWithNamedQuery("Review.listAll") ;
	}
	
	public Review findByCustomerAndBook(Integer customerId, Integer bookId){
		Map<String, Object> parameters = new HashMap<>();
		parameters.put("customerId", customerId);
		parameters.put("bookId", bookId);
		
		List<Review> result = super.findWithNamedQuery("Review.findByCustomerAndBook", parameters);
		
		if(!result.isEmpty()){
			return result.get(0);
		}
		
		return null;
	}

	@Override
	public long count() {
		return super.countWithNamedQuery("Review.countAll");
	}
	
	public List<Review> listMostRecent(){
		return super.findWithNamedQuery("Review.listAll", 0, 5);
	}

}
