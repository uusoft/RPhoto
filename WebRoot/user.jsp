<%@ page language="java" import="java.util.*"
 import="com.raysmond.bean.User" 
 import="com.raysmond.util.DateUtil"
 pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/public_albums.tld" prefix="rasymond"%>
<%@ taglib uri="/WEB-INF/user_info.tld" prefix="user"%>
<%@ taglib uri="/WEB-INF/top_comments.tld" prefix="comment"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User) session.getAttribute("AUTH_USER");
	String userId = "null";
	if(user==null){
		response.sendRedirect("login.jsp?error=Please login first.");
		return;
	} 
	else userId = ""+user.getUid();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
	<title>RPhoto - I love photo!</title>
	<link rel="stylesheet" type="text/css" href="styles/IVORY-master/css/ivory.css">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<script type="text/javascript" src="scripts/jquery-1.9.1.min.js"></script>
</head>
<body>
 <div id="header" class="header">
  	<div class="navigation" >
	  <ul class="top_nav" style="float:left;">
		<li><a class="yahei" href="./index.jsp">��ҳ</a></li>
		<li><a class="yahei" href="./album.jsp">�ҵ�ר��</a></li>
		<li><a class="yahei" href="./public.jsp">��������</a></li>
		<li><a class="yahei" href="./about.jsp">����RPhoto</a></li>
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
				<div class="row space-bot">
					<div class="note" style="font-size:16px;line-height:200%;padding:20px 30px;min-height:350px;">
					    <h2>�ҵ���Ϣ</h2>
					    <img src="<%=user.getPicture() %>" style="width:200px;height:200px;float:left;margin-right:20px;" />
						�û�����<%=user.getName() %><br/>
						���䣺<%=user.getMail() %><br/>
						ע��ʱ�䣺<%=DateUtil.getTimestampString(user.getCreateTime()) %>  <br/>
						��¼ʱ�䣺<%=DateUtil.getTimestampString(user.getLastLoginTime()) %> <br/>
						<button onclick="window.location.href='update_user.jsp'">�����ҵ���Ϣ</button>
					</div>
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
