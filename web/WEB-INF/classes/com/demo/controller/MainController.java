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
import org.apache.ibatis.annotations.Case;
import org.apache.tomcat.util.http.parser.HttpParser;
import org.aspectj.apache.bcel.generic.ReturnaddressType;
import org.junit.Test;
import org.springframework.core.env.SystemEnvironmentPropertySource;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.demo.model.User;
import com.demo.service.UserService;
import com.mysql.fabric.Response;


@Controller
@RequestMapping(value="/main")
public class MainController {
	@Resource
	private UserService loginService;
	
	/*用户进入主界面*/
	@RequestMapping(value={"","/"})
	public String mainPage(HttpServletRequest request) {
		HttpSession session=request.getSession();
		//User user=(User)session.getAttribute("user");
		User user=loginService.selUserByName("aa");	//开发测试用
		//session存在进入主界面
		if(user!=null) {
			session.setAttribute("userid", user.getUserid());
			session.setAttribute("username", user.getUsername());
			session.setAttribute("userpic", user.getUserpic());
			System.out.println("hehe: "+user.getUserpic());
			session.setAttribute("usertype", user.getUsertype());
			return "main";
		}else {
			return "redirect:/login";
		}
	}
	/*用户注销*/
	@RequestMapping(value="/logout")
	public String logOut(HttpServletRequest request) throws Exception {
		HttpSession session=request.getSession();
		session.invalidate();
		//System.out.println(session.getAttribute("user"));
		return "redirect:/login";
	}
	/*选项卡内容加载*/
	@RequestMapping(value="/page/{wpage}")
	public ModelAndView TabStrip(@PathVariable String wpage,HttpServletRequest request) {
		ModelAndView mav=new ModelAndView();
		HttpSession session=request.getSession();
		//User user=(User)session.getAttribute("user");
		User user=loginService.selUserByName("aa");	//开发测试用
		if(wpage.equals("个人信息")) {
			mav.setViewName("userinfo");
			mav.addObject("email", user.getEmail());
			mav.addObject("phone", user.getPhone());
			mav.addObject("address", user.getAddress());
		}else if(wpage.equals("已买历史")) {
			mav.setViewName("buyhistory");
		}else {
			mav.setViewName("ing");
		}
		return mav;
	}
}
