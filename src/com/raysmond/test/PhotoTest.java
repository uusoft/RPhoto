package com.raysmond.test;

import static org.junit.Assert.*;

import java.sql.Date;
import java.sql.Timestamp;

import org.junit.Test;

import com.raysmond.bean.Photo;
import com.raysmond.db.dao.PhotoDao;
import com.raysmond.db.impl.PhotoDaoImpl;

public class PhotoTest {
	PhotoDao dao = new PhotoDaoImpl();
	@Test
	public void testAddPhotoToAlbum() {
		for(int i=0;i<4;i++){
			Photo photo = new Photo();
			photo.setAid(7);
			photo.setName("»·Çò·ç¾°"+i);
			photo.setSize(34657);
			photo.setType("image/jpeg");
			photo.setUri("images/public/u_1/"+(i+1)+".jpg");
			photo.setViews(3);
			java.util.Date date = new java.util.Date();
		    Timestamp timeStamp = new Timestamp(date.getTime());
			photo.setCreateTime(timeStamp);
			int insertId = dao.insert(photo);
			if(insertId<=0) fail("Insert album failed.");
		}
		assertTrue(true);
	}

}
