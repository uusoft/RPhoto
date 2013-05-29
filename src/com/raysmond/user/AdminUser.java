package com.raysmond.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.raysmond.bean.Album;
import com.raysmond.bean.Photo;
import com.raysmond.bean.User;
import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.dao.PhotoDao;
import com.raysmond.db.dao.UserDao;
import com.raysmond.db.impl.AlbumDaoImpl;
import com.raysmond.db.impl.PhotoDaoImpl;
import com.raysmond.db.impl.UserDaoImpl;

public class AdminUser extends HttpServlet {

	private static final long serialVersionUID = 1620256536782470015L;

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
		response.setContentType("text/html;charset=GBK");
		request.setCharacterEncoding("GBK");
		String action = request.getParameter("action");
		if(action==null||action.equals("")){
			return;
		}
		else if(action.equalsIgnoreCase("update_user")){
			updateUser(request,response);
		}
		else if(action.equalsIgnoreCase("delete_user")){
			deleteUser(request,response);
		}
	}
	
	public void updateUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}
	
	public void deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userId = request.getParameter("uid");
		if(userId==null||userId.equals("")){
			return;
		}
		int uid = Integer.parseInt(userId);
		AlbumDao albumDao = new AlbumDaoImpl();
		PhotoDao photoDao = new PhotoDaoImpl();
		List<Album> albums = albumDao.getUserAlbums(uid);
		Iterator<Album> it = albums.iterator();
		while(it.hasNext()){
			Album album = it.next();
			photoDao.deletePhotosInAlbum(album.getAid());
			albumDao.delete(album);
		}
		UserDao dao = new UserDaoImpl();
		User user = new User();
		user.setUid(uid);
		dao.delete(user);
		response.sendRedirect(request.getContextPath()+"/admin/admin_user.jsp");
	}
}
