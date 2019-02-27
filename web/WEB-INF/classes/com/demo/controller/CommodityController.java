package com.demo.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.demo.model.Commodity;
import com.demo.service.CommodityService;

@RequestMapping(value="/commodity")
public class CommodityController {
	
	@Resource
	private CommodityService commodityService;
	
	@RequestMapping(value={"","/"})
	public String commodityPage() {
		return "commodity";
	}
	
	@RequestMapping(value="/list.json")
	@ResponseBody
	public List<Commodity> commodityList() {
		return commodityService.selAllCommodity();
	}
	
}
