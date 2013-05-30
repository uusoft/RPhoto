package com.raysmond.admin;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.raysmond.bean.Album;
import com.raysmond.bean.User;
import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.impl.AlbumDaoImpl;

public class AdminUpdateAlbum extends HttpServlet {
	private static final long serialVersionUID = 7452844451882243525L;

	public boolean checkAdminLogin(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		User user = (User) session.getAttribute("AUTH_USER");
		if (user != null && user.getRid() == 1)
			return true;
		else
			return false;
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getContextPath();
		request.setCharacterEncoding("GBK");
		response.setCharacterEncoding("GBK");
		if (!checkAdminLogin(request)) {
			String error = new String("请先登录！".getBytes(), "ISO-8859-1");
			response.sendRedirect(path + "/login.jsp?error=" + error);
		} else {
			User user = (User) request.getSession().getAttribute("AUTH_USER");
			// String albumName = request.getParameter("album_name");
			// System.out.println(albumName);
			String uri = "";
			String name = "";
			String extName = "";
			String savePath = "";
			String type = "";
			int ispublic = 0;
			int albumId = 0;
			String newName = "";
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
					String savedName = "ac" + c.getTimeInMillis()
							+ (int) (Math.random() * 10000);
					File saveFile = new File(savePath + savedName + extName);
					uri = "images/public/u_" + user.getUid() + "/" + savedName
							+ extName;
					try {
						item.write(saveFile);
					} catch (Exception e) {
						e.printStackTrace();
					}
					// 只上传一个专辑封面
					// break;
				} else {
					// 如果是普通表单字段
					String fieldName = item.getFieldName();
					String fieldValue = item.getString();
					System.out.println(fieldName + ":" + fieldValue);
					if (fieldName.equals("album_public")) {
						if (fieldValue.equals("public"))
							ispublic = 1;
						else
							ispublic = 0;
					} else if (fieldName.equals("album_aid")) {
						albumId = Integer.parseInt(fieldValue);
					} else if(fieldName.equals("album_name")){
						newName = fieldValue;
					}
				}

			}

			Album album = null;
			AlbumDao dao = new AlbumDaoImpl();
			album = dao.getAlbumById(albumId);
			if (uri != null && !uri.equals(""))
				album.setCoverUri(uri);
			album.setName(newName);
			album.setIspublic(ispublic);
			java.util.Date date = new java.util.Date();
			Timestamp timeStamp = new Timestamp(date.getTime());
			album.setUpdateTime(timeStamp);
			if (dao.update(album)) {
				System.out.println("update album: " + albumId + " successfully.");
				response.sendRedirect(path + "/admin/admin_album.jsp?message="
						+ new String("更新相册成功！".getBytes(), "ISO-8859-1"));
			}
		}
	}
}
