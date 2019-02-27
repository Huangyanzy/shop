package com.demo.model;

import java.sql.Date;
import java.util.List;

public class OrderShow {

	private Integer orderid;
	private Integer buyerid;
	private String buyername;
	private Integer sellerid;
	private String sellername;
	private Double total;	
	private Date time;
	private List<OrderCommodity> comlist;
		
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
	
	public String getBuyername() {
		return buyername;
	}
	
	public void setBuyername(String buyername) {
		this.buyername = buyername;
	}
	
	public Integer getSellerid() {
		return sellerid;
	}
	
	public void setSellerid(Integer sellerid) {
		this.sellerid = sellerid;
	}
	
	public String getSellername() {
		return sellername;
	}
	
	public void setSellername(String sellername) {
		this.sellername = sellername;
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
	
	public List<OrderCommodity> getComlist() {
		return comlist;
	}
	
	public void setComlist(List<OrderCommodity> comlist) {
		this.comlist = comlist;
	}
	
	@Override
	public String toString() {
		return "OrderShow [orderid=" + orderid + ",buyerid=" + buyerid + ",buyername=" + buyername  + ",sellerid=" + sellerid +
				",sellername=" + sellername + ",total=" + total + ",time=" + time + ",comlist=" + comlist + "]";
	}
	
}
