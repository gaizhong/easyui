package com.cai.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.cai.entity.MenuEntity;
import com.cai.service.LoginServiceImpl;
import com.cai.util.ControllerUtils;
import com.cai.util.List2Json;

@Controller
public class LoginControl {
	
//	@Autowired
//	HttpServletResponse response;
	
	@Autowired
	LoginServiceImpl loginServiceImpl;
	
	
	@RequestMapping("/login")
	@ResponseBody
	public String login(HttpServletRequest request) {
		
		String name=request.getParameter("name");
		String password=request.getParameter("password");
		System.out.println(name+"   "    +password);
		if(!name.equals("admin")){
			return "false";
		}
		return"ok";
		
	}

	@RequestMapping("/regedit")
	@ResponseBody
	public String regedit(HttpServletRequest request) {
		
		String name=request.getParameter("name");
		String password=request.getParameter("password");
		System.out.println(name+"    "+password);
		if(!name.equals("admin")){
			return "false";
		}
		return"ok";
		
	}
	
	@RequestMapping("/layout/gridData")
	@ResponseBody
	public String gridData(HttpServletRequest request) {
/*		[ {
			"productid" : "FI-SW-01",
			"productname" : "Koi"
		}, {
			"productid" : "K9-DL-01",
			"productname" : "Dalmation"
		}, {
			"productid" : "RP-SN-01",
			"productname" : "Rattlesnake"
		}, {
			"productid" : "RP-LI-02",
			"productname" : "Iguana"
		}, {
			"productid" : "FL-DSH-01",
			"productname" : "Manx"
		}, {
			"productid" : "FL-DLH-02",
			"productname" : "Persian"
		}, {
			"productid" : "AV-CB-01",
			"productname" : "Amazon Parrot"
		} ]*/
		List list=new ArrayList();
		for (int i=0; i<20 ; i++) {
			Map map=new HashMap();
			map.put("productid", "productid____"+i);
			map.put("productname", "productname____"+i);
			System.out.println(list);
			list.add(map);
		}
		Object json = JSON.toJSON(list);
		return json.toString();
	}
	
	@RequestMapping("/layout/getmenu")
	@ResponseBody
	public void getmenu(HttpServletResponse response){
		List<MenuEntity> allMenu = loginServiceImpl.allMenu();
		List<MenuEntity> list2Json = List2Json.list2Json("P00", allMenu);
		String jsonString = JSON.toJSONString(list2Json);
		System.out.println("list2Json-->"+jsonString);
		ControllerUtils.printTextHtml(jsonString, response);
	}
}
