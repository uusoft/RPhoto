package com.raysmond.album;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.raysmond.bean.Album;
import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.impl.AlbumDaoImpl;

public class UserAlbumSelectList extends TagSupport{
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	private static final long serialVersionUID = -8099629037395242519L;

	private String userId;
	private String selectId;
	
	public String getSelectId() {
		return selectId;
	}

	public void setSelectId(String selectId) {
		this.selectId = selectId;
	}

	public int doEndTag() {
		JspWriter out = pageContext.getOut();
		getUserAlbums(out);
		return SKIP_BODY;
	}
	
	public void getUserAlbums(JspWriter out){
		try {
			int uid = Integer.parseInt(userId);
			int aid = -1;
			if(!selectId.equals("default")){
				aid = Integer.parseInt(selectId);
				System.out.println("selected:"+aid);
			}
			AlbumDao dao = new AlbumDaoImpl();
			List<Album> albums = dao.getUserAlbums(uid);
			out.print("<select id=\"user_album_list\" name=\"user_album_list\">");
			int i=0,size = albums.size();
			for(;i<size;++i){
				Album album = albums.get(i);
				if(aid!=-1&&aid==album.getAid()){
					System.out.println("selected:"+aid);
					out.print("<option selected=\"true\" value=\""+album.getAid()+"\">"+album.getName()+"</option>");
				}
				else out.print("<option value=\""+album.getAid()+"\">"+album.getName()+"</option>");
			}
			out.print("</select>");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
