package com.demo.model;

public class ShoppingCart {
	private Integer scid;
	private Integer buyerid;
	private Integer comid;
	private Integer num;
	private Integer sellerid;
	
	public Integer getScid() {
		return scid;
	}
	
	public void setScid(Integer scid) {
		this.scid = scid;
	}
	
	public Integer getBuyerid() {
		return buyerid;
	}
	
	public void setBuyerid(Integer buyerid) {
		this.buyerid = buyerid;
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
	
	public Integer getSellerid() {
		return sellerid;
	}
	
	public void setSellerid(Integer sellerid) {
		this.sellerid = sellerid;
	}
	
	@Override
	public String toString() {
		return "ShoppingCart [scid=" + scid + ",buyerid=" + buyerid + ",comid=" + comid + ",num=" + num + 
				",sellerid=" + sellerid + "]";
	}
	
}
