package com.demo.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.demo.dao.ShoppingCartDao;
import com.demo.model.CartCommodity;
import com.demo.model.CartSeller;
import com.demo.model.ShoppingCart;

@Service
public class ShoppingCartService {

	@Resource
	private ShoppingCartDao shoppingCartDao;
	
	//将商品加入购物车
	public void addShoppingCart(ShoppingCart shoppingCart) {
		shoppingCartDao.addShoppingCart(shoppingCart);
	}
	
	//判断购物车中是否存在商品
	public ShoppingCart isExistCommodity(ShoppingCart shoppingCart) {
		return shoppingCartDao.isExistCommodity(shoppingCart);
	}
	
	//更新购物车商品数量
	public void updateSCNum(ShoppingCart shoppingCart) {
		shoppingCartDao.updateSCNum(shoppingCart);
	}
	
	//返回当前买家购物车的商品列表
	public List<CartCommodity> selComList(Integer buyerid) {
		return shoppingCartDao.selComList(buyerid);
	}
	
	//返回当前买家购物车中卖家列表(sellerid)
	public List<CartSeller> selSidList(Integer buyerid) {
		return shoppingCartDao.selSidList(buyerid);
	}
	
	//删除购物车中的商品
	public void deleteCart(List<Map<String, Object>> delList) {
		shoppingCartDao.deleteCart(delList);
	}	
	
}
