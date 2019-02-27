package com.demo.model;

import java.util.List;
import java.util.Map;

public class CartPurchaseInfo {
	
	private Integer buyerid;
	private Integer sellerid;
	private List<Map<String, Integer>> cominfo;
	private Double total;
	
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
	
	public List<Map<String, Integer>> getCominfo() {
		return cominfo;
	}
	
	public void setCominfo(List<Map<String, Integer>> cominfo) {
		this.cominfo = cominfo;
	}
	
	public Double getTotal() {
		return total;
	}
	
	public void setTotal(Double total) {
		this.total = total;
	}
	
	@Override
	public String toString() {
		return "CartPurchaseInfo [buyerid=" + buyerid + ",sellerid=" + sellerid + ",cominfo=" + cominfo +
				",total=" + total + "]";
	}
	
}
