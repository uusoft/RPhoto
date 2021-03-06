<%@ page language="java" import="java.util.*" import="com.raysmond.bean.User" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/admin_album.tld" prefix="album"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String _page = request.getParameter("page");
	if(_page==null||_page.equals("")){
		_page = "1";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>专辑管理</title>
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
		<li><a class="yahei" href="./public.jsp">公开分享</a></li>
		<li><a class="yahei" href="./about.jsp">关于RPhoto</a></li>
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
					<h2>专辑管理</h2>
					<album:adminAlbum pageSize="10" page="<%=_page %>"/>
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
