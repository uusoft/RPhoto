package com.raysmond.db.dao;

import java.util.List;

import com.raysmond.bean.Photo;

public interface PhotoHasTagDao extends BaseDao {
	public boolean checkPhotoHasTag(String name,int photoId);
	public List<Photo> getPhotosHasTag(String tagName); 
}
