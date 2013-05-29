package com.raysmond.db.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.raysmond.bean.Album;
import com.raysmond.bean.Comment;
import com.raysmond.bean.Photo;
import com.raysmond.bean.Tag;
import com.raysmond.db.dao.PhotoDao;

public class PhotoDaoImpl implements PhotoDao{
	private Database db;
	private Connection connect;
	@Override
	public int insert(Object entity) {
		if(!(entity instanceof Photo)) return -1;
		Photo photo = (Photo) entity;
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"INSERT INTO photo (pid,name,type,uri,size,create_time,album_aid,views) " +
					"VALUES(null,?,?,?,?,?,?,?)");
			ps.setString(1, photo.getName());
			ps.setString(2, photo.getType());
			ps.setString(3, photo.getUri());
			ps.setInt(4, photo.getSize());
			ps.setTimestamp(5, photo.getCreateTime());
			ps.setInt(6, photo.getAid());
			ps.setInt(7, photo.getViews());
			int insertedId = ps.executeUpdate();
			photo.setPid(insertedId);
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return photo.getPid();
	}

	@Override
	public boolean update(Object entity) {
		if(!(entity instanceof Photo)) return false;
		Photo photo = (Photo) entity;
		boolean result = false;
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"UPDATE photo SET name=?,type=?,uri=?,size=?,create_time=?,album_aid=?,views=?) " +
					" WHERE pid=?");
			ps.setString(1, photo.getName());
			ps.setString(2, photo.getType());
			ps.setString(3, photo.getUri());
			ps.setInt(4, photo.getSize());
			ps.setTimestamp(5, photo.getCreateTime());
			ps.setInt(6, photo.getAid());
			ps.setInt(7, photo.getViews());
			ps.setInt(8, photo.getPid());
			int insertedId = ps.executeUpdate();
			if(insertedId>0) result = true;
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
		if(!(entity instanceof Photo)) return false;
		Photo photo = (Photo) entity;
		int result = 0;
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"DELETE FROM photo WHERE pid=?");
			ps.setInt(1, photo.getPid());
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
	public List find(Object entity) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List find(HashMap map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addTag(Photo photo, Tag tag) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean removeTag(Photo photo, Tag tag) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean addComment(Photo photo, Comment comment) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean removeComment(Photo photo, Comment comment) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<Photo> getPhotoInAlbum(int albumId) {
		List<Photo> photos = new ArrayList<Photo>();
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT * FROM photo,album WHERE album.aid=photo.album_aid AND album_aid=? ORDER BY photo.pid DESC ");
			ps.setInt(1, albumId);
			ResultSet results = ps.executeQuery();
			while(results.next()){
				Photo photo = new Photo();
				photo.setPid(results.getInt(1));
				photo.setName(results.getString(2));
				photo.setType(results.getString(2));
				photo.setUri(results.getString(4));
				photo.setSize(results.getInt(5));
				photo.setCreateTime(results.getTimestamp(6));
				photo.setAid(results.getInt(7));
				photo.setViews(results.getInt(8));
				photos.add(photo);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return photos;
	}

	@Override
	public Photo getPhotoById(int photoId) {
		Photo photo = new Photo();
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT * FROM photo WHERE pid=? ");
			ps.setInt(1, photoId);
			ResultSet results = ps.executeQuery();
			if(results.next()){
				photo.setPid(results.getInt(1));
				photo.setName(results.getString(2));
				photo.setType(results.getString(2));
				photo.setUri(results.getString(4));
				photo.setSize(results.getInt(5));
				photo.setCreateTime(results.getTimestamp(6));
				photo.setAid(results.getInt(7));
				photo.setViews(results.getInt(8));
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return photo;
	}

	@Override
	public boolean deletePhotosInAlbum(int albumId) {
		int result = 0;
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"DELETE FROM photo WHERE album_aid=?");
			ps.setInt(1, albumId);
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

}
