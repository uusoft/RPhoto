package com.raysmond.db.dao;

import java.util.List;

import com.raysmond.bean.Album;

public interface AlbumDao extends BaseDao{
	//��ȡ�û�������ר��
	public List<Album> getPublicUserAlbum(int userId);
	//��ȡ�û�����ר��
	public List<Album> getUserAlbums(int userId);
	//��ȡ�û�˽��ר��
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
