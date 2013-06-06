package com.raysmond.db.impl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.raysmond.bean.*;
import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.dao.PhotoDao;

public class AlbumDaoImpl implements AlbumDao{
	private Database db;
	private Connection connect;
	@Override
	public int insert(Object entity) {
		if(!(entity instanceof Album)) return -1;
		Album album = (Album) entity;
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"INSERT INTO album (aid,name,uid,create_time,update_time,ispublic,count,cover_uri) " +
					"VALUES(null,?,?,?,?,?,?,?)");
			ps.setString(1, album.getName());
			ps.setInt(2, album.getUid());
			ps.setTimestamp(3, album.getCreateTime());
			ps.setTimestamp(4, album.getUpdateTime());
			ps.setInt(5, album.getIspublic());
			ps.setInt(6, album.getCount());
			ps.setString(7, album.getCoverUri());
			int result = ps.executeUpdate();
			if(result>0){
				ResultSet rs = ps.getGeneratedKeys();
				rs.next();  
				int _id = rs.getInt(1);
				album.setAid(_id);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return album.getAid();
	}

	@Override
	public boolean update(Object entity) {
		if(!(entity instanceof Album)) return false;
		Album album = (Album) entity;
		boolean result = false;
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"UPDATE album SET name=?,uid=?,create_time=?,update_time=?,ispublic=?,count=?,cover_uri=? " +
					" WHERE aid=?");
			ps.setString(1, album.getName());
			ps.setInt(2, album.getUid());
			ps.setTimestamp(3, album.getCreateTime());
			ps.setTimestamp(4, album.getUpdateTime());
			ps.setInt(5, album.getIspublic());
			ps.setInt(6, album.getCount());
			ps.setString(7, album.getCoverUri());
			ps.setInt(8, album.getAid());
			int id = ps.executeUpdate();
			if(id>0) result = true;
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public boolean delete(Object entity) {
		if(!(entity instanceof Album)) return false;
		Album album = (Album) entity;
		boolean result = false;
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"DELETE FROM album WHERE aid=?");
			ps.setInt(1, album.getAid());
			int id = ps.executeUpdate();
			if(id>0) result = true;
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List find(Object entity) {
		return null;
	}

	@Override
	public List find(HashMap map) {
		return null;
	}

