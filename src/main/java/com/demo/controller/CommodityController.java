package com.demo.controller;

import java.io.File;		
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.connector.Request;
import org.eclipse.jdt.internal.compiler.ast.NumberLiteral;
import org.junit.Test;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.demo.model.Order;
import com.demo.model.OrderContent;
import com.demo.model.CartPurchaseInfo;
import com.demo.model.Commodity;
import com.demo.model.ShoppingCart;
import com.demo.service.OrderService;
import com.demo.service.CommodityService;
import com.demo.service.OrderContentService;
import com.demo.service.ShoppingCartService;

@Controller
@RequestMapping(value="/commodity")
public class CommodityController {
	
	@Resource
	private CommodityService commodityService;
	@Resource
	private ShoppingCartService shoppingCartService;
	@Resource
	private OrderService orderService;
	@Resource
	private OrderContentService orderContentService;
	
	@RequestMapping(value={"","/"})
	public String commodityPage() {
		return "commodity";
	}
	
	//显示卖家管理商品
	@RequestMapping(value="/listBySid")
	@ResponseBody
	public List<Commodity> commodityList(Integer sid) {
		List<Commodity> list=new ArrayList<Commodity>();
		list=commodityService.selCommodityBySid(sid);
/*		for(Commodity tmp:list) {
			System.out.println(tmp);
		}*/
		return list;
	}
	
	//更新商品
	@RequestMapping(value="/update")
	@ResponseBody
	public Commodity commodityUpdate(Commodity commodity) {
		commodityService.commodityUpdate(commodity);		
		return commodity;
	}
	
	//添加商品
	@RequestMapping(value="/create")
	@ResponseBody
	public Commodity commodityCreate(HttpServletRequest request,Commodity commodity) {		
		String savepath=request.getContextPath()+"/resources/images/commodity/"+commodity.getCompic();
		//System.out.println(savepath);
		commodity.setCompic(savepath);
		commodityService.commodityCreate(commodity);
		return commodity;
	}
	
	//删除商品
	@RequestMapping(value="/delete")
	@ResponseBody
	public Commodity commodityDelete(Integer comid) {
		commodityService.commodityDelete(comid);
		return new Commodity(comid);
	}
	
	//商品图片上传
	@RequestMapping(value="/upload")
	@ResponseBody
	public String picUpload(@RequestParam("compic") MultipartFile file,HttpServletResponse response) throws Exception {
		/*
		for(int i=0;i<files.length;i++) {
			System.out.println(i+": "+files[i].getOriginalFilename());
		}
		*/
		response.setContentType("text/plain;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		String savepath="D:/Learning Tools/eclipse-jee-mars-2-win32-x86_64/workspace/MyMVCDemo/web/upload/"+file.getOriginalFilename();
		//System.out.println(savepath);
		file.transferTo(new File(savepath));
		
		return "upload";
	}
	
	//上传商品图片删除
	@RequestMapping(value="/remove")
	@ResponseBody
	public String picRemove() {
		return "remove";
	}
	
	//显示所有商品
	@RequestMapping(value="/allCommodity")
	@ResponseBody
	public List<Commodity> allCommodity() {
		return commodityService.selAllCommodity();
	}
	
	//通过商品id查找商品信息
	@RequestMapping(value="/oneCommodity")
	@ResponseBody
	public Commodity oneCommodity(@RequestParam("comid") Integer comid) {
		return commodityService.selCommodityById(comid);
	}
	
	//加入购物车
	@RequestMapping(value="/addCart")
	@ResponseBody
	public ShoppingCart addCard(ShoppingCart shoppingCart) {
		//System.out.println(shoppingCart);
		//System.out.println("存在="+shoppingCartService.isExistCommodity(shoppingCart));
		ShoppingCart cart=shoppingCartService.isExistCommodity(shoppingCart);
		if(cart!=null) {//购物车已存在商品
			Integer newnum=cart.getNum()+shoppingCart.getNum();//数量叠加
			shoppingCart.setNum(newnum);
			shoppingCartService.updateSCNum(shoppingCart);			
		}else {
			shoppingCartService.addShoppingCart(shoppingCart);
		}
		return shoppingCart;
	}
	
	//立即购买
	@RequestMapping(value="/buy")
	@ResponseBody
	public String buy(@RequestBody CartPurchaseInfo info) {
		//Integer orderid=orderService.orderNum(buyOrder.getBuyerid())+1;//当前买家已有订单数目
		//buyOrder.setOrderid(orderid);
		//orderService.createBuyOrder(buyOrder);
		Integer buyerid=info.getBuyerid();
		//创建新订单
		Order order=new Order();		
		order.setBuyerid(buyerid);
		order.setSellerid(info.getSellerid());
		order.setTotal(info.getTotal());
		orderService.insert(order);
		//创建对应订单内容
		Integer orderid=orderService.selCurOrderid(buyerid);
		Map<String, Integer> com=info.getCominfo().get(0);
		OrderContent orderContent=new OrderContent();
		Integer nsold=commodityService.getSold(com.get("comid"))+com.get("num");
		Map<String,Integer> map=new HashMap<String,Integer>();
		map.put("comid", com.get("comid"));		
		map.put("sold", nsold);
		commodityService.updateSold(map);
		orderContent.setOrderid(orderid);
		orderContent.setComid(com.get("comid"));
		orderContent.setNum(com.get("num"));
		orderContentService.insert(orderContent);		
		return "ok";
	}
	
	@RequestMapping(value="/waiting")
	public String waiting() {
		return "waiting";
	}

	//浏览界面搜索商品
	@RequestMapping(value="/searchForLookPg")
	@ResponseBody
	public List<Commodity> searchForLookPg(@RequestParam("comname") String comname) {
		List<Commodity> com=commodityService.searchForLookPg(comname);
		return com;
	}
	
	//卖家管理界面搜索商品
	@RequestMapping(value="/searchForComPg")
	@ResponseBody
	public List<Commodity> searchForComPg(@RequestParam("sellerid") Integer sellerid,@RequestParam("comname") String comname) {
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("sellerid", sellerid);
		map.put("comname", comname);
		List<Commodity> com=commodityService.searchForComPg(map);
		return com;
	}
	
	//每日营业总额图表
	@RequestMapping(value="/dayTotal")
	@ResponseBody
	public List<Map<String, Object>> dayTotal(@RequestParam("sid") Integer sid) {
		List<Map<String, Object>> dayTotal=orderService.selDayTotal(sid);
		return dayTotal;
	}	
	
}
