package com.raysmond.bean;

import java.sql.Date;
import java.sql.Timestamp;

public class User {
	private int uid;
	private String name;
	private String password;
	private String mail;
	private int status; //0: blocked, 1:active
	private Timestamp createTime;
	private Timestamp lastLoginTime;
	private int rid;
	private String picture;
	
	public User(){
		
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Timestamp getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Timestamp lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public int getRid() {
		return rid;
	}

	public void setRid(int rid) {
		this.rid = rid;
	}
	
	public String getPicture(){
		return picture;
	}
	
	public void setPicture(String picture){
		this.picture = picture;
	}
	
}
