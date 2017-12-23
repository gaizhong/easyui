package com.cai.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cai.dao.LoginDaoImpl;
import com.cai.entity.MenuEntity;

@Service
public class LoginServiceImpl {
	
	@Autowired
	LoginDaoImpl loginDaoImpl;
	
	public List<MenuEntity> allMenu(){
		return loginDaoImpl.allMenu();
	}

	

	
}
