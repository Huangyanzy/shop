package com.demo.dao;

import java.util.ArrayList;								
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Repository;

import com.demo.model.User;

import org.junit.Test;

@Repository
public class UserDao extends BaseDao<User> {

	@Override
	public Class<User> getEntityClass() {
		return User.class;
	}
	
	/*用户注册*/
	public void register(User user) {
		String statement=getIbatisMapperNamespace()+".register";
		getSqlSessionTemplate().insert(statement,user);
	}
	
	/*通过用户名查找用户*/
	public User selUserByName(String username) {
		String statement=getIbatisMapperNamespace()+".selUserByName";
		User user=getSqlSessionTemplate().selectOne(statement, username);
		return user;
	}
	
	/*通过id查找用户*/
	public User selUserById(int userid) {
		String statement=getIbatisMapperNamespace()+".selUserById";
		return getSqlSessionTemplate().selectOne(statement,userid);
	}
	
	/*修改用户信息*/
	public int infoModify(User user) {
		String statement=getIbatisMapperNamespace()+".infoModify";
		return getSqlSessionTemplate().update(statement, user);
	}
	
	@Test
	public void test() {
		System.out.println("User.class: "+User.class);
		System.out.println("User.class.getName(): "+User.class.getName());
	}
	
}
