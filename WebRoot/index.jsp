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
				<li><a class="yahei" href="./doc/report.pdf">�ĵ�����</a>
				</li>
				<li><a class="yahei" href="./admin/">��̨����</a>
				</li>
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
					<!-- slideshow -->
					<div class="c8 first">
						<div class="hdp_container">
							<a title="���� - ��ƪ�羰" href="pictures.jsp?album=51"><img src="images/1.jpg">
							</a> <a title="��Զ���Ʋ���" href="pictures.jsp?album=55"><img src="images/2.jpg">
							</a> <a title="�ƻ��ƽ��" href="pictures.jsp?album=53"><img src="images/3.jpg">
							</a> <a title="����羰ϵ��" href="pictures.jsp?album=52"><img src="images/4.jpg">
							</a> <a title="��ʧ�ڳ���ҹ���µ���ʹ" href="pictures.jsp?album=56"><img src="images/5.jpg">
							</a>
						</div>
						<h3 style="font-size:18px;font-weight:bold;">���ͼƬ</h3>
						<rasymond:publicAlbums showPager="NO" row="c4" pageSize="6"
							page="1" />
					</div>
					<div class="c4 last">
						<div id="top_comment_scroll">
							<h3 style="padding:10px 10px 0 10px;">���԰�</h3>
							<comment:topComments pageSize="10" page="1" />
						</div>
						<div style="clear:both;"></div>
						<div id="raysmond"
							style="padding:10px;background:#ffffff;float:left;width:100%;line-height:150%;">
							<img src="images/raysmond.jpg"
								style="width:78px;height:78px;float:left;margin-right:10px;" />
							Jiankun Lei ( Raysmond ) <br /> Website: <a
								href="http://raysmond.com" target="_blank">
								http://raysmond.com </a><br /> Contact: 10300240065@fudan.edu.cn <br />
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&
							jiankunlei@126.com
						</div>

						<div style="clear:both;height:20px;"></div>

						<div id="tag_cloud_wrapper">
							<h3>��ǩ��</h3>
							<div id="tag_cloud"></div>
						</div>
					</div>
				</div>
				<div class="row space-bot">
					<div class="c12"></div>
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
				    $("#tag_cloud").windstagball({
				            radius:120,
				            speed:5
				        });
				    toolbar('header');    
	            	$(".hdp_container").OM_HDP({delay:300,time:3000,title:1,type:1});     
	            	$("#top_comment_scroll").Scroll({line:1,speed:300,timer:2000});  
	            	ayncRPhoto("UserTagControll","action=get_tag_cloud&&count=20",showTagCloud); 
			    });
			 function showTagCloud(response){
			 	$("#tag_cloud").empty().html(response);
			 	$("#tag_cloud").windstagball({
				            radius:120,
				            speed:2
				        });
			 }
			   
            
</script>
</body>
</html>
