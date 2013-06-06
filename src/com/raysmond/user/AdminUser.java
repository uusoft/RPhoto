package com.raysmond.user;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

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
		response.setContentType("text/html;charset=GBK");
		String path = request.getContextPath();
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		boolean _false = false;
		if (_false) {
			String error = new String("请先登录！".getBytes(), "ISO-8859-1");
			response.sendRedirect(path + "/login.jsp?error=" + error);
		} else {
			System.out.println("update user....");
			User user = (User) request.getSession().getAttribute("AUTH_USER");
			String uri = "";
			String name = "";
			String extName = "";
			String savePath = "";
			String type = "";
			String newPassword = "", newPasswordConfirm = "";
			long size = 0L;
			DiskFileItemFactory fac = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(fac);
			upload.setHeaderEncoding("GBK");
			List<FileItem> fileList = null;
			try {
				fileList = upload.parseRequest(request);
			} catch (FileUploadException ex) {
				return;
			}
			savePath = this.getServletConfig().getServletContext()
					.getRealPath("");
			// 设置文件上传路径
			savePath = savePath + "/images/public/u_" + user.getUid() + "/";
			System.out.println(savePath);
			File f1 = new File(savePath);
			if (!f1.exists()) {
				f1.mkdirs();
			}
			Iterator<FileItem> it = fileList.iterator();
			while (it.hasNext()) {
				FileItem item = it.next();
				if (!item.isFormField()) {
					name = item.getName();
					size = item.getSize();
					type = item.getContentType();
					System.out.println(size + " " + type);
					if (name == null || name.trim().equals("")) {
						continue;
					}
					// 扩展名格式：
					if (name.lastIndexOf(".") >= 0) {
						extName = name.substring(name.lastIndexOf("."));
					}
					File file = null;
					do {
						// 生成文件名：
						name = UUID.randomUUID().toString();
						file = new File(savePath + name + extName);
					} while (file.exists());
					Calendar c = Calendar.getInstance();
					String savedName = "picture" + c.getTimeInMillis()
							+ (int) (Math.random() * 10000);
					File saveFile = new File(savePath + savedName + extName);
					uri = "images/public/u_" + user.getUid() + "/" + savedName
							+ extName;
					try {
						item.write(saveFile);
					} catch (Exception e) {
						e.printStackTrace();
					}
				} else {
					// 如果是普通表单字段
					String fieldName = item.getFieldName();
					String fieldValue = item.getString();
					System.out.println(fieldName + ":" + fieldValue);
					if (fieldName.equals("password")) {
						newPassword = fieldValue;
					} else if (fieldName.equals("password_confirm")) {
						newPasswordConfirm = fieldValue;
					}

				}
			}
			if (!newPassword.equals("")
					&& newPassword.equals(newPasswordConfirm)) {
				user.setPassword(newPassword);
			}
			String oldPictureUri = "";
			if (!uri.equals("")) {
				oldPictureUri = user.getPicture();
				user.setPicture(uri);
			}
			request.getSession().setAttribute("AUTH_USER", user);
			UserDao dao = new UserDaoImpl();
			if (dao.update(user)) {
				File file = new File(savePath + "/" + oldPictureUri);
				if (file.exists()) {
					file.delete();
				}
				response.sendRedirect(request.getContextPath()
						+ "/admin/admin_user.jsp?uid=" + user.getUid()
						+ "&&message=Update user info successfully.");
				return;
			}
			response.sendRedirect(request.getContextPath() + "/admin/admin_user.jsp?uid="+
			"&&error=Update user info failed.");
			return;
		}
		
		response.sendRedirect(request.getContextPath() + "/admin/admin_user.jsp");
	}
	
	public void deleteUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userId = request.getParameter("uid");
		if(userId==null||userId.equals("")){
			return;
		}
		int uid = Integer.parseInt(userId);
		String savePath = this.getServletConfig().getServletContext()
                .getRealPath("");
		AlbumDao albumDao = new AlbumDaoImpl();
		PhotoDao photoDao = new PhotoDaoImpl();
		List<Album> albums = albumDao.getUserAlbums(uid);
		Iterator<Album> it = albums.iterator();
		while(it.hasNext()){
			Album album = it.next();
			List<Photo> photos = photoDao.getPhotoInAlbum(album.getAid());
			Iterator<Photo> it1 = photos.iterator();
			while(it1.hasNext()){
				Photo p = it1.next();
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
		UserDao dao = new UserDaoImpl();
		User user = new User();
		user.setUid(uid);
		dao.delete(user);
		String filePath = savePath + "/" + user.getPicture();
		File file = new File(filePath);
		if(file.exists()){
			file.delete();
		}
		response.sendRedirect(request.getContextPath()+"/admin/admin_user.jsp");
	}
}
