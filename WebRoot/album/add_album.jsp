<%@ page language="java" import="java.util.*" import="com.raysmond.bean.User" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/user_info.tld" prefix="user"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String userId = request.getParameter("uid");
	if(userId==null||userId.equals("")){
		User user = (User)session.getAttribute("AUTH_USER");
		if(user==null){
			response.sendRedirect("../login.jsp");
			return;
		}
		userId = Integer.toString(user.getUid());
		
	}
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'album.jsp' starting page</title>
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
						<jsp:include page="../message.jsp"></jsp:include>
				</div>
				<!-- Add album -->
				<div class="row space-bot">
						<form class="hform" enctype="multipart/form-data" action="./servlet/manageAlbum" method="post">
							<label>专辑名称：</label>
							<input type="text" name="album_name" />
							<label>访问权限：</label>
							<select name="album_public">
							<option value="public">公开</option>
							<option value="private">私有</option>
							</select>
							<label>上传封面：</label>
							<input type="file" name="image" />
							<input type="submit" value="确定" />
						</form>
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
