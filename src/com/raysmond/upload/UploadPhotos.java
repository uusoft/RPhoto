package com.raysmond.upload;import java.io.File;
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
import com.raysmond.bean.Photo;
import com.raysmond.bean.User;
import com.raysmond.db.dao.AlbumDao;
import com.raysmond.db.dao.PhotoDao;
import com.raysmond.db.impl.AlbumDaoImpl;
import com.raysmond.db.impl.PhotoDaoImpl;
 
@SuppressWarnings("serial")
public class UploadPhotos extends HttpServlet {
	PhotoDao dao = new PhotoDaoImpl();
    @SuppressWarnings("unchecked")
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.setCharacterEncoding("GBK");
    	//检查用户是否登录
    	HttpSession session = request.getSession(true);
    	User user = (User) session.getAttribute("AUTH_USER");
    	String albumToUpload = (String) session.getAttribute("USER_"+user.getUid()+"_UPLOAD_PHOTOS_ALBUM");
    		
    	if(user==null||albumToUpload==null||albumToUpload.equals("")){
    		String e = new String("请先登录再操作！".getBytes("GBK"),"ISO-8859-1");
    		response.sendRedirect("login.jsp?error="+e);
    		return;
    	}
    	if(albumToUpload.equals("default")) albumToUpload = ""+getUserDefaultAlbum(user.getUid());
    	int albumId = Integer.parseInt(albumToUpload);
    	int userId = user.getUid();
        String savePath = this.getServletConfig().getServletContext()
                .getRealPath("");
        //设置文件上传路径
        savePath = savePath + "/images/public/u_"+userId+"/";
        File f1 = new File(savePath);
        if (!f1.exists()) {
            f1.mkdirs();
        }
        DiskFileItemFactory fac = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(fac);
        upload.setHeaderEncoding("utf-8");
        List<FileItem> fileList = null;
        try {
            fileList = upload.parseRequest(request);
        } catch (FileUploadException ex) {
            return;
        }
        Iterator<FileItem> it = fileList.iterator();
        String title = "";
        String name = "";
        String extName = "";
        while (it.hasNext()) {
            FileItem item = it.next();
            if (!item.isFormField()) {
            	title = name = item.getName();
                //System.out.println(name+"_________name:"+new String(name.getBytes("GBK"),"GBK"));
                long size = item.getSize();
                String type = item.getContentType();
                if (name == null || name.trim().equals("")) {
                    continue;
                }
                //扩展名格式： 
                if (name.lastIndexOf(".") >= 0) {
                	title = name.substring(0,name.lastIndexOf("."));
                    extName = name.substring(name.lastIndexOf("."));
                }
                File file = null;
                do {
                    //生成文件名：
                    name = UUID.randomUUID().toString();
                    file = new File(savePath + name + extName);
                } while (file.exists());
                File saveFile = new File(savePath + name + extName);
                try {
                    item.write(saveFile);
                    addPhoto(title,type,"images/public/u_"+userId+"/"
                    		+ name+extName,size,albumId);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            else{
            	//如果是普通表单字段  
                String fieldName = item.getFieldName();  
                String fieldValue = item.getString(); 
                System.out.println(fieldName+":"+fieldValue);
            }
        }
        response.getWriter().print(name + extName);
    }
    
    public int getUserDefaultAlbum(int userId){
    	AlbumDao albumDao = new AlbumDaoImpl();
    	Album album = albumDao.getUserDefaultAlbum(userId);
    	if(album.getAid()>0){
    		return album.getAid();
    	}
    	else{
    		albumDao.createUserDefaultAlbum(userId);
    		album = albumDao.getUserDefaultAlbum(userId);
    		return album.getAid();
    	}
    }
    
    public void addPhoto(String name,String type,String uri,long size,int albumId){
    	Photo photo = new Photo();
    	photo.setAid(albumId);
    	photo.setName(name);
    	photo.setSize((int)size);
    	photo.setType(type);
    	photo.setUri(uri);
    	photo.setViews(0);
    	java.util.Date date = new java.util.Date();
	    Timestamp timeStamp = new Timestamp(date.getTime());
    	photo.setCreateTime(timeStamp);
    	dao.insert(photo);
    }
    
}