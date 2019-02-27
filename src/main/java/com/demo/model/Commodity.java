package com.demo.model;

public class Commodity {
	
	private Integer comid;
	private String comname;
	private Double price;
	private Integer stock;
	private String description;
	private String compic;
	private Integer sold;
	private Integer sellerid;
	
	public Commodity() {}
	
	public Commodity(Integer comid) {
		setComid(comid);
	}
	
	public Integer getComid() {
		return comid;
	}
	
	public void setComid(Integer comid) {
		this.comid=comid;
	}
	
	public String getComname() {
		return comname;
	}
	
	public void setComname(String comname) {
		this.comname=comname;
	}
	
	public Double getPrice() {
		return price;
	}
	
	public void setPrice(Double price) {
		this.price=price;
	}
	
	public Integer getStock() {
		return stock;
	}
	
	public void setStock(Integer stock) {
		this.stock=stock;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description=description;
	}
	
	public String getCompic() {
		return compic;
	}
	
	public void setCompic(String compic) {
		this.compic=compic;
	}

	public Integer getSold() {
		return sold;
	}
	
	public void setSold(Integer sold) {
		this.sold=sold;
	}	
	
	public Integer getSellerid() {
		return sellerid;
	}
	
	public void setSellerid(Integer sellerid) {
		this.sellerid=sellerid;
	}
	
	@Override
	public String toString() {
		return "Commodity [comid=" + comid + ",comname=" + comname + ",price=" + price + ",stock=" + stock
				+ ",description=" + description +",compic=" + compic + ",sold=" + sold + ",sellerid=" +sellerid +"]";
	}
	
}
