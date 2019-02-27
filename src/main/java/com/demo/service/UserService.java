package com.demo.service;

import java.util.List;	

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.dao.UserDao;
import com.demo.model.User;

import org.aspectj.apache.bcel.generic.ReturnaddressType;
import org.junit.Test;

@Service
public class UserService {
	@Resource
	private UserDao userDao;
	/*用户注册*/
	public void register(User user) {
		userDao.register(user);
	}
	
	/*通过用户名查找用户*/
	public User selUserByName(String username) {
		return userDao.selUserByName(username);
	}
	
	public User selUserById(int userid) {
		return userDao.selUserById(userid);
	}
	
	/*修改用户信息*/
	public int infoModify(User user) {
		return userDao.infoModify(user);
	}
}
