package com.raysmond.test;

import static org.junit.Assert.*;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import org.junit.Test;

import com.raysmond.bean.Album;
import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.impl.AlbumDaoImpl;

public class AlbumTest {
	AlbumDao dao = new AlbumDaoImpl();
	@Test
	public void testInsertAlbum() {
		Album album = new Album();
		album.setUid(2);
		album.setName("∂¨»’∑Áπ‚");
		java.util.Date date = new java.util.Date();
	    Timestamp timeStamp = new Timestamp(date.getTime());
	    album.setCreateTime(timeStamp);
	    album.setUpdateTime(timeStamp);
		album.setIspublic(1);
		album.setCount(0);
		album.setCoverUri("images/public/u_2/cover2.jpg");
		int insertId = dao.insert(album);
		if(insertId<=0) fail("Insert album failed.");
		else assertTrue(true);
	}
	
	public void testGetUserAlbum(){
		List<Album> albums = dao.getUserAlbums(1);
		
	}

}
