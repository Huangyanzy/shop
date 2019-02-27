package com.demo.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.demo.dao.OrderDao;
import com.demo.model.Order;
import com.demo.model.OrderShow;

@Service
public class OrderService {

	@Resource
	private OrderDao orderDao;
	
	//返回买家订单的数目
	public Integer orderNum(Integer buyerid) {
		return orderDao.orderNum(buyerid);
	}
	
	//创建已买订单
	public void createBuyOrder(Order order) {
		orderDao.createOrder(order);
	}
	
	//创建新订单
	public void insert(Order order) {
		orderDao.insert(order);
	}
	
	//查找买家当前订单编号
	public Integer selCurOrderid(Integer buyerid) {
		return orderDao.selCurOrderid(buyerid);		
	}
	
	//查询买家订单信息
	public List<OrderShow> selOrderForBuyer(Integer buyerid) {
		return orderDao.selOrderForBuyer(buyerid);
	}
	
	//查询卖家订单信息
	public List<OrderShow> selOrderForSeller(Integer sellerid) {
		return orderDao.selOrderForSeller(sellerid);
	}	
	
	//每日营业总额图表
	public List<Map<String, Object>> selDayTotal(Integer sellerid) {
		return orderDao.selDayTotal(sellerid);
	}	
	
}
