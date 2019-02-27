package com.demo.model;

public class User {

	private int id;
	private String username;
	private String password;
	private String email;
	private int phone;
	private String address;
	private int usertype;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id=id;
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username=username;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password=password;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email=email;
	}
	
	public int getPhone() {
		return phone;
	}

	public void setPhone(int phone) {
		this.phone=phone;
	}
	
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address=address;
	}
	
	public int getUsertype() {
		return usertype;
	}
	
	public void setUsertype(int usertype) {
		this.usertype = usertype;
	}
	
	@Override
	public String toString() {
		return "User [id=" + id + ",username=" + username + ",password=" + password + ",email="
				+ email + ",phone=" + phone + ",address=" + address + ",usertype="+usertype+"]";
	}
	
}
