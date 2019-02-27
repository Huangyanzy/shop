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

import com.demo.model.CartCommodity;
import com.demo.model.CartSeller;
import com.demo.model.OrderShow;
import com.demo.model.User;
import com.demo.service.OrderService;
import com.demo.service.ShoppingCartService;
import com.demo.service.UserService;
import com.mysql.fabric.Response;


@Controller
@RequestMapping(value="/main")
public class MainController {
	@Resource
	private UserService loginService;
	@Resource
	private ShoppingCartService shoppingCartService;
	@Resource
	private OrderService orderService;
	
	//用户进入主界面
	@RequestMapping(value={"","/"})
	public String mainPage(HttpServletRequest request,HttpSession session) {
		User user=(User)session.getAttribute("user");
		//User user=loginService.selUserByName("aa");	//开发测试用
		session.setAttribute("user", user);		
		//session存在进入主界面
		if(user!=null) {
			return "main";
		}else {
			return "redirect:/login";
		}
	}
	//用户注销
	@RequestMapping(value="/logout")
	public String logOut(HttpServletRequest request) throws Exception {
		HttpSession session=request.getSession();
		session.invalidate();
		return "redirect:/login";
	}
	//选项卡内容加载
	@RequestMapping(value="/page/{wpage}")
	public ModelAndView TabStrip(@PathVariable String wpage,HttpServletRequest request,HttpSession session) {
		ModelAndView mav=new ModelAndView();		
		User user=(User)session.getAttribute("user");
		if(user!=null) {
			if(wpage.equals("homepage")) {
				mav.setViewName("homepage");
			}else if(wpage.equals("userinfo")) {//个人信息
				mav.setViewName("userinfo");
				mav.addObject("email", user.getEmail());
				mav.addObject("phone", user.getPhone());
				mav.addObject("address", user.getAddress());
			}else if(wpage.equals("buyhistory")) {//已买历史
				Integer buyerid=user.getUserid();
				List<OrderShow> orderShows=orderService.selOrderForBuyer(buyerid);
				mav.addObject("order",orderShows);
				mav.setViewName("buyhistory");
			}else if(wpage.equals("commodity")) {//商品管理		
				mav.setViewName("commodity");
			}else if(wpage.equals("look")) {//商品列表
				mav.setViewName("look");
			}else if(wpage.equals("shoppingcart")) {//购物车
				Integer buyerid=user.getUserid();
				List<CartCommodity> comlist=shoppingCartService.selComList(buyerid);
				if(!comlist.isEmpty()) {	//如果购物车不为空
					List<CartSeller> sellerlist=shoppingCartService.selSidList(buyerid);
					mav.addObject("comlist", comlist);
					mav.addObject("sellerlist", sellerlist);
					mav.setViewName("shoppingcart");
				}else {
					mav.setViewName("shoppingcartError");				
				}
			}else if(wpage.equals("sellhistory")){//已卖列表
				Integer sellerid=user.getUserid();
				List<OrderShow> orderShows=orderService.selOrderForSeller(sellerid);
				mav.addObject("order",orderShows);
				mav.setViewName("sellhistory");
			}else if(wpage.equals("chart")) {
				mav.setViewName("chart");
			}
		}else {
			mav.setViewName("error");
		}
		return mav;
	}
}
