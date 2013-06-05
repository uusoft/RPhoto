package com.raysmond.tag;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.raysmond.bean.Photo;
import com.raysmond.db.dao.PhotoHasTagDao;
import com.raysmond.db.impl.PhotoHasTagDaoImpl;

/**
 * List photos with tag
 * 
 * @author Raysmond
 * 
 */
public class PhotosWithTag extends TagSupport {

	private static final long serialVersionUID = 222807714335763556L;

	private String tag;

	public int doEndTag() {
		getPhotosWithTag();
		return SKIP_BODY;
	}

	public void getPhotosWithTag() {
		JspWriter out = pageContext.getOut();
		try {
			// get photos with tag
			PhotoHasTagDao dao = new PhotoHasTagDaoImpl();
			List<Photo> photos = dao.getPhotosHasTag(getTag());

			int i=0,size = photos.size();

			// print photos
			StringBuffer buffer = new StringBuffer(1024);
			buffer.append("<h3 style=\"padding-left:0;padding-bottom:13px;\">标签："+getTag()+" &nbsp;&nbsp;&nbsp;图片数：" +size + "</h3>");
			for(;i<size;++i){
				Photo photo = photos.get(i);
				buffer.append("<div class=\"c3 \" style=\"padding-left:5px;padding-right:5px;margin-bottom:15px;\">" +
						"<div style=\"line-height:160%;padding:10px;font-size:14px;\" class=\"note\">" +
						"<img src=\""+photo.getUri()
						+"\" style=\"width:225px;height:210px;margin-bottom:10px;\" /><br/>"
						+ "<div style=\"word-break:break-all;max-width:225px;\">" 
						+ "<a href=\"detail.jsp?album="+photo.getAid()+"\" title=\"点击查看图片所属专辑\">" + photo.getName() +"</a>"
						+ "</div>"
						+"</div></div>");
				if((i+1)%4==0){
					buffer.append("<div style=\"clear:both;\"></div>");
				}
			}
			
			out.print(buffer.toString());

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

}
