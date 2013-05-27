package com.raysmond.upload;import java.io.File;
import java.io.IOException;
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

import com.raysmond.bean.User;
 
@SuppressWarnings("serial")
public class Uploadify extends HttpServlet {
	
    @SuppressWarnings("unchecked")
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	//检查用户是否登录
    	HttpSession session = request.getSession(true);
    	User user = (User) session.getAttribute("AUTH_USER");
    	if(user==null){
    		String e = new String("请先登录再操作！".getBytes("GBK"),"ISO-8859-1");
    		response.sendRedirect("login.jsp?error="+e);
    		return;
    	}
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
        upload.setHeaderEncoding("GBK");
        List<FileItem> fileList = null;
        try {
            fileList = upload.parseRequest(request);
        } catch (FileUploadException ex) {
            return;
        }
        Iterator<FileItem> it = fileList.iterator();
        String name = "";
        String extName = "";
        while (it.hasNext()) {
            FileItem item = it.next();
            if (!item.isFormField()) {
                name = item.getName();
                long size = item.getSize();
                String type = item.getContentType();
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
                File saveFile = new File(savePath + name + extName);
                try {
                    item.write(saveFile);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        response.getWriter().print(name + extName);
    }
}