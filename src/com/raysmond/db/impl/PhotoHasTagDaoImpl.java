package com.raysmond.db.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.raysmond.bean.Comment;
import com.raysmond.bean.Photo;
import com.raysmond.bean.PhotoHasTag;
import com.raysmond.bean.Tag;
import com.raysmond.db.dao.PhotoHasTagDao;

public class PhotoHasTagDaoImpl implements PhotoHasTagDao {
	Connection connect;
	Database db;

	@Override
	public int insert(Object entity) {
		if (!(entity instanceof PhotoHasTag))
			return -1;
		PhotoHasTag photoHasTag = (PhotoHasTag) entity;
		try {
			db = new Database();
			connect = db.getConnection();
			PreparedStatement ps = connect
					.prepareStatement("INSERT INTO photo_has_tag (photo_pid,tag_tid) VALUES(?,?)");
			ps.setInt(1, photoHasTag.getPid());
			ps.setInt(2, photoHasTag.getTid());
			int result = ps.executeUpdate();
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
		return 1;
	}

	@Override
	public boolean update(Object entity) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(Object entity) {
		if (!(entity instanceof PhotoHasTag))
			return false;
		PhotoHasTag photo = (PhotoHasTag) entity;
		int result = 0;
		try {
			db = new Database();
			connect = db.getConnection();
			PreparedStatement ps = connect
					.prepareStatement("DELETE FROM photo_has_tag WHERE photo_pid=?");
			ps.setInt(1, photo.getPid());
			result = ps.executeUpdate();
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (result == 0)
			return false;
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
	public boolean checkPhotoHasTag(String name,int photoId) {
		boolean result = false;
		try {
			db = new Database();
			connect = db.getConnection();
			PreparedStatement ps = connect
					.prepareStatement("SELECT * FROM photo_has_tag,tag" +
							" WHERE tag.tid=photo_has_tag.tag_tid" +
							" AND photo_has_tag.photo_pid=?" +
							" AND tag.name=?");
			ps.setInt(1, photoId);
			ps.setString(2, name);
			ResultSet results = ps.executeQuery();
			if (results.next())
				result = true;
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
	public List<Photo> getPhotosHasTag(String tagName) {
		List<Photo> photos = new ArrayList<Photo>();
		try {
			System.out.println("get photos of tag: " + tagName);
			db = new Database();
			connect = db.getConnection();
			PreparedStatement ps = connect
					.prepareStatement("SELECT * FROM photo,album,photo_has_tag,tag" +
							" WHERE album.aid=photo.album_aid" +
							" AND photo_has_tag.photo_pid=photo.pid " +
							" AND photo_has_tag.tag_tid=tag.tid AND" +
							" tag.name=? ORDER BY photo.pid DESC ");
			ps.setString(1, tagName);
			ResultSet results = ps.executeQuery();
			while (results.next()) {
				Photo photo = new Photo();
				photo.setPid(results.getInt("photo.pid"));
				photo.setName(results.getString("photo.name"));
				photo.setType(results.getString("photo.type"));
				photo.setUri(results.getString("photo.uri"));
				photo.setSize(results.getInt("photo.size"));
				photo.setCreateTime(results.getTimestamp("photo.create_time"));
				photo.setAid(results.getInt("photo.album_aid"));
				photo.setViews(results.getInt("photo.views"));
				Tag newtag = new Tag();
				newtag.setTid(results.getInt("tag.tid"));
				newtag.setName(results.getString("tag.name"));
				photo.getTags().add(newtag);
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

	public static void main(String args[]){
		PhotoHasTagDao dao = new PhotoHasTagDaoImpl();
		List<Photo> photos = dao.getPhotosHasTag("Hi");
		System.out.println(photos.size());
	}
}
