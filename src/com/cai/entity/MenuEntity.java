package com.cai.entity;

import java.util.List;

public class MenuEntity {
	
	private String id;
	
	private String pid;
	
	private String text;
	
	private String url;
	
	@Override
	public String toString() {
		return "MenuEntity [id=" + id + ", pid=" + pid + ", text=" + text + ", url=" + url + ", children=" + children
				+ "]";
	}

	public MenuEntity() {
		super();
	}

	private List<MenuEntity> children;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<MenuEntity> getChildren() {
		return children;
	}

	public void setChildren(List<MenuEntity> children) {
		this.children = children;
	}

}
