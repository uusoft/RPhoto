<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/user_info.tld" prefix="user"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>登录 - RPhoto</title>
	<link rel="stylesheet" type="text/css" href="styles/IVORY-master/css/ivory.css">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<script type="text/javascript" src="scripts/jquery-1.9.1.min.js"></script>
		<script>
	$(document).ready(function() {
		$("#login_form").slideToggle(1000);
	});
	</script>
  </head>
  <body>
    <div class="header">
  	<div class="navigation" >
	  <ul class="top_nav" style="float:left;">
		<li><a class="yahei" href="./index.jsp">首页</a></li>
		<li><a class="yahei" href="./public.jsp">公开分享</a></li>
	  </ul>		
	  <div style="float:right;margin-right:20px;" id="top_user_info">
		  <user:userInfo userId="null" />
	  </div>	
	</div>		
  </div>
  <div style="clear:both;"></div>
  <div class="content" style="background:url(images/bg2.jpg) center;height:100%;margin-top:0;">
		<div class="grid">
			<div class="g1024 space-bot">
				<div class="row space-bot" style="height:50px;"></div>
				<div class="row space-bot">
					<jsp:include page="message.jsp"></jsp:include>
				</div>
				<div class="row space-top space-bot">
					<h3 class="ui_title">RPhoto - I Love Photo!</h3>
				</div>
				<div class="row space-bot">
					<div class="c12">
						<div style="background:rgba(209, 205, 205, 0.53);padding:20px;width:300px;">
						<form id="login_form" class="hform" action="userAuth" method="post" style="margin-bottom:0;display:none;">
						    <input type="hidden" name="action" value="login" /> <br />
						    <input type="text" name="username" style="width:100%;height:40px;background:rgba(255, 255, 255, 0.89);" placeholder="用户名" class="yahei"/>
						    <input type="password" name="password" style="width:100%;height:40px;background:rgba(255, 255, 255, 0.89);" placeholder="密码" class="yahei"/>
						    <button type="submit" style="width:40%;font-size:14px;height:40px;" class="large yahei skyblue">登&nbsp;录</button>
					    </form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
  </body>
</html>
