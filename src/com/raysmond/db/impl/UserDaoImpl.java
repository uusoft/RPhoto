package com.raysmond.db.impl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.raysmond.bean.User;
import com.raysmond.db.dao.UserDao;

public class UserDaoImpl implements UserDao{

	private Connection connect;
	private Database db;
	
	@Override
	public int insert(Object entity) {
		if(!(entity instanceof User)) return -1;
		User user = (User) entity;
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"INSERT INTO user (uid,name,password,mail,status,create_time,last_login_time,rid,picture) " +
					"VALUES(null,?,?,?,?,?,?,?,?)");
			ps.setString(1, user.getName());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getMail());
			ps.setInt(4, user.getStatus());
			ps.setDate(5, user.getCreateTime());
			ps.setDate(6, user.getLastLoginTime());
			ps.setInt(7, user.getRid());
			ps.setString(8, user.getPicture());
			int userId = ps.executeUpdate();
			user.setUid(userId);
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user.getUid();
	}

	@Override
	public boolean update(Object entity) {
		if(!(entity instanceof User)) return false;
		User user = (User) entity;
		int result = 0;
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"UPDATE user SET name=?,password=?,mail=?,status=?,create_time=?,last_login_time=?,rid=?,picture=?) " +
					" WHERE user.uid=?");
			ps.setString(1, user.getName());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getMail());
			ps.setInt(4, user.getStatus());
			ps.setDate(5, user.getCreateTime());
			ps.setDate(6, user.getLastLoginTime());
			ps.setInt(7, user.getRid());
			ps.setString(8, user.getPicture());
			ps.setInt(9, user.getUid());
			result = ps.executeUpdate();
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(result==0) return false;
		return true;
	}

	@Override
	public boolean delete(Object entity) {
		if(!(entity instanceof User)) return false;
		User user = (User) entity;
		int result = 0;
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"DELETE FROM user WHERE user.uid=?");
			ps.setInt(1, user.getUid());
			result = ps.executeUpdate();
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(result==0) return false;
		return true;
	}

	@Override
	public List<User> find(Object entity) {
		if(!(entity instanceof User)) return null;
		
		return null;
	}
	public List<User> find(String key,String value){
		List<User> users = new ArrayList<User>();
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT * FROM user WHERE "+key+"=?");
			ps.setString(1, value);
			ResultSet result = ps.executeQuery();
			while(result.next()){
				User user = new User();
				user.setUid(result.getInt(1));
				user.setName(result.getString(2));
				user.setPassword(result.getString(3));
				user.setMail(result.getString(4));
				user.setStatus(result.getInt(5));
				user.setCreateTime(result.getDate(6));
				user.setLastLoginTime(result.getDate(7));
				user.setRid(result.getInt(8));
				user.setPicture(result.getString(9));
				users.add(user);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return users;
	}

	@Override
	public  List<User> find(HashMap map) {
		List<User> users = new ArrayList<User>();
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT * FROM user WHERE ?=?");
			if(map.containsKey("name"));
			ps.setString(1, "name");
			ps.setString(2, (String)map.get("name"));
			ResultSet result = ps.executeQuery();
			while(result.next()){
				User user = new User();
				user.setUid(result.getInt(1));
				user.setName(result.getString(2));
				user.setPassword(result.getString(3));
				user.setMail(result.getString(4));
				user.setStatus(result.getInt(5));
				user.setCreateTime(result.getDate(6));
				user.setLastLoginTime(result.getDate(7));
				user.setRid(result.getInt(8));
				user.setPicture(result.getString(9));
				users.add(user);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return users;
	}

	@Override
	public List<User> getUsers(int page, int pageSize) {
		int begin = page * pageSize;
		int end = begin + pageSize;
		List<User> users = new ArrayList<User>();
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT * FROM user LIMIT ?,?");
			ps.setInt(1, begin);
			ps.setInt(2, end);
			ResultSet result = ps.executeQuery();
			while(result.next()){
				User user = new User();
				user.setUid(result.getInt(1));
				user.setName(result.getString(2));
				user.setPassword(result.getString(3));
				user.setMail(result.getString(4));
				user.setStatus(result.getInt(5));
				user.setCreateTime(result.getDate(6));
				user.setLastLoginTime(result.getDate(7));
				user.setRid(result.getInt(8));
				user.setPicture(result.getString(9));
				users.add(user);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return users;
	}
	
	public static void main(String args[]){
		/*UserDao dao = new UserDaoImpl();
		User user = new User();
		user.setName("Raysmond");
		user.setPassword("12445523");
		user.setMail("jiankunlei@126.com");
		Date init = new Date(0L);
		user.setCreateTime(init);
		user.setLastLoginTime(init);
		user.setRid(1);
		dao.insert(user);
		*/
		
		UserDao dao = new UserDaoImpl();
		List<User> users = dao.find("name","Raysmond");
		System.out.println(users.size());
	}

	@Override
	public User getUserById(int uid) {
		User user = null;
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT * FROM user WHERE uid=?");
			ps.setInt(1, uid);
			ResultSet result = ps.executeQuery();
			while(result.next()){
				user = new User();
				user.setUid(result.getInt(1));
				user.setName(result.getString(2));
				user.setPassword(result.getString(3));
				user.setMail(result.getString(4));
				user.setStatus(result.getInt(5));
				user.setCreateTime(result.getDate(6));
				user.setLastLoginTime(result.getDate(7));
				user.setRid(result.getInt(8));
				user.setPicture(result.getString(9));
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

	
}
