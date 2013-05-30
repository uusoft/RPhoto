package com.raysmond.db.dao;

import java.util.List;

import com.raysmond.bean.Album;

public interface AlbumDao extends BaseDao{
	//获取用户公开的专辑
	public List<Album> getPublicUserAlbum(int userId);
	//获取用户所有专辑
	public List<Album> getUserAlbums(int userId);
	//获取用户私有专辑
	public List<Album> getPrivateUserAlbum(int userId);
	public List<Album> getAllAlbums(int page,int pageSize);
	public List<Album> getPublicAlbums(int page,int pageSize);
	public List<Album> getPublicAlbums(int page,int pageSize,String name);
	public Album getAlbumById(int albumId);
	public void createUserDefaultAlbum(int userId);
	public Album getUserDefaultAlbum(int userId);
	public int getCount();
	public void updateAlbumPhotoCount(int albumId);
	
}
