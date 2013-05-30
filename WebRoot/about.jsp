<%@ page language="java" import="java.util.*"
	import="com.raysmond.bean.User" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/public_albums.tld" prefix="rasymond"%>
<%@ taglib uri="/WEB-INF/user_info.tld" prefix="user"%>
<%@ taglib uri="/WEB-INF/top_comments.tld" prefix="comment"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User) session.getAttribute("AUTH_USER");
	String userId = "null";
	if(user!=null) userId = Integer.toString(user.getUid());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>RPhoto - I love photo!</title>
<link rel="stylesheet" type="text/css"
	href="styles/IVORY-master/css/ivory.css">
<link rel="stylesheet" type="text/css" href="styles/style.css">
<script type="text/javascript" src="scripts/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="scripts/omHDP.js"></script>
<script type="text/javascript" src="scripts/rphoto.js"></script>
<script type="text/javascript" src="scripts/auto-scroll.js"></script>
<script type="text/javascript" src="scripts/jquery.windstagball.js"></script>
</head>
<body>
	<div id="header" class="header">
		<div class="navigation">
			<ul class="top_nav" style="float:left;">
				<li><a class="yahei" href="./index.jsp">首页</a>
				</li>
				<li><a class="yahei" href="./album.jsp">我的专辑</a>
				</li>
				<li><a class="yahei" href="./public.jsp">公开分享</a>
				</li>
				<li><a class="yahei" href="./about.jsp">关于RPhoto</a>
				</li>
			</ul>
			<div style="float:right;margin-right:20px;" id="top_user_info">
				<user:userInfo userId="<%=userId %>" />
			</div>
		</div>
	</div>
	<div class="clear"></div>
	<div class="content" style="min-height:92%;">
		<div class="grid">
			<div class="g1024 space-bot">
				<div class="row space-bot">
					<jsp:include page="message.jsp"></jsp:include>
				</div>
				<div class="row space-bot">
					<div class="note" style="padding:10px 20px 20px 20px;">
						<h3 style="color:#ff0084;border-bottom:1px #ccc dashed;">About RPhoto</h3>
						<p style="line-height:180%;padding:15px 20px;" class="">
						Project: RPhoto - I Love Photo! <br/>
						Programmer: Jiankun Lei ( Raysmond )<br/>
						Student ID: 10300240065 <br/>
						Contact: 10300240065@fudan.edu.cn <br/>
						Website: <a href="http://raysmond.com" target="_blank">http://raysmond.com</a>
						<br/><br/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;这是一个简单图片管理和分享系统。本系统的使用非常简单，匿名用户可以浏览站内的所有公开分享的图片；
						注册用户可以新建的自己的相册，上传照片。专辑图片还以通过幻灯片的形式展示，用户可以对图片进行添加标签和评论。
						<br/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;这个项目是复旦大学2013年<a href="http://10.12.8.18/j2ee/" target=_blank>JavaEE技术课程</a>PJ。由于编程时间有限，于是系统只是完成基本的相册管理和分享功能。如有
						后期发展需有，可以增加社交等功能。由于本人刚学JavaEE技术，水平有限，在一个星期内也没有细想网站的架构和完全性等问题。所以这个项目只是简单的利用JavaEE技术
						编写，没有使用Struts,Spring和Hibernate这些流行的技术。
						<br/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本站使用的技术主要有：JSP、Servlet、JSP自定义标签、HTML/CSS、jQuery、Ajax等。
						<br/>
						免责声明<br/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本站中使用的所有图片来自网络，大部分来自于<a href="http://xiangce.baidu.com/" target=_blank>百度相册</a>。
						</p>
					</div>	
				</div>
				<div class="row space-bot">
					<div id="footer">
						By Jiankun Lei ( <a href="http://raysmond.com" target="_blank">Raysmond</a>
						), Copyright 2013, All Right Reserved.
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
