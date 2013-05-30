package com.raysmond.admin;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.dao.PhotoDao;
import com.raysmond.db.dao.UserDao;
import com.raysmond.db.impl.AlbumDaoImpl;
import com.raysmond.db.impl.PhotoDaoImpl;
import com.raysmond.db.impl.UserDaoImpl;

public class CountTag extends TagSupport {
	private static final long serialVersionUID = 2954161266474775974L;
	private String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public int doEndTag() {
		JspWriter out = pageContext.getOut();
		getCount(out);
		return SKIP_BODY;
	}
	public void getCount(JspWriter out){
		CountType _type = getCountType(getType());
		if(_type!=null){
			int count = 0;
			switch(_type){
			case USER:
				UserDao userDao = new UserDaoImpl();
				count = userDao.getCount();
				break;
			case ALBUM:
				AlbumDao albumDao = new AlbumDaoImpl();
				count = albumDao.getCount();
				break;
			case PHOTO:
				PhotoDao photoDao = new PhotoDaoImpl();
				count = photoDao.getCount();
				break;
			case COMMENT:
				break;
			case TAG:
				break;
			}
			try {
				out.print(count);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	public static CountType getCountType(String count){
		if(count==null) return null;
		if(count.equalsIgnoreCase("user")){
			return CountType.USER;
		}
		else if(count.equalsIgnoreCase("album")){
			return CountType.ALBUM;
		}
		else if(count.equalsIgnoreCase("photo")){
			return CountType.PHOTO;
		}
		else if(count.equalsIgnoreCase("comment")){
			return CountType.COMMENT;
		}
		else if(count.equalsIgnoreCase("tag")){
			return CountType.TAG;
		}
		return null;
	}
}
