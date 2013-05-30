package com.raysmond.admin;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.raysmond.bean.Album;
import com.raysmond.bean.Photo;
import com.raysmond.bean.User;
import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.dao.PhotoDao;
import com.raysmond.db.impl.AlbumDaoImpl;
import com.raysmond.db.impl.PhotoDaoImpl;

public class AdminAlbum extends HttpServlet {
	private static final long serialVersionUID = 8048934768277497910L;

	public boolean checkAdminLogin(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("AUTH_USER");
		if (user != null && user.getRid() == 1)
			return true;
		else
			return false;
	}
	public boolean checkUserLogin(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("AUTH_USER");
		if (user != null)
			return true;
		else
			return false;
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		controll(request,response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		controll(request,response);
	}
	
	public void controll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("GBK");
		response.setContentType("text/html;charset=GBK");
		String path = request.getContextPath();
		String action = request.getParameter("action");
		if(action==null||action.equals("")){
			response.sendRedirect(path+"/admin/admin_album.jsp");
			return;
		}
		else if(action.equals("delete_album")){
			doDeleteAlbum(request,response);
		}
	}
	
	public void doDeleteAlbum(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getContextPath();
		if(!checkUserLogin(request)){
			response.sendRedirect(path+"/login.jsp?error=Please login first!");
			return;
		}
		String albumId = request.getParameter("aid");
		if(albumId==null||albumId.equals("")){
			response.sendRedirect(path+"/admin/admin_album.jsp");
			return;
		}
		AlbumDao albumDao = new AlbumDaoImpl();
		PhotoDao photoDao = new PhotoDaoImpl();
		Album album = albumDao.getAlbumById(Integer.parseInt(albumId));
		String savePath = this.getServletConfig().getServletContext()
                .getRealPath("");
		if(album!=null&&album.getAid()>0){
			//if the album to delete exists in database, then performs the delete action
			List<Photo> photos = photoDao.getPhotoInAlbum(album.getAid());
			Iterator<Photo> it = photos.iterator();
			while(it.hasNext()){
				Photo p = it.next();
				String filePath = savePath + "/" + p.getUri();
				File file = new File(filePath);
				if(file.exists()){
					file.delete();
				}
			}
			photoDao.deletePhotosInAlbum(album.getAid());
			albumDao.delete(album);
			String filePath = savePath + "/" + album.getCoverUri();
			File file = new File(filePath);
			if(file.exists()){
				file.delete();
			}
		}
		response.sendRedirect(request.getHeader("Referer"));
	}
}
