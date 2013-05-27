<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>404 未找到该页面 - RPhoto</title>
	<link rel="stylesheet" type="text/css" href="styles/IVORY-master/css/ivory.css">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<script type="text/javascript" src="scripts/jquery-1.9.1.min.js"></script>
  </head>
  <body>
    <div class="header">
  	<div class="navigation" >
	  <ul class="top_nav" style="float:left;">
		<li><a class="yahei" href="./index.jsp">首页</a></li>
	  </ul>		
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
						<div style="background:rgba(209, 205, 205, 0.53);padding:20px;width:450px;">
						 <h1>404: 未找到该页面哦！</h1>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
  </body>
</html>
