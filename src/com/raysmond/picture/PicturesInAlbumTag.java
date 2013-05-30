package com.raysmond.picture;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.raysmond.bean.Album;
import com.raysmond.bean.Photo;
import com.raysmond.bean.User;
import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.dao.PhotoDao;
import com.raysmond.db.impl.AlbumDaoImpl;
import com.raysmond.db.impl.PhotoDaoImpl;

public class PicturesInAlbumTag extends TagSupport{

	private static final long serialVersionUID = 2956340054272588131L;
	private PhotoDao dao = new PhotoDaoImpl();
	private String albumId;
	
	public String getAlbumId(){
		return albumId;
	}
	
	public void setAlbumId(String albumId){
		this.albumId = albumId;
	}
	
	public int doEndTag() {
		JspWriter out = pageContext.getOut();
		getPicturesInAlbum(out);
		return SKIP_BODY;
	}
	
	
	public void getPicturesInAlbum(JspWriter out){
		List<Photo> pictures = dao.getPhotoInAlbum(Integer.parseInt(albumId));
		if(pictures==null||pictures.size()==0){
			try {
				out.print("»¹Ã»ÓÐÍ¼Æ¬Å¶£¡");
			} catch (IOException e) {
				e.printStackTrace();
			}
			return;
		}
		Album album = new AlbumDaoImpl().getAlbumById(Integer.parseInt(albumId));
		User user = (User)pageContext.getSession().getAttribute("AUTH_USER");
		boolean isCurrentUser = false;
		//System.out.println(user.getUid());
		if(user!=null&&user.getUid()==album.getUid()){
			isCurrentUser = true;
		}
		StringBuffer buffer = new StringBuffer(1024);
		buffer.append("<div class=\"row space-bot\">");
		int i=0,size = pictures.size();
		buffer.append("<div style=\"clear:both;\"></div>");
		for(;i<size;++i){
			Photo photo = pictures.get(i);
			buffer.append("<div class=\"c3\" style=\"padding-left:5px;padding-right:5px;margin-bottom:15px;\">" +
					"<div style=\"line-height:160%;padding:10px;font-size:14px;\" class=\"note\">" +
					"<img src=\""+photo.getUri()
					+"\" style=\"width:225px;height:210px;margin-bottom:10px;\" /><br/>"
					+ "<div style=\"word-break:break-all;max-width:225px;\">" +photo.getName() + "</div>"
					+ ((isCurrentUser)?getAdminHTML(photo):"") 
					+"</div></div>");
		}
		buffer.append("</div>");
		try {
			out.print(buffer.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public String getAdminHTML(Photo photo){
		String html =  "<a style=\"float:right;position:absolute;right:25px;top:195px;\" " +
				" href=\"javascript:editPhotoName("+photo.getPid()+",\'"+photo.getName()+"\')\">±à¼­</a>";
		return html;
	}
}
