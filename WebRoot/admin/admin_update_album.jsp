<%@ page language="java" import="java.util.*" 
import="com.raysmond.bean.Album" 
import="com.raysmond.db.dao.AlbumDao" 
import="com.raysmond.db.impl.AlbumDaoImpl" 
pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String albumId = request.getParameter("aid");
	if(albumId==null||albumId.equals("")){
		response.sendRedirect("./admin_album.jsp");
		return;
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>专辑修改</title>
	<link rel="stylesheet" type="text/css" href="./styles/IVORY-master/css/ivory.css">
	<link rel="stylesheet" type="text/css" href="./styles/style.css">
	<script type="text/javascript" src="./scripts/jquery-1.9.1.min.js"></script>

  </head>
  
  <body>
  <div id="header" class="header">
  	<div class="navigation" >
	  <ul class="top_nav" style="float:left;">
		<li><a class="yahei" href="./index.jsp">首页</a></li>
		<li><a class="yahei" href="./album.jsp">我的专辑</a></li>
		<li><a class="yahei" href="./admin/index.jsp">管理页</a></li>
		<li><a class="yahei" href="./admin/admin_user.jsp">用户管理</a></li>
		<li><a class="yahei" href="./admin/admin_album.jsp">专辑管理</a></li>
		<li><a class="yahei" href="./admin/statistics.jsp">统计</a></li>
	  </ul>		
	  </div>		
  </div>
  <div class="clear"></div>
  <div class="content">
		<div class="grid">
			<div class="g1024 space-bot">
				<div class="row space-bot">
						<jsp:include page="../message.jsp"></jsp:include>
				</div>
				<div class="row space-bot">
					<h2>修改用户</h2>
					<button onclick="window.location.href='./admin/admin_album.jsp'">返回专辑列表</button>
					<% AlbumDao dao = new AlbumDaoImpl();
					   Album album = dao.getAlbumById(Integer.parseInt(albumId));
					   if(album==null){
					   	   out.println("<div class=\"alert error\">未获取到专辑信息！</div>");
					   }
					   else{
					 %>
					 <form enctype="multipart/form-data" class="hform" action="AdminUpdateAlbum" method="post">
					 <input type="hidden" value="update_album" name="action" />
					 <input type="hidden" value="<%=albumId %>" name="album_aid" />
					 <label>专辑名</label>
					 <input type="text" name="album_name" value="<%=album.getName() %>" />
					 <label>权限</label>
					 <select name="status">
					 <option <%=(album.getIspublic()==1?"selected":"") %> value="1">公开</option>
					 <option <%=(album.getIspublic()==0?"selected":"") %> value="0">私有</option>
					 </select>
					 <label>修改封面：</label>
					 <input type="file" name="image" />
					 <button type="submit" >确认修改</button>
					 </form>
					 <%} %>
				</div>
				
				<div class="row space-bot">
						<div id="footer">
						By Jiankun Lei ( <a href="http://raysmond.com" target="_blank">Raysmond</a> ), Copyright 2013, All Right Reserved. 
						</div>
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
