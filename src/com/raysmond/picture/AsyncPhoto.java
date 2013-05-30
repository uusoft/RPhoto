package com.raysmond.picture;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.raysmond.bean.Photo;
import com.raysmond.bean.User;
import com.raysmond.db.dao.PhotoDao;
import com.raysmond.db.impl.PhotoDaoImpl;

public class AsyncPhoto extends HttpServlet {

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
		if(action.equals("change_photo_name")){
			if(!checkLogin(request,response)){
				out.print("User authentification failed.");out.flush();out.close();
				return;
			}
			asyncChangePhotoName(request,response);
			
		}else {
			out.print("no action.");
			out.flush();
			out.close();
			return;
		}
	}
	
	public void asyncChangePhotoName(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String newPhotoName = request.getParameter("_photo_name");
		String photoId = request.getParameter("_photo_id");
		if(newPhotoName==null||newPhotoName.equals("")||photoId==null||photoId.equals("")){
			out.print("Error. Change name failed.");
			out.flush();
			out.close();
			return;
		}
		int _pid = Integer.parseInt(photoId);
		PhotoDao dao = new PhotoDaoImpl();
		Photo photo = dao.getPhotoById(_pid);
		if(photo!=null){
			photo.setName(newPhotoName);
			if(dao.update(photo)){
				out.print("change name successfully.");
			}
			else out.print("Error,change name failed.");
		}
		else out.print("Error,change name failed.");
		out.flush();
		out.close();
	}
}
