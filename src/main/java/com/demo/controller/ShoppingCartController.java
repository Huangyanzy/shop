package com.demo.controller;

import java.io.File;				
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.connector.Request;
import org.apache.naming.java.javaURLContextFactory;
import org.eclipse.jdt.internal.compiler.ast.NumberLiteral;
import org.junit.Test;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.demo.model.CartPurchaseInfo;
import com.demo.model.Commodity;
import com.demo.model.Order;
import com.demo.model.OrderContent;
import com.demo.model.ShoppingCart;
import com.demo.model.User;
import com.demo.service.CommodityService;
import com.demo.service.OrderContentService;
import com.demo.service.OrderService;
import com.demo.service.ShoppingCartService;


@Controller
@RequestMapping(value="/shoppingcart")
public class ShoppingCartController {
	
	@Resource
	private ShoppingCartService shoppingCartService;
	@Resource
	private OrderService orderService;
	@Resource
	private OrderContentService orderContentService;
	@Resource
	private CommodityService commodityService;
	
	/*
	@RequestMapping(value={"","/"})
	public String shoppingcartPage() {			
		return "shoppigcart";
	}
	*/	
	
	@RequestMapping(value="/updateNum")
	@ResponseBody
	public String updateNum(ShoppingCart shoppingCart) {
		shoppingCartService.updateSCNum(shoppingCart);
		return "ok";
	}
	
	/*
	 * Order buyOrder,@RequestParam(value="comidArr") Integer[] comidArr,@RequestParam(value="numArr") Integer[] numArr
	 */
	@RequestMapping(value="/checkout")
	@ResponseBody
	public String checkout(HttpSession session,@RequestBody List<CartPurchaseInfo> purchaseInfos) {
		User user=(User)session.getAttribute("user");
		Integer buyerid=user.getUserid();
		//Integer buyerid=109;//测试用
		for(int i=0;i<purchaseInfos.size();i++) {
			Order order=new Order();
			CartPurchaseInfo info=purchaseInfos.get(i);
			order.setBuyerid(buyerid);
			order.setSellerid(info.getSellerid());
			order.setTotal(info.getTotal());
			orderService.insert(order);
			Integer orderid=orderService.selCurOrderid(buyerid);//当前订单号
			int n=purchaseInfos.get(i).getCominfo().size();//获取订单商品数
			OrderContent[] buycoms=new OrderContent[n]; 
			for(int j=0;j<n;j++) {
				buycoms[j]=new OrderContent();
				Map<String, Integer> com=info.getCominfo().get(j);
				buycoms[j].setOrderid(orderid);
				buycoms[j].setComid(com.get("comid"));
				buycoms[j].setNum(com.get("num"));
				Integer nsold=commodityService.getSold(com.get("comid"))+com.get("num");
				Map<String, Integer> map=new HashMap<String, Integer>();
				map.put("comid", com.get("comid"));
				map.put("sold", nsold);				
				commodityService.updateSold(map);
			}
			for(int j=0;j<buycoms.length;j++) {
				orderContentService.insert(buycoms[j]);
			}
		}
		/*
		orderService.insert(order);//插入新订单记录
		Integer orderid=orderService.selCurOrderid(buyerid);//当前订单号
		OrderContent[] buycoms = new OrderContent[comidArr.length];		
		for(int i=0;i<comidArr.length;i++) {
			buycoms[i]=new OrderContent();
			buycoms[i].setOrderid(orderid);
			buycoms[i].setComid(comidArr[i]);
			buycoms[i].setNum(numArr[i]);
		}
		for(int i=0;i<buycoms.length;i++) {
			orderContentService.insert(buycoms[i]);
		}
		*/
		
		//orderContentService.selComlist();
		return "";
	}
	
	@RequestMapping(value="/delete")
	@ResponseBody
	public String delete(@RequestBody List<Map<String, Object>> delList) {
		shoppingCartService.deleteCart(delList);		
		return "ok";
	}	
	
}
