package com.cai.util;

import java.util.ArrayList;
import java.util.List;

import com.cai.entity.MenuEntity;

public class List2Json {
	
	public static List<MenuEntity> list2Json(String pid,List<MenuEntity> sourceList){
		List<MenuEntity> list=new ArrayList<>();
		for (MenuEntity menuEntity : sourceList) {
			if(menuEntity.getPid().equals(pid)){
				menuEntity.setChildren(list2Json(menuEntity.getId(),sourceList));
				list.add(menuEntity);
			}
		}
		return list;
	}

}
