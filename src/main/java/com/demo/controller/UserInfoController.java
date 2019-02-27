package com.demo.controller;

import java.io.File;		
import java.io.FileOutputStream;
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
import javax.websocket.Session;

import org.apache.catalina.connector.Request;
import org.apache.ibatis.annotations.Case;
import org.apache.tomcat.util.http.parser.HttpParser;
import org.aspectj.apache.bcel.generic.ReturnaddressType;
import org.junit.Test;
import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.SystemEnvironmentPropertySource;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.demo.model.User;
import com.demo.service.UserService;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.mysql.fabric.Response;


@Controller
@RequestMapping(value="/userinfo")
public class UserInfoController {
	@Autowired
	private HttpServletRequest request;
	
	@Resource
	private UserService userService;	
	
	/*
	@RequestMapping(value={"","/"})
	public String userinfo() {
		return "userinfo";
	}
	*/
	
	/* 头像上传 */
	@RequestMapping(value="/upload")
	@ResponseBody
	public ModelMap avtarUpload(HttpSession session,@RequestParam("avatar") String navatar) {
		//Map<String,Object> map=new HashMap<String,Object>();
		//String savepath=null;
		ModelMap model=new ModelMap();
		/*判断文件是否为空*/
		if(!navatar.isEmpty()) {
			try {
				/*
				System.out.println("System.getProperty('user.dir'): "+System.getProperty("user.dir"));
				//系统下服务器目录绝对路径
				System.out.println("request.getSession().getServletContext().getRealPath('/'): "+request.getSession().getServletContext().getRealPath("/"));
				System.out.println("request.getScheme(): "+request.getScheme()+",request.getServerName(): "+request.getServerName()+",request.getServerPort(): "+request.getServerPort());
				System.out.println("request.getLocalAddr(): "+request.getLocalAddr()+",request.getLocalName(): "+request.getLocalName()+",request.getLocalPort(): "+request.getLocalPort());
				System.out.println("request.getContextPath(): "+request.getContextPath());
				System.out.println("request.getRequestURI(): "+request.getRequestURI());
				System.out.println("request.getServletPath(): "+request.getServletPath());
				System.out.println("request.getSession().getServletContext(): "+request.getSession().getServletContext());
				System.out.println("request.getSession().getServletContext().getContextPath(): "+request.getSession().getServletContext().getContextPath());
				System.out.println("request.getSession().getServletContext().getRealPath(''): "+request.getSession().getServletContext().getRealPath("")+"/n");
				*/
				
				//String syspath="D:/Learning Tools/eclipse-jee-mars-2-win32-x86_64/workspace/MyMVCDemo/web/resources/images/user/";
				
				//savepath=request.getSession().getServletContext().getRealPath("/")+"resources/images/user/"+avatar.getOriginalFilename();
				//map.put("navatar", navatar);
				User user=(User)session.getAttribute("user");
				//int userid=(int)session.getAttribute("userid");	//获取当前登录用户id				
				//User user=userService.selUserById(userid);	//获取用户信息
				user.setUserpic(navatar);	//修改用户头像
				userService.infoModify(user);	//更新用户信息
				//session.setAttribute("userpic", navatar);				
				
				model.addAttribute("navatar", navatar);				
				//session.setAttribute("userpic", request.getContextPath()+"/resources/images/user/"+);
				//转存文件
				//avatar.transferTo(new File(savepath));
/*				FileOutputStream out =new FileOutputStream(filePath);
				out.write(avatar.getBytes());
				out.flush();
				out.close();*/
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		//mav.setViewName("userinfo");
		//return "redirect:/main";
		return model;
	}
	
	@RequestMapping(value="/infomodify")
	@ResponseBody
	public String infoModify(HttpSession session,@RequestBody User newinfo) {
		//System.out.println("hehe:"+email);
		/*
		System.out.println("需要更新信息: "+new_user);
		User cur_user=(User)session.getAttribute("user");
		System.out.println("当前用户信息: "+cur_user);
		new_user.setUserid(cur_user.getUserid());
		new_user.setUsername(cur_user.getUsername());
		if(new_user.getPassword()==null) {
			new_user.setPassword(cur_user.getPassword());
		}
		new_user.setUsertype(cur_user.getUsertype());
		new_user.setUserpic(cur_user.getUserpic());
		new_user.setRegdate(cur_user.getRegdate());
		System.out.println("更新后用户信息: "+new_user);
		*/
		String email=newinfo.getEmail();
		String newpass=newinfo.getPassword();
		String phone=newinfo.getPhone();
		String address=newinfo.getAddress();		
		User user=(User)session.getAttribute("user");
		//更新用户信息
		user.setEmail(email);
		//如果密码不为空，更新密码
		if(newpass!=null) {
			user.setPassword(newpass);
		}
		user.setPhone(phone);
		user.setAddress(address);
		userService.infoModify(user);
		
		return "success"; 
	}
	
	@RequestMapping(value="/test")
	public ModelAndView test() {
		String filePath=request.getSession().getServletContext().getRealPath("/")+"resources/images/user/";
		ModelAndView mav=new ModelAndView("test");
		System.out.println("hehe");
/*		File uploadDest=new File(filePath);
		String[] fileNames=uploadDest.list();
		for(int i=0;i<fileNames.length;i++) {
			System.out.println(fileNames[i]);
		}*/
		return mav;
	}
	
	
}
