package com.raysmond.album;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.raysmond.bean.Album;
import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.impl.AlbumDaoImpl;

public class PublicAlbumsTag extends TagSupport{
	private static final long serialVersionUID = -851366690263024331L;
	private String page;
	private String pageSize;
	private String row;
	private String showPager;
	private String nameFilter;
	
	public String getNameFilter() {
		return nameFilter;
	}

	public void setNameFilter(String nameFilter) {
		this.nameFilter = nameFilter;
	}

	public String getShowPager() {
		return showPager;
	}

	public void setShowPager(String showPager) {
		this.showPager = showPager;
	}

	public String getRow() {
		return row;
	}

	public void setRow(String row) {
		this.row = row;
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

	public int doEndTag() {
		JspWriter out = pageContext.getOut();
		getPublicAlbums(out);
		return SKIP_BODY;
	}
	
	public void getPublicAlbums(JspWriter out){
		try {
			AlbumDao dao = new AlbumDaoImpl();
			int page = Integer.parseInt(getPage());
			int pageSize = Integer.parseInt(getPageSize());
			List<Album> albums = null;
			if(nameFilter==null||nameFilter.equals(""))
				albums = dao.getPublicAlbums(page-1,pageSize);
			else{
				System.out.println(nameFilter);
				System.out.println(new String(nameFilter.getBytes("ISO-8859-1"),"GBK"));
				nameFilter = new String(nameFilter.getBytes("ISO-8859-1"),"GBK");
				albums = dao.getPublicAlbums(page-1,pageSize,nameFilter);
			}
			out.print("<div class=\"row space-bot \">");
			int i=0,size = albums.size();
			for(;i<size&&i<pageSize;++i){
				Album album = albums.get(i);
				out.print("<div class=\""+row+"\" style=\"padding-left:5px;padding-right:5px;\"><p class=\"note\" style=\"padding:10px;\">"
				+"<img src=\""
				+album.getCoverUri()+"\" style=\"width:100%;height:160px;\" />" +
				"<br/><a href=\"pictures.jsp?album="+album.getAid()+"\">"+album.getName()+"</a><br />"+
				"<span>"+album.getCreateTime()+"</span>"+
				"<span>&nbsp;&nbsp;"+album.getCount()+" уе</span>"+
				"</p></div>");
			}
			out.print("</div>");
			if(showPager!=null&&!showPager.equals("NO")){
				int countTotal = dao.getCount();
				int pageCount = countTotal/pageSize;
				if(countTotal%pageSize>0) pageCount++;
				if(pageCount>0){
					out.print("<div class=\"row space-bot \">");
					out.print("<ul class=\"pagin text-center\">");
					for(i=0;i<pageCount;i++){
						if(i==page-1){
							out.print("<li><a class=\"active\" href=\""+showPager+"?page="+(i+1)+"\" style=\"padding:5px 10px;\">"+(i+1)+"</a></li>");
						}
						else{
							out.print("<li><a class=\"\" href=\""+showPager+"?page="+(i+1)+"\" style=\"padding:5px 10px;\">"+(i+1)+"</a></li>");
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
}
