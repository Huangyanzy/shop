package com.demo.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.demo.model.User;
import com.demo.dao.LogRegDao;


@Service
public class LogRegService {
	@Resource
	private LogRegDao logRegDao;
	
	public void insert(User user) {
		logRegDao.insert(user);
	}
	
	
}
