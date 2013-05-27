package com.raysmond.db.dao;

import java.util.List;

import com.raysmond.bean.Comment;

public interface CommentDao extends BaseDao {
	public List<Comment> getAllComments(int page,int pageSize);
	public List<Comment> getCommentsOfPhoto(int photoId);
	public boolean addCommentToPhoto(Comment comment,int photoId);
	public boolean removeCommentOfPhoto(int commentId,int photoId);
}
