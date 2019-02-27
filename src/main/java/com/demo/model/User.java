package com.demo.model;

import java.sql.Time;
import java.sql.Timestamp;

public class User {

	private Integer userid;
	private String username;
	private String password;
	private String email;
	private String phone;
	private String address;
	private String usertype;
	private String userpic;
	private Timestamp regdate;

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid=userid;
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
	
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone=phone;
	}
	
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address=address;
	}
	
	public String getUsertype() {
		return usertype;
	}
	
	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}	

	public String getUserpic() {
		return userpic;
	}
	
	public void setUserpic(String userpic) {
		this.userpic = userpic;
	}

	
	public Timestamp getRegdate() {
		return regdate;
	}
	
	public void setRegdate(Timestamp regdate) {
		this.regdate=regdate;
	}
	
	@Override
	public String toString() {
		return "User [userid=" + userid + ",username=" + username + ",password=" + password + ",email="
				+ email + ",phone=" + phone + ",address=" + address + ",usertype=" + usertype + ",userpic=" + userpic + ",regdate=" + regdate + "]";
	}
	
}
