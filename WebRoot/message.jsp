<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setCharacterEncoding("GBK");
String message = request.getParameter("message");
String error = request.getParameter("error");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
  </head>
  
  <body>
  <%
  	if(message!=null&&!message.equals("")){
  		message = new String(message.getBytes("ISO-8859-1"),"GBK");
  		%>
  		<div class="alert info"><%=message %></div>
  		<%
  	}
  	if(error!=null&&!error.equals("")){
  		error = new String(error.getBytes("ISO-8859-1"),"GBK");
  		%>
  		<div class="alert error"><%=error %></div>
  		<%
  	}
   %>
  </body>
</html>
