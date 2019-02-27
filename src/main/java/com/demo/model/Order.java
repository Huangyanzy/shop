package com.demo.model;

import java.sql.Date;		
import java.util.List;

public class Order {
	
	private Integer orderid;	
	private Integer buyerid;
	private Integer sellerid;
	private Double total;
	private Date time;
	
	public Integer getOrderid() {
		return orderid;
	}
	
	public void setOrderid(Integer orderid) {
		this.orderid = orderid;
	}
	
	public Integer getBuyerid() {
		return buyerid;
	}
	
	public void setBuyerid(Integer buyerid) {
		this.buyerid = buyerid;
	}
	
	public Integer getSellerid() {
		return sellerid;
	}
	
	public void setSellerid(Integer sellerid) {
		this.sellerid = sellerid;
	}
	
	public Double getTotal() {
		return total;
	}
	
	public void setTotal(Double total) {
		this.total = total;
	}
	
	public Date getTime() {
		return time;
	}
	
	public void setTime(Date time) {
		this.time = time;
	}
	
	
	@Override
	public String toString() {
		return "Order [orderid=" + orderid + ",buyerid=" + buyerid + ",sellerid=" + sellerid + 
				",total=" + total + ",time=" + time + "]";
	}
	
}
