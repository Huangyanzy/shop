package com.demo.model;

import java.util.List;

public class OrderContent {

	private Integer ocid;
	private Integer orderid;
	private Integer comid;
	private Commodity commodity;
	private Integer num;
		
	public Integer getocid() {
		return ocid;
	}
	
	public void setBocid(Integer ocid) {
		this.ocid = ocid;
	}
	
	public Integer getOrderid() {
		return orderid;
	}
	
	public void setOrderid(Integer orderid) {
		this.orderid = orderid;
	}
	
	public Integer getComid() {
		return comid;
	}
	
	public void setComid(Integer comid) {
		this.comid = comid;
	}
	
	public Integer getNum() {
		return num;
	}
	
	public void setNum(Integer num) {
		this.num = num;
	}
	
	public Commodity getCommodity() {
		return commodity;
	}
	
	public void setCommodity(Commodity commodity) {
		this.commodity = commodity;
	}
	
	@Override
	public String toString() {
		return "OrderContent [ocid=" + ocid + ",orderid=" + orderid + ",comid=" + comid + 
				",num=" + num + ",commodity" + commodity + "]";
	}
	
}
