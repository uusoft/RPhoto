package com.raysmond.bean;

import java.sql.Date;
import java.sql.Timestamp;

public class Album {
	private int aid;
	private String name;
	private int uid;
	private Timestamp createTime;
	private Timestamp updateTime;
	private int ispublic;
	private int count;
	private String coverUri;
	private User user = new User();

	public void setUser(User user){
		this.user = user;
	}
	public User getUser(){
		return user;
	}
	public Album(){
		
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Timestamp getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}

	public int getIspublic() {
		return ispublic;
	}

	public void setIspublic(int ispublic) {
		this.ispublic = ispublic;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
	public String getCoverUri(){
		return coverUri;
	}
	
	public void setCoverUri(String coverUri){
		this.coverUri = coverUri;
	}
	
	
}
