package com.raysmond.album;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
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
import javax.servlet.jsp.JspWriter;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.raysmond.bean.Album;
import com.raysmond.bean.User;
import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.impl.AlbumDaoImpl;
import com.raysmond.upload.Upload;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageDecoder;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class ManageAlbum extends HttpServlet {

	private static final long serialVersionUID = 7054153398014554671L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAddAlbum(request,response);
	}
	
	public void doAddAlbum(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//检查用户是否登录
    	HttpSession session = request.getSession(true);
    	User user = (User) session.getAttribute("AUTH_USER");
    	if(user==null){
    		String e = new String("请先登录再操作！".getBytes("GBK"),"ISO-8859-1");
    		response.sendRedirect("login.jsp?error="+e);
    		return;
    	}
    	  request.setCharacterEncoding("GBK");
		  String albumName = request.getParameter("album_name");
		  System.out.println(albumName);
		  String uri = "";
		  String name =  "";
		  String extName = "";
		  String savePath = "";
		  String type = "";
		  int ispublic = 0;
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
	        //设置文件上传路径
	        savePath = savePath + "/images/public/u_"+user.getUid()+"/";
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
	                //扩展名格式： 
	                if (name.lastIndexOf(".") >= 0) {
	                    extName = name.substring(name.lastIndexOf("."));
	                }
	                File file = null;
	                do {
	                    //生成文件名：
	                    name = UUID.randomUUID().toString();
	                    file = new File(savePath + name + extName);
	                } while (file.exists());
	                Calendar c = Calendar.getInstance();
	                String savedName = "ac"+c.getTimeInMillis()+(int)(Math.random()*10000);
	                File saveFile = new File(savePath + savedName + extName);
	                uri = "images/public/u_"+user.getUid()+"/" + savedName + extName;
	                try {
	                    item.write(saveFile);
	                } catch (Exception e) {
	                    e.printStackTrace();
	                }
	               //只上传一个专辑封面
		          // break;
	            }
	            else{
	            	//如果是普通表单字段  
	                String fieldName = item.getFieldName();  
	                String fieldValue = item.getString(); 
	                System.out.println(fieldName+":"+fieldValue);
	                if(fieldName.equals("album_name")) albumName = new String(fieldValue.getBytes("ISO-8859-1"),"GBK");
	                else if(fieldName.equals("album_public")){
	                	if(fieldValue.equals("public")) ispublic = 1;
	                	else ispublic = 0;
	                }
	            }
	            
	        }
	        
	     Album album = new Album();
	     AlbumDao dao = new AlbumDaoImpl();
	     album.setUid(user.getUid());
	     if(albumName==null) albumName = name;
	     album.setName(albumName);
	     album.setCoverUri(uri);
	     album.setCount(0);
	     album.setIspublic(ispublic);
	     java.util.Date date = new java.util.Date();
	     Timestamp timeStamp = new Timestamp(date.getTime());
	     album.setCreateTime(timeStamp);
	     album.setUpdateTime(timeStamp);
	     int insertId = dao.insert(album);
	     String path = request.getContextPath();
	     if(insertId>0){
	    	 String msg = new String(("&&message=专辑\""+album.getName()+"\"创建成功。快上传图片吧！").getBytes("GBK"),"ISO-8859-1");
	    	 response.sendRedirect(path+"/pictures.jsp?album="+insertId+msg);
	     }
	     else{
	    	 String msg = new String(("error=对不起，专辑\""+album.getName()+"\"创建失败！").getBytes("GBK"),"ISO-8859-1");
	    	 response.sendRedirect(path+"/album/add_album.jsp?"+msg);
	     }
	     
	}

	public void doDeleteAlbum(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}
	
	public void doUpdateAlbum(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}
