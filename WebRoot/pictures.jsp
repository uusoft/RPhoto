<%@ page language="java" import="java.util.*" 
import="com.raysmond.bean.User"
import="com.raysmond.bean.Album"
import="com.raysmond.db.dao.AlbumDao"
import="com.raysmond.db.impl.AlbumDaoImpl"
 pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/user_albums.tld" prefix="rasymond"%>
<%@ taglib uri="/WEB-INF/user_info.tld" prefix="user"%>
<%@ taglib uri="/WEB-INF/user_picture_in_album.tld" prefix="pictures"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User) session.getAttribute("AUTH_USER");
	boolean isCurrentUser = false;
	String albumId = request.getParameter("album");
	if(albumId==null||albumId.equals("")){
		albumId="";
		response.sendRedirect("login.jsp");
		return;
	}
	String userId = "";
	if(user!=null){
		userId = "" + user.getUid();
		int aid = Integer.parseInt(albumId);
		 AlbumDao dao = new AlbumDaoImpl();
		 Album album = dao.getAlbumById(aid);
		 if(album==null||album.getAid()<=0){
		 	//���ר�������ڣ�ת��404
		 	//����ʵ�֣�ʹ��Filter
		 	%>
		 	<jsp:forward page="404.jsp"/>
		 	<% 
			return;
		 }
		 if(album.getAid()>0&&album.getUser().getUid()==user.getUid()){
		 	//��ǰ�鿴�������ǵ�¼�û������
		 	isCurrentUser = true;
		 	System.out.println("is current user.");
		 }
	}
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'album.jsp' starting page</title>
	<link rel="stylesheet" type="text/css" href="styles/IVORY-master/css/ivory.css">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<script type="text/javascript" src="scripts/jquery-1.91.min.js"></script>
	<script type="text/javascript" src="scripts/jquery-ui-1.10.2.custom.js"></script>

  </head>
  
  <body>
 <div id="header" class="header">
  	<div class="navigation" >
	  <ul class="top_nav" style="float:left;">
		<li><a class="yahei" href="./index.jsp">��ҳ</a></li>
		<li><a class="yahei" href="./album.jsp">�ҵ�ר��</a></li>
	  </ul>
	  <div style="float:right;margin-right:20px;" id="top_user_info">
		  <user:userInfo userId="<%=userId %>" />
	  </div>
	  </div>		
  </div>
  <div class="clear"></div>
  <div class="content">
		<div class="grid">
			<div class="g1024 space-bot">
				<div class="row space-bot">
						<jsp:include page="message.jsp"></jsp:include>
				</div>
				<div class="row space-bot" style="margin-bottom:10px;">
					<button type="button"  
							onclick="window.location.href='detail.jsp?album=<%=albumId%>'"  
							class="orange small" 
							style="margin-bottom:0;">�鿴�õ�Ƭ</button>
					<%if(isCurrentUser){ %>
					<button type="button"  
							onclick="window.location.href='album/upload_photo.jsp?album=<%=albumId %>'"  
							class="orange small" 
							style="margin-bottom:0;">�ϴ�ͼƬ</button>
					<% } %>
				</div>
				<div class="row space-bot">
					<pictures:picturesInAlbum albumId="<%=albumId %>"/>
				</div>
			</div>
		</div>
	</div>
	<script>
			function toolbar(el){
                el = typeof el == 'string' ? document.getElementById(el) : el;
                var elTop = el.offsetTop;
                var sTop = 0;
                window.onscroll = function(){
                    sTop = document.body.scrollTop || document.documentElement.scrollTop;
                    if( sTop > elTop ){
                        el.style.position="fixed";
                        el.style.top = 0 + 'px';
                    }else{
                        el.style.position="absolute";
                        el.style.top = elTop + 'px';
                    }
                };
            }
            toolbar('header');            
	</script>
  </body>
</html>