	@Override
	public List<Album> getUserAlbums(int userId) {
		List<Album> albums = new ArrayList<Album>();
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT * FROM album WHERE uid=? ORDER BY aid DESC");
			ps.setInt(1, userId);
			ResultSet results = ps.executeQuery();
			while(results.next()){
				Album album = new Album();
				album.setAid(results.getInt(1));
				album.setName(results.getString(2));
				album.setUid(results.getInt(3));
				album.setCreateTime(results.getTimestamp(4));
				album.setUpdateTime(results.getTimestamp(5));
				album.setIspublic(results.getInt(6));
				album.setCount(results.getInt(7));
				album.setCoverUri(results.getString(8));
				albums.add(album);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return albums;
	}
	
	public static void main(String[] args){
		AlbumDao dao = new AlbumDaoImpl();
		PhotoDao photoDao = new PhotoDaoImpl();
		/*
		for(int i=0;i<10;i++){
			Photo photo = new Photo();
			photo.setAid(1);
			photo.setName("张江校区"+i);
			photo.setSize(34657);
			photo.setType("image/jpeg");
			photo.setUri("images/public/zhangjiang"+i+".jpg");
			photo.setViews(3);
			photo.setCreateTime(new Date(0));
			PhotoDao photoDao = new PhotoDaoImpl();
			photoDao.insert(photo);
		}*/
		
		List<Photo> photos = photoDao.getPhotoInAlbum(1);
		System.out.println(photos.size());
	}

	@Override
	public Album getAlbumById(int albumId) {
		Album album = new Album();
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT album.aid,album.name AS album_name,album.uid AS album_uid," +
					" album.create_time,album.update_time,album.ispublic,album.count,album.cover_uri," +
					" user.uid AS user_uid,user.name AS user_name " +
					" FROM album,user WHERE aid=? AND album.uid=user.uid");
			ps.setInt(1, albumId);
			ResultSet results = ps.executeQuery();
			while(results.next()){
				album.setAid(results.getInt("aid"));
				album.setName(results.getString("album_name"));
				album.setUid(results.getInt("album_uid"));
				album.setCreateTime(results.getTimestamp("album.create_time"));
				album.setUpdateTime(results.getTimestamp("album.update_time"));
				album.setIspublic(results.getInt("album.ispublic"));
				album.setCount(results.getInt("album.count"));
				album.setCoverUri(results.getString("album.cover_uri"));
				User user = new User();
				user.setUid(results.getInt("user_uid"));
				user.setName(results.getString("user_name"));
				album.setUser(user);
				break;
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return album;
	}
	
	public List<Album> getUserAlbum(int userId,int ispublic){
		List<Album> albums = new ArrayList<Album>();
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT * FROM album WHERE uid=? AND ispublic=? ORDER BY aid DESC");
			ps.setInt(1, userId);
			ps.setInt(2, ispublic);
			ResultSet results = ps.executeQuery();
			while(results.next()){
				Album album = new Album();
				album.setAid(results.getInt(1));
				album.setName(results.getString(2));
				album.setUid(results.getInt(3));
				album.setCreateTime(results.getTimestamp(4));
				album.setUpdateTime(results.getTimestamp(5));
				album.setIspublic(results.getInt(6));
				album.setCount(results.getInt(7));
				album.setCoverUri(results.getString(8));
				albums.add(album);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return albums;
	}

	@Override
	public List<Album> getPublicUserAlbum(int userId) {
		//公开专辑，ispublic=1
		return getUserAlbum(userId,1);
	}

	@Override
	public List<Album> getPrivateUserAlbum(int userId) {
		//私有专辑，ispublic=0
		return getUserAlbum(userId,0);
	}

	/**
	 * page begins from 0
	 */
	@Override
	public List<Album> getPublicAlbums(int page, int pageSize) {
		int begin = page * pageSize;
		int end = begin + pageSize;
		List<Album> albums = new ArrayList<Album>();
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT * FROM album WHERE album.ispublic=1 ORDER BY album.aid DESC LIMIT ?,?");
			ps.setInt(1, begin);
			ps.setInt(2, end);
			ResultSet results = ps.executeQuery();
			while(results.next()){
				Album album = new Album();
				album.setAid(results.getInt(1));
				album.setName(results.getString(2));
				album.setUid(results.getInt(3));
				album.setCreateTime(results.getTimestamp(4));
				album.setUpdateTime(results.getTimestamp(5));
				album.setIspublic(results.getInt(6));
				album.setCount(results.getInt(7));
				album.setCoverUri(results.getString(8));
				albums.add(album);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return albums;
	}

	@Override
	public void createUserDefaultAlbum(int userId) {
		Album album = new Album();
		album.setCount(0);
		album.setCoverUri("images/default_album.jpg");
		album.setIspublic(1);
		album.setName("默认相册");
		album.setUid(userId);
		java.util.Date date = new java.util.Date();
	    Timestamp timeStamp = new Timestamp(date.getTime());
		album.setUpdateTime(timeStamp);
		album.setCreateTime(timeStamp);
		insert(album);
	}
	
	@Override
	public Album getUserDefaultAlbum(int userId){
		Album album = new Album();
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT * FROM album WHERE uid=? ORDER BY aid ASC LIMIT 1");
			ps.setInt(1, userId);
			ResultSet results = ps.executeQuery();
			while(results.next()){
				album.setAid(results.getInt(1));
				album.setName(results.getString(2));
				album.setUid(results.getInt(3));
				album.setCreateTime(results.getTimestamp(4));
				album.setUpdateTime(results.getTimestamp(5));
				album.setIspublic(results.getInt(6));
				album.setCount(results.getInt(7));
				album.setCoverUri(results.getString(8));
				break;
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return album;
	}

	@Override
	public int getCount() {
		int count = 0;
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT COUNT(aid) AS countall FROM album");
			ResultSet result = ps.executeQuery();
			if(result.first()){
				count = result.getInt("countall");
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public List<Album> getPublicAlbums(int page, int pageSize, String name) {
		int begin = page * pageSize;
		int end = begin + pageSize;
		List<Album> albums = new ArrayList<Album>();
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT * FROM album WHERE album.ispublic=1 AND album.name LIKE ? ORDER BY album.aid DESC ");
			ps.setString(1, "%" + name + "%");
			//ps.setInt(2, begin);
			//ps.setInt(3, end);
			System.out.print(ps.toString());
			ResultSet results = ps.executeQuery();
			while(results.next()){
				Album album = new Album();
				album.setAid(results.getInt(1));
				album.setName(results.getString(2));
				album.setUid(results.getInt(3));
				album.setCreateTime(results.getTimestamp(4));
				album.setUpdateTime(results.getTimestamp(5));
				album.setIspublic(results.getInt(6));
				album.setCount(results.getInt(7));
				album.setCoverUri(results.getString(8));
				albums.add(album);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return albums;
	}

	@Override
	public List<Album> getAllAlbums(int page, int pageSize) {
		int begin = page * pageSize;
		int end = begin + pageSize;
		List<Album> albums = new ArrayList<Album>();
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT * FROM album AS album,user AS user WHERE album.uid=user.uid ORDER BY album.aid DESC LIMIT ?,?");
			ps.setInt(1, begin);
			ps.setInt(2, end);
			System.out.println(ps.toString());
			ResultSet results = ps.executeQuery();
			while(results.next()){
				Album album = new Album();
				album.setAid(results.getInt("album.aid"));
				album.setName(results.getString("album.name"));
				album.setUid(results.getInt("album.uid"));
				album.setCreateTime(results.getTimestamp("album.create_time"));
				album.setUpdateTime(results.getTimestamp("album.update_time"));
				album.setIspublic(results.getInt("album.ispublic"));
				album.setCount(results.getInt("album.count"));
				album.setCoverUri(results.getString("album.cover_uri"));
				album.getUser().setUid(results.getInt("user.uid"));
				album.getUser().setName(results.getString("user.name"));
				albums.add(album);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return albums;
	}

	@Override
	public void updateAlbumPhotoCount(int albumId) {
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps0 = connect.prepareStatement("select count(*) cnt from photo where album_aid=?");
			ps0.setInt(1, albumId);
			ResultSet result = ps0.executeQuery();
			if(result.first()){
				PreparedStatement ps = connect.prepareStatement(
						"update album set count=? WHERE aid=?");
				ps.setInt(1, result.getInt("cnt"));
				ps.setInt(2, albumId);
				ps.executeUpdate();
				ps.close();
			}
			ps0.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
