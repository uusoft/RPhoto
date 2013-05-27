package com.raysmond.picture;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.raysmond.bean.Photo;
import com.raysmond.db.dao.PhotoDao;
import com.raysmond.db.impl.PhotoDaoImpl;

public class GalleriaSlideTag extends TagSupport{
	
	private static final long serialVersionUID = 7889677729099306146L;
	private String albumId;
	
	public String getAlbumId() {
		return albumId;
	}
	public void setAlbumId(String albumId) {
		this.albumId = albumId;
	}
	
	public int doEndTag() {
		getPhotosInAlbum();
		return SKIP_BODY;
	}
	/**
	 * Get all photos in the album and show it with Galleria
	 */
	public void getPhotosInAlbum(){
		JspWriter out = pageContext.getOut();
		PhotoDao dao = new PhotoDaoImpl();
		List<Photo> photos = dao.getPhotoInAlbum(Integer.parseInt(albumId));
		try{
			if(photos==null){
				out.print("Ã»ÓÐÍ¼Æ¬Å¶£¡");
			}
			//construct a string buffer to generate the HTML of Galleria photos slides
			StringBuffer galleria = new StringBuffer(1024);
			galleria.append("<div id=\"galleria\">");
			/*
			<a href="http://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Biandintz_eta_zaldiak_-_modified2.jpg/800px-Biandintz_eta_zaldiak_-_modified2.jpg">
            <img 
                src="http://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Biandintz_eta_zaldiak_-_modified2.jpg/100px-Biandintz_eta_zaldiak_-_modified2.jpg",
                data-big="http://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Biandintz_eta_zaldiak_-_modified2.jpg/1280px-Biandintz_eta_zaldiak_-_modified2.jpg"
                data-title="Biandintz eta zaldiak"
                data-description="Horses on Bianditz mountain, in Navarre, Spain."
            >
            </a>
            */
			int i=0,size = photos.size();
			StringBuffer photoFlag = new StringBuffer(256);
			photoFlag.append("[");
			for(;i<size;++i){
				Photo photo = photos.get(i);
				galleria.append("<a href=\"" + photo.getUri() + "\">");
				galleria.append("<img src=\"" + photo.getUri() + "\"");
				galleria.append(" data-big=\"" + photo.getUri() + "\"");
				galleria.append(" data-title=\"" + photo.getName() + "\"");
				//I didn't add description field to photo 
				galleria.append(" data-description=\"\"");
				galleria.append(" />");
				galleria.append("</a>");
				photoFlag.append("{\"photo\":\""+i+"\",\"id\":\""+photo.getPid()+"\",\"title\":\""+photo.getName()+"\"}");
				if(i!=size-1)photoFlag.append(",");
			}
			photoFlag.append("]");
			galleria.append("</div>");
			galleria.append("<div id=\"raysmond_photos\" style=\"display:none;\">"+photoFlag+"</div>");
			
			//Output the HTML to front-end page
			out.print(galleria.toString());
		}catch(IOException e){
			e.printStackTrace();
		}
	}
}
