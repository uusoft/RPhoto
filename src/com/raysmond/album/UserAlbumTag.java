package com.raysmond.album;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.raysmond.bean.Album;
import com.raysmond.bean.User;
import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.impl.AlbumDaoImpl;

public class UserAlbumTag extends TagSupport{
	private static final long serialVersionUID = -8099629037395242519L;

	private String userId;
	//all,public,private
	private String ispublic = "public";
	public void setIspublic(String ispublic){
		this.ispublic = ispublic;
	}
	public String getIspublic(){
		return ispublic;
	}
	public void setUserId(String userId){
		this.userId = userId;
	}
	public String getUserId(){
		return userId;
	}
	
	
	public int doEndTag() {
		JspWriter out = pageContext.getOut();
		getUserAlbums(out);
		return SKIP_BODY;
	}
	
	public boolean isLoginUser(){
		HttpSession session = pageContext.getSession();
		User user = (User) session.getAttribute("AUTH_USER");
		if(user!=null&&user.getUid()==Integer.parseInt(userId)){
			return true;
		}
		return false;
	}
	
	public void getUserAlbums(JspWriter out){
		try {
			int uid = Integer.parseInt(userId);
			AlbumDao dao = new AlbumDaoImpl();
			List<Album> albums = null;
			//System.out.println(ispublic);
			if(ispublic.equals("all")){
				albums = dao.getUserAlbums(uid);
			}
			else if(ispublic.equals("private")){
				albums = dao.getPrivateUserAlbum(uid);
			}
			else albums = dao.getPublicUserAlbum(uid);
		    
			//out.println("<h2>×¨¼­Êý£º"+albums.size()+"</h2>");
			out.print("<div class=\"row space-bot\">");
			int i=0,size = albums.size();
			for(;i<size;++i){
				Album album = albums.get(i);
				out.print("<div class=\"c3 album_item\" style=\"padding-left:5px;padding-right:5px;\">" +
				"<div class=\"note\" style=\"padding:10px;margin-bottom:10px;font-size:14px;line-height:150%;\">"
				+"<img src=\""
				+album.getCoverUri()+"\" style=\"width:225px;height:200px;\" />" +
				"<br/><a href=\"pictures.jsp?album="+album.getAid()+"\">"+album.getName()+"</a><br />"+
				"<span>"+album.getCreateTime()+"</span>"+
				"<span>&nbsp;&nbsp;"+album.getCount()+" ÕÅ</span>"+
				(isLoginUser()?addAdminHtml(album):"") +
				"</div>" +
				"</div>");
			}
			out.print("</div>");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public String addAdminHtml(Album album){
		StringBuffer html = new StringBuffer(255);
		html.append("<div class=\"album_admin_link\" id=\"admin_album_"+album.getAid()+"\">");
		html.append("<a href=\"javascript:editAlbum("+album.getAid()+",\'"
				+album.getName()+"\')\">±à¼­ </a><a href=\"AdminAlbum?action=delete_album&&aid="+album.getAid()+"\"> É¾³ý</a>");
		html.append("</div>");
		return html.toString();
	}
}
