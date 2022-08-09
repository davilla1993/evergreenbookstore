package com.bookstore.entities;
// Generated 9 nov. 2021 21:14:05 by Hibernate Tools 5.2.3.Final

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;


@Entity
@NamedQueries({
	@NamedQuery(name="Users.findAll", query="SELECT u FROM Users u ORDER BY u.userId"),
	@NamedQuery(name="Users.findByEmail", query="SELECT u FROM Users u WHERE u.email=:email"),
	@NamedQuery(name="Users.countAll", query="SELECT COUNT(*) FROM Users u"),
	@NamedQuery(name="Users.checkLogin", query="SELECT u FROM Users u WHERE u.email=:email AND u.password=:password")
})
@Table(name = "users")
public class Users implements java.io.Serializable {

	private static final long serialVersionUID = -8485651461936473734L;
	private Integer userId;
	private String email;
	private String password;
	private String fullName;

	public Users() {
	}
	
	
	public Users(Integer userId, String email, String password, String fullName) {
		super();
		this.userId = userId;
		this.email = email;
		this.password = password;
		this.fullName = fullName;
	}



	public Users(String email, String password, String fullName) {
		this.email = email;
		this.password = password;
		this.fullName = fullName;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "user_id", unique = true, nullable = false)
	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Column(name = "email", nullable = false, length = 80)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "password", nullable = false, length = 200)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "full_name", nullable = false, length = 30)
	public String getFullName() {
		return this.fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

}
