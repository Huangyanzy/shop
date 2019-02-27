package com.demo.dao;

import java.util.List;	

import org.springframework.stereotype.Repository;

import com.demo.model.OrderContent;

@Repository
public class OrderContentDao extends BaseDao<OrderContent>{
	
	@Override
	public Class<OrderContent> getEntityClass() {
		return OrderContent.class;
	}
	
	//插入订单相应商品内容
	public void insert(OrderContent orderContent) {
		String statement=getIbatisMapperNamespace()+".insert";
		getSqlSessionTemplate().insert(statement, orderContent);
	}
	
	//返回订单商品信息	
	public void selComlist() {
		String statement=getIbatisMapperNamespace()+".selComlist";
		List<OrderContent> comlist=getSqlSessionTemplate().selectList(statement);
		int a=1;
	}
	
}
