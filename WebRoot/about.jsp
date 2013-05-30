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
				<li><a class="yahei" href="./index.jsp">��ҳ</a>
				</li>
				<li><a class="yahei" href="./album.jsp">�ҵ�ר��</a>
				</li>
				<li><a class="yahei" href="./public.jsp">��������</a>
				</li>
				<li><a class="yahei" href="./about.jsp">����RPhoto</a>
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
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����һ����ͼƬ����ͷ���ϵͳ����ϵͳ��ʹ�÷ǳ��򵥣������û��������վ�ڵ����й��������ͼƬ��
						ע���û������½����Լ�����ᣬ�ϴ���Ƭ��ר��ͼƬ����ͨ���õ�Ƭ����ʽչʾ���û����Զ�ͼƬ������ӱ�ǩ�����ۡ�
						<br/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����Ŀ�Ǹ�����ѧ2013��<a href="http://10.12.8.18/j2ee/" target=_blank>JavaEE�����γ�</a>PJ�����ڱ��ʱ�����ޣ�����ϵͳֻ����ɻ�����������ͷ����ܡ�����
						���ڷ�չ���У����������罻�ȹ��ܡ����ڱ��˸�ѧJavaEE������ˮƽ���ޣ���һ��������Ҳû��ϸ����վ�ļܹ�����ȫ�Ե����⡣���������Ŀֻ�Ǽ򵥵�����JavaEE����
						��д��û��ʹ��Struts,Spring��Hibernate��Щ���еļ�����
						<br/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��վʹ�õļ�����Ҫ�У�JSP��Servlet��JSP�Զ����ǩ��HTML/CSS��jQuery��Ajax�ȡ�
						<br/>
						��������<br/>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��վ��ʹ�õ�����ͼƬ�������磬�󲿷�������<a href="http://xiangce.baidu.com/" target=_blank>�ٶ����</a>��
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
