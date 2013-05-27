package com.raysmond.upload;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.raysmond.bean.User;

public class UploadPhotosControll extends HttpServlet {

	private static final long serialVersionUID = 1806163755556568452L;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//controll(request,response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		controll(request,response);
	}
	
	public void controll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		//login required
		User user = (User) session.getAttribute("AUTH_USER");
		if(user==null) return;
		//action required
		String action = request.getParameter("action");
		if(action==null||action.equals("")){
			return;
		}
		if(action.equalsIgnoreCase("change_album_to_upload")){
			doChangeAlbumToUpload(request,response);
		}
	}
	
	public void doChangeAlbumToUpload(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("AUTH_USER");
		int userId = user.getUid();
		String albumId = request.getParameter("des_album_id");
		if(albumId==null||albumId.equals("")) return;
		try{
			Integer.parseInt(albumId);
		}catch(Exception e){
			e.printStackTrace();
			return;
		}
		//用户上传图片的专辑
		session.setAttribute("USER_"+userId+"_UPLOAD_PHOTOS_ALBUM", albumId);
		response.setContentType("html");
		PrintWriter out = response.getWriter();
		out.print("change upload album target successfully.");
	}
	
}
