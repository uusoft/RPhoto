package com.raysmond.test;

import static org.junit.Assert.*;

import java.sql.Timestamp;

import org.junit.Test;

import com.raysmond.bean.Comment;
import com.raysmond.db.dao.CommentDao;
import com.raysmond.db.impl.CommentDaoImpl;

public class CommentTest {

	@Test
	public void testInsertComment() {
		Comment comment = new Comment();
		comment.setTitle("none");
		comment.setContent("照片很精美哦！");
		comment.setPid(36);
		comment.setUid(2);
		java.util.Date date = new java.util.Date();
	    Timestamp timeStamp = new Timestamp(date.getTime());
		comment.setCreateTime(timeStamp);
		CommentDao dao = new CommentDaoImpl();
		if(dao.insert(comment)>0){
			assertTrue(true);
		}
		else fail("添加评论测试失败");
	}

}
