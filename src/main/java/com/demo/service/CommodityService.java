package com.demo.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.demo.dao.CommodityDao;
import com.demo.model.Commodity;

@Service
public class CommodityService {
	
	@Resource
	private CommodityDao commodityDao;
	
	//获取所有商品信息
	public List<Commodity> selCommodityBySid(Integer sid) {
		return commodityDao.selCommodityBySid(sid);
	}
	
	//更新商品
	public void commodityUpdate(Commodity commodity) {
		commodityDao.commodityUpdate(commodity);
	}
	
	//添加商品
	public void commodityCreate(Commodity commodity) {
		commodityDao.commodityCreate(commodity);
	}
	
	//删除商品
	public void commodityDelete(Integer comid) {
		commodityDao.commodityDelete(comid);
	}
	
	//查找所有商品
	public List<Commodity> selAllCommodity() {
		return commodityDao.selAllCommodity();
	}
	
	//通过商品id查找商品信息
	public Commodity selCommodityById(Integer comid) {
		return commodityDao.selCommodityById(comid);		
	}
	
	//返回商品已售数量
	public Integer getSold(Integer comid) {
		return commodityDao.getSold(comid);		
	}	
	
	//更新已售数量
	public void updateSold(Map<String, Integer> map) {
		commodityDao.updateSold(map);
	}
	
	//浏览界面搜索商品
	public List<Commodity> searchForLookPg(String comname) {
		return commodityDao.searchForLookPg(comname);		
	}
	
	// 卖家管理界面搜索商品
	public List<Commodity> searchForComPg(Map<String, Object> map) {		
		return commodityDao.searchForComPg(map);		
	}		
	
}
