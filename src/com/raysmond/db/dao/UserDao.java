package com.raysmond.db.dao;

import java.util.List;

import com.raysmond.bean.User;

public interface UserDao extends BaseDao{
	public List<User> find(String key,String value);
	public List<User> getUsers(int page,int pageSize);
	public User getUserById(int uid);
	public int getCount();
}
