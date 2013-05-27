package com.raysmond.db.impl;

import java.io.PrintStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.raysmond.bean.Album;
import com.raysmond.bean.Comment;
import com.raysmond.db.dao.CommentDao;

public class CommentDaoImpl implements CommentDao {
	Connection connect;
	Database db;

	@Override
	public int insert(Object entity) {
		if (!(entity instanceof Comment))
			return -1;
		Comment comment = (Comment) entity;
		try {
			db = new Database();
			connect = db.getConnection();
			PreparedStatement ps = connect
					.prepareStatement("INSERT INTO comment (cid,title,content,create_time,user_uid,photo_pid) "
							+ "VALUES(null,?,?,?,?,?)");
			ps.setString(1, comment.getTitle());
			ps.setString(2, comment.getContent());
			ps.setTimestamp(3, comment.getCreateTime());
			ps.setInt(4, comment.getUid());
			ps.setInt(5, comment.getPid());
			int result = ps.executeUpdate();
			if (result > 0) {
				ResultSet rs = ps.getGeneratedKeys();
				rs.next();
				int _id = rs.getInt(1);
				comment.setCid(_id);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return comment.getCid();
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
	public List<Comment> getCommentsOfPhoto(int photoId) {
		List<Comment> comments = new ArrayList<Comment>();
		try {
			db = new Database();
			connect = db.getConnection();
			PreparedStatement ps = connect
					.prepareStatement("SELECT * FROM comment WHERE photo_pid=? ORDER BY cid DESC");
			ps.setInt(1, photoId);
			ResultSet results = ps.executeQuery();
			while (results.next()) {
				Comment comment = new Comment();
				comment.setCid(results.getInt(1));
				comment.setTitle(results.getString(2));
				comment.setContent(results.getString(3));
				comment.setCreateTime(results.getTimestamp(4));
				comment.setUid(results.getInt(5));
				comment.setPid(results.getInt(6));
				comments.add(comment);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return comments;
	}

	@Override
	public boolean addCommentToPhoto(Comment comment, int photoId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean removeCommentOfPhoto(int commentId, int photoId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<Comment> getAllComments(int page, int pageSize) {
		int begin = page * pageSize + 1;
		int end = begin + pageSize - 1;
		List<Comment> comments = new ArrayList<Comment>();
		try {
			db = new Database();
			connect = db.getConnection();
			PreparedStatement ps = connect
					.prepareStatement("SELECT * FROM comment,user WHERE comment.user_uid=user.uid ORDER BY comment.cid DESC LIMIT ?,?");
			ps.setInt(1, begin);
			ps.setInt(2, end);
			ResultSet results = ps.executeQuery();
			while (results.next()) {
				Comment comment = new Comment();
				comment.setCid(results.getInt(1));
				comment.setTitle(results.getString(2));
				comment.setContent(results.getString(3));
				comment.setCreateTime(results.getTimestamp(4));
				comment.setUid(results.getInt(5));
				comment.setPid(results.getInt(6));
				comments.add(comment);
			}
			ps.close();
			db.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return comments;
	}
}
