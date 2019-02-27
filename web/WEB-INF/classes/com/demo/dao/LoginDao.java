package com.demo.dao;

import org.springframework.stereotype.Repository;	

import com.demo.model.User;
import org.junit.Test;

@Repository
public class LogRegDao extends BaseDao<User> {

	@Override
	public Class<User> getEntityClass() {
		return User.class;
	}
	
	//@Test
	public void insert(User user) {
		String statement=getIbatisMapperNamespace()+".insert";
		getSqlSessionTemplate().insert(statement,user);
	}
}
