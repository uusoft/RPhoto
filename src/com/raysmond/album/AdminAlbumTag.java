package com.raysmond.album;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.raysmond.bean.Album;
import com.raysmond.bean.User;
import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.dao.UserDao;
import com.raysmond.db.impl.AlbumDaoImpl;
import com.raysmond.db.impl.UserDaoImpl;

public class AdminAlbumTag extends TagSupport {
	private static final long serialVersionUID = 2872986263247145725L;

	private String page;
	private String pageSize;

	private int _page;
	private int _pageSize;

	public boolean validateParam() {
		_page = _pageSize = 0;
		try {
			_page = Integer.parseInt(page);
			_pageSize = Integer.parseInt(pageSize);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public int doEndTag() {
		JspWriter out = pageContext.getOut();
		if (!validateParam()) {
			try {
				out.print("<span style=\"\">请求的参数有误，未能获取列表！</span>");
			} catch (IOException e) {
				e.printStackTrace();
			}
			return SKIP_BODY;
		}
		getUsers(out);
		return SKIP_BODY;
	}

	public void getUsers(JspWriter out) {
		AlbumDao dao = new AlbumDaoImpl();
		// 从数据库中获取专辑别表
		List<Album> albums = dao.getAllAlbums(_page-1, _pageSize);
		System.out.println("get albums: page=" + _page + " | pageSize="
				+ _pageSize + " | result size:" + albums.size());
		try {
			if (albums == null || albums.size() == 0) {
				out.print("出错了！");

			} else {
				out.print("<div class=\"row space-bot \">");
				out.print("<table class=\"album_table\">");
				int i = 0, size = albums.size();
				out.print("<tbody>");
				out.print("<tr>" + "<th class=\"text-center\">封面</td>" + "<th class=\"text-center\">专辑名</th>"
						+ "<th>用户</th>" + "<th>创建时间</th>" + "<th>图片数</th>"
						+ "<th  class=\"text-center\">修改 | 删除</th>" + "</tr>");
				for (; i < size; ++i) {
					Album album = albums.get(i);
					out.print("<tr "
							+ (i % 2 == 0 ? "class=\"even\"" : "")
							+ ">"
							+ "<td class=\"text-center\">"
							+ "<img style=\"width:48px;height:48px;\" src=\""+album.getCoverUri()+"\" />"
							+ "</td>"
							+ "<td class=\"text-center\">"
							+ "<a target=_blank href=\"pictures.jsp?album="+album.getAid()+"\">"+album.getName() + "</a>"
							+ "</td>"
							+ "<td class=\"text-center\">"
							+ album.getUser().getName()
							+ "</td>"
							+ "<td class=\"text-center\">"
							+ album.getCreateTime()
							+ "</td>"
							+ "<td class=\"text-center\">"
							+ album.getCount()
							+ "</td>"
							+ "<td  class=\"text-center\"><a href=\"admin/admin_update_album.jsp?action=update_album&&aid="
							+ album.getAid() + "\">修改</a> | "
							+ "<a href=\"AdminAlbum?action=delete_album&&aid="
							+ album.getAid() + "\">删除</a></td>" + "</tr>");
				}
				out.print("<tbody></table></div>");
				
				int countTotal = dao.getCount();
				int pageCount = countTotal/_pageSize;
				if(countTotal%_pageSize>0) pageCount++;
				if(pageCount>0){
					out.print("<div class=\"row space-bot \">");
					out.print("<ul class=\"pagin text-center\">");
					for(i=0;i<pageCount;i++){
						if(i==_page-1){
							out.print("<li><a class=\"active\" href=\"admin/admin_album.jsp?page="+(i+1)+"\" style=\"padding:5px 10px;\">"+(i+1)+"</a></li>");
						}
						else{
							out.print("<li><a class=\"\" href=\"admin/admin_album.jsp?page="+(i+1)+"\" style=\"padding:5px 10px;\">"+(i+1)+"</a></li>");
						}
					}
					out.print("</ul>");
					out.print("</div>");
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

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

}
