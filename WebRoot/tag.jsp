<%@ page language="java" import="java.util.*" 
import="com.raysmond.bean.User"
import="com.raysmond.bean.Album"
import="com.raysmond.db.dao.AlbumDao"
import="com.raysmond.db.impl.AlbumDaoImpl"
 pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/user_info.tld" prefix="user"%>
<%@ taglib uri="/WEB-INF/photos_with_tag.tld" prefix="photos"%>
<%
	request.setCharacterEncoding("GBK");
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User) session.getAttribute("AUTH_USER");
	String tag = request.getParameter("tag");
	if(tag==null||tag.equals("")){
		response.sendRedirect("public.jsp");
		return;
	}
	String userId = "null";
	if(user!=null) userId = Integer.toString(user.getUid());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>标签</title>
	<link rel="stylesheet" type="text/css" href="styles/IVORY-master/css/ivory.css">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<script type="text/javascript" src="scripts/jquery-1.9.1.min.js"></script>
  </head>
  <body>
 <div id="header" class="header">
  	<div class="navigation" >
	  <ul class="top_nav" style="float:left;">
		<li><a class="yahei" href="./index.jsp">首页</a></li>
		<li><a class="yahei" href="./album.jsp">我的专辑</a></li>
		<li><a class="yahei" href="./public.jsp">公开分享</a></li>
		<li><a class="yahei" href="./about.jsp">关于RPhoto</a></li>
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
						<jsp:include page="./message.jsp"></jsp:include>
				</div>
				<div class="row space-bot">
					<% tag = new String(tag.getBytes("ISO-8859-1"),"GBK"); %>
					<photos:photosWithTag tag="<%=tag %>" />
				</div>
			</div>
		</div>
	</div>
  </body>
</html>
