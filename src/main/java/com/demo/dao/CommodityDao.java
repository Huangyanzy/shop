package com.demo.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.demo.model.Commodity;
import com.demo.model.ShoppingCart;

@Repository
public class CommodityDao extends BaseDao<Commodity> {
	
	@Override
	public Class<Commodity> getEntityClass() {
		return Commodity.class;
	}
	
	//获取卖家所对应的所有商品信息
	public List<Commodity> selCommodityBySid(Integer sid) {
		String statement=getIbatisMapperNamespace()+".selCommodityBySid";
		return getSqlSessionTemplate().selectList(statement, sid);
	}
	
	//更新商品
	public void commodityUpdate(Commodity commodity) {
		String statement=getIbatisMapperNamespace()+".updateCommodity";
		getSqlSessionTemplate().update(statement, commodity);
	}
	
	//添加商品
	public void commodityCreate(Commodity commodity) {
		String statement=getIbatisMapperNamespace()+".createCommodity";
		getSqlSessionTemplate().insert(statement, commodity);
	}
	
	//删除商品
	public void commodityDelete(Integer comid) {
		String statement=getIbatisMapperNamespace()+".deleteCommodity";
		getSqlSessionTemplate().delete(statement, comid);
	}
	
	//查找所有商品
	public List<Commodity> selAllCommodity() {
		String statement=getIbatisMapperNamespace()+".selAllCommodity";
		return getSqlSessionTemplate().selectList(statement, null);
	}
	
	//通过商品id查找商品信息
	public Commodity selCommodityById(Integer comid) {
		String statement=getIbatisMapperNamespace()+".selCommodityById";
		return getSqlSessionTemplate().selectOne(statement,comid);
	}	
		
	//返回商品已售数量
	public Integer getSold(Integer comid) {
		String statement=getIbatisMapperNamespace()+".getSold";
		return getSqlSessionTemplate().selectOne(statement, comid);
	}
	
	//更新已售数量
	public void updateSold(Map<String, Integer> map) {
		String statement=getIbatisMapperNamespace()+".updateSold";
		getSqlSessionTemplate().update(statement, map);
	}	
	
	//浏览界面搜索商品
	public List<Commodity> searchForLookPg(String comname) {
		String statement=getIbatisMapperNamespace()+".searchForLookPg";
		return getSqlSessionTemplate().selectList(statement, comname);
	}
	
	// 卖家管理界面搜索商品
	public List<Commodity> searchForComPg(Map<String, Object> map) {		
		String statement=getIbatisMapperNamespace()+".searchForComPg";
		return getSqlSessionTemplate().selectList(statement, map);
	}	
	
}
