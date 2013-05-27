package com.raysmond.comment;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.raysmond.bean.Comment;
import com.raysmond.db.dao.CommentDao;
import com.raysmond.db.impl.CommentDaoImpl;

public class TopCommentsTag extends TagSupport{
	private String page;
	private String pageSize;
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public String getPageSize() {
		return pageSize;
	}
	public void setPageSize(String pageSize) {
		this.pageSize = pageSize;
	}
	
	public int doEndTag(){
		JspWriter out = pageContext.getOut();
		getTopComments(out);
		return SKIP_BODY;
	}
	
	public void getTopComments(JspWriter out){
		int _page = Integer.parseInt(page);
		int _pageSize = Integer.parseInt(pageSize);
		if(_page<=0&&_pageSize<=0){
			return;
		}
		_page--;
		CommentDao dao = new CommentDaoImpl();
		List<Comment> comments = dao.getAllComments(_page, _pageSize);
		try{
			if(comments==null||comments.size()==0){
				out.print("暂时还没有评论哦！");
				return;
			}
			out.print("<ul id=\"top_comment_list\">");
			int i=0,size = comments.size();
			for(;i<size;++i){
				Comment comment = comments.get(i);
				out.print("<li class=\"list_item\">");
				out.print("<img src=\"images/picture.jpg\" />");
				out.print("<div class=\"comment\">");
				out.print("<a class=\"username\" href=\"#\">Raysmond</a>");
				out.print(" ："+comment.getContent()+"<br/><span class=\"comment_time\">"
						+comment.getCreateTime()+"</span>");
				out.print("");
				out.print("</div>");
				out.print("</li>");
			}
			out.print("</ul>");
		}catch(IOException e){
			e.printStackTrace();
			return;
		}
		
	}
	
}
