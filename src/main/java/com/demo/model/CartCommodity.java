package com.demo.model;

import java.util.List;	

import com.demo.model.Commodity;

public class CartCommodity {
	
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
		return "CartCommodity [commodity=" + commodity + ",num=" + num + "]";
	}
	
}
