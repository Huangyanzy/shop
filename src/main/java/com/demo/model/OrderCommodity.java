package com.demo.model;

public class OrderCommodity {

	private Commodity commodity;
	private Integer num;
	
	public Commodity getCommodity() {
		return commodity;
	}
	
	public void setCommodity(Commodity commodity) {
		this.commodity = commodity;
	}
	
	public Integer getNum() {
		return num;
	}
	
	public void setNum(Integer num) {
		this.num = num;
	}
	
	@Override
	public String toString() {
		return "OrderCommodity [commodity=" + commodity + ",num=" + num + "]";
	}
	
}
