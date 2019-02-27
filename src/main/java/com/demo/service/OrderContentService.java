package com.demo.service;

import java.util.List;	

import javax.annotation.Resource;	

import org.springframework.stereotype.Service;

import com.demo.dao.OrderContentDao;
import com.demo.model.OrderContent;

@Service
public class OrderContentService {

	@Resource
	private OrderContentDao orderContentDao;
	
	//插入订单相应商品内容
	public void insert(OrderContent orderContent) {
		orderContentDao.insert(orderContent);		
	}
	
	//返回订单商品信息	
	public void selComlist() {
		orderContentDao.selComlist();
	}
	
}
