<%@ page language="java" import="java.util.*" import="com.raysmond.bean.User" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/user_info.tld" prefix="user"%>
<%@ taglib uri="/WEB-INF/user_album_select_list.tld" prefix="album"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User)session.getAttribute("AUTH_USER");
	if(user==null){
			response.sendRedirect("../login.jsp");
			return;
		}	
	String userId = ""+user.getUid();
	String albumId = request.getParameter("album");
	if(albumId==null||albumId.equals("")){
		albumId = "default";
	}
	//�û��ϴ�ͼƬ��ר��
	session.setAttribute("USER_"+userId+"_UPLOAD_PHOTOS_ALBUM", albumId);
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'album.jsp' starting page</title>
	<link rel="stylesheet" type="text/css" href="./styles/IVORY-master/css/ivory.css">
	<link rel="stylesheet" type="text/css" href="./styles/style.css">
	<link href="./uploadify-v2.1.4/uploadify.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="./scripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="./uploadify-v2.1.4/swfobject.js"></script>
	<script type="text/javascript" src="./uploadify-v2.1.4/jquery.uploadify.v2.1.4.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#uploadify").uploadify({
				'uploader' : 'uploadify-v2.1.4/uploadify.swf',
				'script' : '../UploadPhotos',//��̨���������
				'cancelImg' : 'uploadify-v2.1.4/cancel.png',
				'folder' : 'uploads',//���뽫�ļ����浽��·��
				'queueID' : 'fileQueue',//�������id��Ӧ
				'queueSizeLimit' : 20,
				'fileDesc' : 'jpg,png�ļ�',
				'fileExt' : '*.jpg;*.png', //���ƿ��ϴ��ļ�����չ�������ñ���ʱ��ͬʱ����fileDesc
				'auto' : false,
				'multi' : true,
				'simUploadLimit' : 2,
				'buttonText' : "Browse images"
			});
			$("#user_album_list").change(function(){
				var _selectAlbumId = $("#user_album_list").find("option:selected").val();
				var location = "album/upload_photo.jsp?album="+_selectAlbumId;
				window.location.href=location;
				/*
				$.ajax({
			        type:'POST',
			        url:"UploadPhotosControll",
			        data:"action=change_album_to_upload&&des_album_id="+_selectAlbumId,
			        async:true,
			        cache: false,
			        success:function(responseData){
			           // alert(responseData);
			        }
			    });
			    */
			});
		});
		
		function goBackToAlbum(_aid){
            	//alert(_aid);
            	if(_aid=="default"){
            		alert("default");
            	}
            	window.location.href="<%=path%>/pictures.jsp?album="+_aid;
            }; 
	</script>
  </head>
  
  <body>
  <div id="header" class="header">
  	<div class="navigation" >
	  <ul class="top_nav" style="float:left;">
		<li><a class="yahei" href="./index.jsp">��ҳ</a></li>
		<li><a class="yahei" href="./album.jsp">�ҵ�ר��</a></li>
	  </ul>		
	  <div style="float:right;margin-right:20px;" id="top_user_info">
		  <user:userInfo userId="<%=userId %>" />
	  </div>
	  </div>		
  </div>
  <div class="clear"></div>
  <div class="content" style="height:100%;margin-top:0;">
		<div class="grid">
			<div class="g1024 space-bot">
				<div class="row space-bot" style="height:30px;"></div>
				<div class="row space-bot">
						<jsp:include page="../message.jsp"></jsp:include>
				</div>
				<!-- Add photos -->
				<div class="row space-bot">
				<button id="goback_to_album" class="small" onclick="goBackToAlbum(<%=albumId %>)">ת�������</button>
						<form class="hform">
							<label style="width:20%;">ѡ��ר����</label>
							<album:albumList selectId="<%=albumId %>" userId="<%=userId %>"/>
						</form>
						<div id="fileQueue" style="margin-bottom:10px;"></div>
						<input type="file" name="uploadify" id="uploadify" />
						<br /><br />
						<p>
							<button onclick="javascript:jQuery('#uploadify').uploadifyUpload()">��ʼ�ϴ�</button>&nbsp;
							<button onclick="javascript:jQuery('#uploadify').uploadifyClearQueue()">ȡ�������ϴ�</button>
						</p>
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
