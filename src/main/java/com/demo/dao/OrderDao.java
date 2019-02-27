package com.demo.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.demo.model.Order;
import com.demo.model.OrderShow;


@Repository
public class OrderDao extends BaseDao<Order>{
	
	@Override
	public Class<Order> getEntityClass() {
		return Order.class;
	}
	
	//返回买家订单的数目
	public Integer orderNum(Integer buyerid) {
		String statement=getIbatisMapperNamespace()+".orderNum";
		return getSqlSessionTemplate().selectOne(statement, buyerid);
	}
	
	//创建已买订单
	public void createOrder(Order order) {
		String statement=getIbatisMapperNamespace()+".createBuyOrder";
		getSqlSessionTemplate().insert(statement, order);
	}
	
	//创建新订单
	public void insert(Order order) {
		String statement=getIbatisMapperNamespace()+".insert";
		getSqlSessionTemplate().insert(statement, order);
	}
		
	//查找买家当前订单编号
	public Integer selCurOrderid(Integer buyerid) {
		String statement=getIbatisMapperNamespace()+".selCurOrderid";
		return getSqlSessionTemplate().selectOne(statement, buyerid);
	}
	
	//查询买家订单信息
	public List<OrderShow> selOrderForBuyer(Integer buyerid) {
		String statement=getIbatisMapperNamespace()+".selOrderForBuyer";
		List<OrderShow> orderShow=getSqlSessionTemplate().selectList(statement, buyerid);		
		return orderShow;
	}
	
	//查询卖家订单信息
	public List<OrderShow> selOrderForSeller(Integer sellerid) {
		String statement=getIbatisMapperNamespace()+".selOrderForSeller";
		List<OrderShow> orderShow=getSqlSessionTemplate().selectList(statement, sellerid);		
		return orderShow;
	}	
	
	//每日营业总额图表
	public List<Map<String, Object>> selDayTotal(Integer sellerid) {
		String statement=getIbatisMapperNamespace()+".selDayTotal";
		List<Map<String, Object>> daytotal=getSqlSessionTemplate().selectList(statement, sellerid);
		return daytotal;
	}
	
}
