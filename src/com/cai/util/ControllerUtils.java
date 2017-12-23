package com.cai.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;

public class ControllerUtils {
	
	
	/**
	 * 讲Ali FastJSON中的JSONObject对象转换成Map<String, Object>
	 * 主要用于Web页面的参数传递
	 * @param jsonObj
	 * @return
	 */
	public static Map<String, Object> jsonObjToMap(JSONObject jsonObj){
		Iterator it=jsonObj.keySet().iterator();
		Map<String, Object> result=new HashMap<String, Object>();
		while(it.hasNext()){
			Object keyObj=it.next();
			String key=keyObj==null?"":keyObj.toString();
			String value=jsonObj.getString(key)==null?"":jsonObj.getString(key);
			result.put(key, value);
		}
		return result;
	}
	
	public static JSONObject mapToJsonObj(Map<String, String> map){
		JSONObject result=new JSONObject();
		
		Iterator<String> it=map.keySet().iterator();
		while(it.hasNext()){
			String key=it.next();
			String value=map.get(key);
			
			result.put(key, value);
		}
		return result;
	}
	
	
	
	public static void printTextHtml(String outTxt,HttpServletResponse response){
		PrintWriter out=null;
		try {
			response.setContentType("text/html; charset=utf-8");
			out=response.getWriter();
			out.write(outTxt);
			out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			if(out!=null){
				out.close();
			}
		}
	}
	
	/**
	 * 读取配置文件app.Properties
	 * 
	 */
	public static Map<String,String> getApp(HttpServletRequest request){
		Map<String,String> result=new HashMap<String, String>();
		Properties s =new Properties();
		try {
			System.out.println("path--->>>"+ControllerUtils.class.getResource("/").getPath());
			//String path = ControllerUtils.class.getResource("/").getPath();
			String path = request.getSession().getServletContext().getRealPath("");
			if(!(path.endsWith("/"))){
				path=path+"/";
			}
			path=path+"WEB-INF/classes/app.properties";
			s.load(new FileInputStream(new File(path)));			
			Enumeration e=s.propertyNames();
			while(e.hasMoreElements()){
				String strKey=(String) e.nextElement();
				String strValue=s.getProperty(strKey);
				result.put(strKey, strValue);
			}			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	
	
}
