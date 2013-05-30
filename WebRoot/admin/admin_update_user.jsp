<%@ page language="java" import="java.util.*" 
import="com.raysmond.bean.User" 
import="com.raysmond.db.dao.UserDao" 
import="com.raysmond.db.impl.UserDaoImpl" 
pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String uid = request.getParameter("uid");
	if(uid==null||uid.equals("")){
		response.sendRedirect("./admin_user.jsp");
		return;
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>用户管理</title>
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
					<h2>修改用户</h2>
					<button onclick="window.location.href='./admin/admin_user.jsp'">返回用户列表</button>
					<% UserDao dao = new UserDaoImpl();
					   User user = dao.getUserById(Integer.parseInt(uid));
					   if(user==null){
					   	   out.println("<span>未获取到用户信息！</span>");
					   }
					   else{
					 %>
					 <form class="hform" action="AdminUser" method="post">
					 <input type="hidden" value="update_user" name="action" />
					 <input type="hidden" value="<%=uid %>" name="user_uid" />
					 <label>用户名</label>
					 <input type="text" name="username" value="<%=user.getName() %>" />
					 <label>邮箱</label>
					 <input type="text" name="mail" value="<%=user.getMail() %>" />
					 <label>密码</label>
					 <input type="password" name="password"  />
					 <label>密码确认</label>
					 <input type="password" name="password_confirm" />
					 <label>权限</label>
					 <select name="role">
					 <option <%=(user.getRid()==1?"selected":"") %> value="1">管理员</option>
					 <option <%=(user.getRid()==2?"selected":"") %> value="2">注册用户</option>
					 </select>
					 <label>状态</label>
					 <select name="status">
					 <option <%=(user.getStatus()==0?"selected":"") %> value="0">阻止</option>
					 <option <%=(user.getStatus()==1?"selected":"") %> value="1">有效</option>
					 </select>
					 <label>&nbsp;</label>
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
