package com.raysmond.db.dao;

import java.util.List;

import com.raysmond.bean.Tag;

public interface TagDao extends BaseDao{
	public Tag getTagByName(String name);
	public List<Tag> getTagsByPhotoId(int photoId);
	public List<Tag> getTagsByUser(int userId);
	public List<Tag> getAllTags(int count,boolean hasPhoto);
	public boolean addTagToPhoto(Tag tag,int photoId);
	public boolean removeTagOfPhoto(int tid,int photoId);
}
