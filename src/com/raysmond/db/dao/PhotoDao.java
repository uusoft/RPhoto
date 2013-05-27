package com.raysmond.db.dao;

import java.util.List;

import com.raysmond.bean.Comment;
import com.raysmond.bean.Photo;
import com.raysmond.bean.Tag;

public interface PhotoDao extends BaseDao{
	public boolean addTag(Photo photo,Tag tag);
	public boolean removeTag(Photo photo,Tag tag);
	public boolean addComment(Photo photo,Comment comment);
	public boolean removeComment(Photo photo,Comment comment);
	public List<Photo> getPhotoInAlbum(int albumId);
	public Photo getPhotoById(int photoId);
}
