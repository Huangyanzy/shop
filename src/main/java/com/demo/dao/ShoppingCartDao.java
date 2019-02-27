package com.demo.dao;

import java.util.ArrayList;	
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;
import org.junit.Test;
import org.springframework.stereotype.Repository;

import com.demo.model.CartCommodity;
import com.demo.model.CartSeller;
import com.demo.model.ShoppingCart;

@Repository
public class ShoppingCartDao extends BaseDao<ShoppingCart>{

	@Override
	public Class<ShoppingCart> getEntityClass() {
		return ShoppingCart.class;
	}
	
	//将商品加入购物车
	public void addShoppingCart(ShoppingCart shoppingCart) {
		String statement=getIbatisMapperNamespace()+".addShoppingCart";
		getSqlSessionTemplate().insert(statement, shoppingCart);
	}	
	
	//判断购物车中是否存在商品
	public ShoppingCart isExistCommodity(ShoppingCart shoppingCart) {
		String statement=getIbatisMapperNamespace()+".isExistCommodity";
		return getSqlSessionTemplate().selectOne(statement, shoppingCart);
	}
	
	//更新购物车商品数量
	public void updateSCNum(ShoppingCart shoppingCart) {
		String statement=getIbatisMapperNamespace()+".updateSCNum";
		getSqlSessionTemplate().update(statement, shoppingCart);
	}
	
	//返回当前买家购物车的商品列表 
	public List<CartCommodity> selComList(Integer buyerid) {
		String statement=getIbatisMapperNamespace()+".selComList";
		return getSqlSessionTemplate().selectList(statement, buyerid);
	}	
	
	//返回当前买家购物车中卖家列表
	public List<CartSeller> selSidList(Integer buyerid) {
		String statement=getIbatisMapperNamespace()+".selSidList";
		return getSqlSessionTemplate().selectList(statement,buyerid);
	}
	
	//删除购物车中的商品
	public void deleteCart(List<Map<String, Object>> delList) {
		String statement=getIbatisMapperNamespace()+".deleteCart";
		getSqlSessionTemplate().delete(statement, delList);
		return;
	}
	
}
