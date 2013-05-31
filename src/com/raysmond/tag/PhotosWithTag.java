package com.raysmond.tag;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * List photos with tag
 * @author Raysmond
 *
 */
public class PhotosWithTag extends TagSupport {

	private static final long serialVersionUID = 222807714335763556L;
	
	private String tag;

	public int doEndTag(){
		getPhotosWithTag();
		return SKIP_BODY;
	}
	
	public void getPhotosWithTag(){
		JspWriter out = pageContext.getOut();
		try {
			out.print(tag);
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
