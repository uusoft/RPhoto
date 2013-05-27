package com.raysmond.db.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import com.raysmond.bean.Comment;
import com.raysmond.bean.PhotoHasTag;
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
	public boolean checkPhotoHasTag(String name) {
		boolean result = false;
		try {
			db = new Database();
			connect = db.getConnection();
			PreparedStatement ps = connect
					.prepareStatement("SELECT * FROM photo_has_tag,tag WHERE tag.tid=photo_has_tag.tag_tid AND tag.name=?");
			ps.setString(1, name);
			ResultSet results = ps.executeQuery();
			if(results.next()) result = true;
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

}
