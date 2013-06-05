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
import com.raysmond.bean.PhotoHasTag;
import com.raysmond.bean.Tag;
import com.raysmond.db.dao.TagDao;

public class TagDaoImpl implements TagDao {
	Connection connect;
	Database db;

	@Override
	public int insert(Object entity) {
		if (!(entity instanceof Tag))
			return -1;
		Tag tag = (Tag) entity;
		try {
			db = new Database();
			connect = db.getConnection();
			PreparedStatement ps = connect
					.prepareStatement("INSERT INTO tag (tid,name) VALUES(null,?)");
			ps.setString(1, tag.getName());
			int result = ps.executeUpdate();
			if (result > 0) {
				ResultSet rs = ps.getGeneratedKeys();
				rs.next();
				int _id = rs.getInt(1);
				tag.setTid(_id);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return tag.getTid();
	}

	@Override
	public boolean update(Object entity) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean delete(Object entity) {
		// TODO Auto-generated method stub
		return false;
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
	public List<Tag> getTagsByPhotoId(int photoId) {
		List<Tag> tags = new ArrayList<Tag>();
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT * FROM tag,photo_has_tag WHERE tag.tid=photo_has_tag.tag_tid AND photo_has_tag.photo_pid=?");
			ps.setInt(1, photoId);
			ResultSet results = ps.executeQuery();
			while(results.next()){
				Tag tag = new Tag();
				PhotoHasTag photoHasTag = new PhotoHasTag();
				tag.setTid(results.getInt("tid"));
				tag.setName(results.getString("name"));
				photoHasTag.setPid(photoId);
				photoHasTag.setTid(tag.getTid());
				tag.setPhotoHasTag(photoHasTag);
				tags.add(tag);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return tags;
	}

	@Override
	public List<Tag> getTagsByUser(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addTagToPhoto(Tag tag, int photoId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean removeTagOfPhoto(int tid, int photoId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Tag getTagByName(String name) {
		Tag tag = new Tag();
		try {
			db=new Database();
			connect=db.getConnection();
			PreparedStatement ps = connect.prepareStatement(
					"SELECT * FROM tag WHERE tag.name=?");
			ps.setString(1, name);
			ResultSet results = ps.executeQuery();
			while(results.next()){
				tag.setTid(results.getInt("tid"));
				tag.setName(results.getString("name"));
				break;
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return tag;
	}

	@Override
	public List<Tag> getAllTags(int count,boolean hasPhoto) {
		List<Tag> tags = new ArrayList<Tag>();
		try {
			db=new Database();
			connect=db.getConnection();
			String sql = "";
			if(!hasPhoto)sql = "SELECT * FROM tag ORDER BY tid DESC LIMIT ?";
			else sql = "SELECT * FROM tag,photo_has_tag,photo,album" +
					" WHERE photo_has_tag.tag_tid=tag.tid" +
					" AND photo_has_tag.photo_pid=photo.pid" +
					" AND photo.album_aid=album.aid ORDER BY tid DESC LIMIT ?";
			PreparedStatement ps = connect.prepareStatement(sql);
			System.out.println(sql);
			ps.setInt(1, count);
			ResultSet results = ps.executeQuery();
			while(results.next()){
				Tag tag = new Tag();
				tag.setTid(results.getInt("tag.tid"));
				tag.setName(results.getString("tag.name"));
				tags.add(tag);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return tags;
	}

}
