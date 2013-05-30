<%@ page language="java" import="java.util.*" import="com.raysmond.bean.User" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/public_albums.tld" prefix="rasymond"%>
<%@ taglib uri="/WEB-INF/user_info.tld" prefix="user"%>
<%@ taglib uri="/WEB-INF/top_comments.tld" prefix="comment"%>
<%
	request.setCharacterEncoding("GBK");
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String _page = request.getParameter("page");
	if(_page==null||_page.equals("")){
		_page = "1";
	}
	String search = request.getParameter("search");
	if(search==null){
		search = "";
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
	<title>RPhoto - I love photo!</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="styles/IVORY-master/css/ivory.css">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<script type="text/javascript" src="scripts/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="scripts/omHDP.js"></script>
	<script type="text/javascript" src="scripts/rphoto.js"></script>
	<script type="text/javascript" src="scripts/auto-scroll.js"></script>
	<script type="text/javascript" src="scripts/jquery.windstagball.js"></script>
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
		  <user:userInfo userId="" />
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
				<div class="row space-bot" style="margin-bottom:0;">
				<form class="hform yahei" action="public.jsp" method="get">
				<input type="text" value="<%=new String(search.getBytes("ISO-8859-1"),"GBK") %>" class="yahei" style="float:left;" name="search" placeholder="搜索专辑" />
				<button class="small yahei" style="margin-top:0;margin-left:10px;">搜索</button>
				</form>
				</div>
				<div class="row space-bot">
					<%  
					    String showPager = "NO"; 
					    if(search.equals("")) showPager="public.jsp"; 
				    %>
					<rasymond:publicAlbums nameFilter="<%=search %>" showPager="<%=showPager %>" row="c3" pageSize="12" page="<%=_page %>" />
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
            
             $(document).ready(function() {
				    toolbar('header');    
			    });
			   
            
</script>
</body>
</html>
