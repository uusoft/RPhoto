package com.raysmond.album;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.raysmond.bean.Album;
import com.raysmond.bean.User;
import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.impl.AlbumDaoImpl;
import com.raysmond.util.DateUtil;

public class AysncAlbum extends HttpServlet {

	public boolean checkLogin(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("AUTH_USER");
		if(user==null) return false;
		return true;
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		asyncControll(request, response);
	}

	public void asyncControll(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=GBK");
		PrintWriter out = response.getWriter();
		String action = request.getParameter("action");
		if (action == null || action.equals("")) {
			out.print("no action.");
			out.flush();
			out.close();
			return;
		}
		if (action.equals("async_get_album_info")) {
			asyncGetAlbumInfo(request, response);
		}
		else if(action.equals("change_album_name")){
			if(!checkLogin(request,response)){
				out.print("User authentification failed.");out.flush();out.close();
				return;
			}
			asyncChangeAlbumName(request,response);
			
		}else {
			out.print("no action.");
			out.flush();
			out.close();
			return;
		}
	}
	public void asyncChangeAlbumName(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String albumId = request.getParameter("album_id");
		String albumName = request.getParameter("album_name");
		if (albumId == null || albumId.equals("")||albumName==null||albumName.equals("")) {
			out.print("error: incorrect request.");
			out.flush();
			out.close();
			return;
		}
		System.out.println("change album name: "+albumId+":"+albumName);
		AlbumDao dao = new AlbumDaoImpl();
		Album album = dao.getAlbumById(Integer.parseInt(albumId));
		if(album==null||album.getAid()<=0){
			out.print("error: no such album.");
			out.flush();
			out.close();
			return;
		}
		else{
			album.setName(albumName);
			if(dao.update(album)){
				out.print("success");
			}
			else out.print("failed");
		}
	}

	public void asyncGetAlbumInfo(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String albumId = request.getParameter("album_id");
		if (albumId == null || albumId.equals("")) {
			out.print("error: incorrect request.");
			out.flush();
			out.close();
			return;
		}
		AlbumDao dao = new AlbumDaoImpl();
		Album album = dao.getAlbumById(Integer.parseInt(albumId));
		if (album == null || !(album.getAid() > 0)) {
			out.print("没有找到专辑信息！");
			out.flush();
			out.close();
			return;
		}
		else{
			System.out.println(album.getName()+" by user: "+ album.getUser().getName());
			out.println("<a href=\"user.jsp?uid="+album.getUser().getUid()+"\">"+album.getUser().getName()+"</a><br />");
			out.println("专辑名：<a href=\"pictures.jsp?album="+album.getAid()+"\">"+album.getName()+"</a><br />");
			out.println("<span class=\"gray_small\">创建时间："+DateUtil.getTimestampString(album.getCreateTime())+"</span>");
		}
	}

}
