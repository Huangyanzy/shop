package com.demo.controller;

import java.io.IOException;		
import java.io.PrintWriter;
import java.util.ArrayList;						
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.accessibility.AccessibleRelation;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.connector.Request;
import org.apache.tomcat.util.http.parser.HttpParser;
import org.aspectj.apache.bcel.generic.ReturnaddressType;
import org.junit.Test;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.demo.model.User;
import com.demo.service.UserService;
import com.mysql.fabric.Response;


@Controller
@RequestMapping(value={"","/login","/shopping"})
public class LoginController {
	@Resource
	private UserService userService;
	
	/*进入登录页*/
	@RequestMapping(value={"","/login"})
	public String logPage() {
		return "login";
	}
	/*进入注册页*/
	@RequestMapping(value="/register")
	public String regPage() {
		return "register";
	}	
	/*判断用户名是否已经存在*/
	@RequestMapping(value="/regval")
	@ResponseBody
	public Map<String, String> isNameOK(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String uname=request.getParameter("username");
		//通过用户名查找用户
		User user=userService.selUserByName(uname);
		Map<String, String> map=new HashMap<>();
		//如果返回的用户为空，表示用户不存在
		if(user!=null) {
			map.put("exist", "true");
		}else {
			map.put("exist", "false");
		}
		return map;
	}
	/*用户注册*/
	@RequestMapping(value="/user_register",method=RequestMethod.POST) 
	public String register(User user) {
		//System.out.println(user);
		userService.register(user);
		return "redirect:register";
	}
	
	/*用户登录验证*/
	@RequestMapping(value="/logval")
	@ResponseBody
	public Map<String, String> logValidate(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String uname=request.getParameter("username");
		String pass=request.getParameter("password");
		//System.out.println(uname+"*"+pass);
		//通过name从数据库查找用户 
		User user=userService.selUserByName(uname);	
		//response.setHeader("Content-type", "text/html;charset=UTF-8"); 
		response.setCharacterEncoding("UTF-8");
		Map<String, String> map=new HashMap<>();
		//用户是否存在
		if(user!=null) {
			//密码是否相等
			if(pass.equals(user.getPassword())) {
				HttpSession session=request.getSession();
				session.setAttribute("user", user);				
				map.put("msg","ok");
			}else {
				map.put("msg","pwerror");
			}
		}else {
			map.put("msg","nouser");
		}
		return map;
	}
}
