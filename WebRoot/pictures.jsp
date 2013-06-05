<%@ page language="java" import="java.util.*" 
import="com.raysmond.bean.User"
import="com.raysmond.bean.Album"
import="com.raysmond.db.dao.AlbumDao"
import="com.raysmond.db.impl.AlbumDaoImpl"
 pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/user_albums.tld" prefix="rasymond"%>
<%@ taglib uri="/WEB-INF/user_info.tld" prefix="user"%>
<%@ taglib uri="/WEB-INF/user_picture_in_album.tld" prefix="pictures"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	User user = (User) session.getAttribute("AUTH_USER");
	boolean isCurrentUser = false;
	String albumId = request.getParameter("album");
	if(albumId==null||albumId.equals("")){
		albumId="";
		response.sendRedirect("login.jsp");
		return;
	}
	String userId = "";
	if(user!=null){
		userId = "" + user.getUid();
		int aid = Integer.parseInt(albumId);
		 AlbumDao dao = new AlbumDaoImpl();
		 Album album = dao.getAlbumById(aid);
		 if(album==null||album.getAid()<=0){
		 	//这个专辑不存在，转到404
		 	//后期实现：使用Filter
		 	%>
		 	<jsp:forward page="404.jsp"/>
		 	<% 
			return;
		 }
		 if(album.getAid()>0&&album.getUser().getUid()==user.getUid()){
		 	//当前查看的相册就是登录用户的相册
		 	isCurrentUser = true;
		 	System.out.println("is current user.");
		 }
	}
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>查看专辑图片</title>
	<link rel="stylesheet" type="text/css" href="styles/IVORY-master/css/ivory.css">
	<link rel="stylesheet" type="text/css" href="styles/jquery-ui/jquery-ui-1.10.2.custom.min.css">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<script type="text/javascript" src="scripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="scripts/jquery-ui-1.10.2.custom.js"></script>
	<script type="text/javascript" src="scripts/rphoto.js"></script>
	<script>
	 function editPhotoName(_pid,_name){
	 			//alert(_name);
            	$("#_photo_name").val(_name);
				$("#_photo_id").val(_pid);
				$( "#dialog-form" ).dialog( "open" );
            }
     function deletePhotoInAlbumCallBack(response){
			 	alert(response);
			 	window.location.reload();
			 	}
     function deletePhotoInAlbum(_pid){
     	//alert(_pid);
     	ayncRPhoto("AsyncPhoto",
     				"action=delete_photo&&_photo_id=" +_pid,
			       deletePhotoInAlbumCallBack);
     }
    
	</script>
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
				<div class="row space-bot" style="margin-bottom:10px;">
					<button type="button"  
							onclick="window.location.href='detail.jsp?album=<%=albumId%>'"  
							class="orange small" 
							style="margin-bottom:0;">查看幻灯片</button>
					<%if(isCurrentUser){ %>
					<button type="button"  
							onclick="window.location.href='album/upload_photo.jsp?album=<%=albumId %>'"  
							class="orange small" 
							style="margin-bottom:0;">上传图片</button>
					<% } %>
				</div>
				<div class="row space-bot">
					<pictures:picturesInAlbum albumId="<%=albumId %>"/>
				</div>
				<div class="row space-bot" style="margin-bottom:0;">
					<div id="dialog-form" title="修改图片名">
					  <form class="hform" style="margin-top:20px;">
					  <fieldset>
					    <label for="_photo_name">新的图片名</label>
					    <input type="hidden" id="_photo_id" name="_photo_id" />
					    <input type="text" name="_photo_name" id="_photo_name" class="text ui-widget-content ui-corner-all" />
					  </fieldset>
					  </form>
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
            
             $(function(){
            	  var name = $( "#_photo_name" ),
			      allFields = $( [] ).add( name ),
			      tips = $( ".validateTips" );
			 
			      function updateTips( t ) {
				      tips
				        .text( t )
				        .addClass( "ui-state-highlight" );
				      setTimeout(function() {
				        tips.removeClass( "ui-state-highlight", 1500 );
				      }, 500 );
			      }
			 
			   	  function checkLength( o, n, min, max ) {
				      if ( o.val().length > max || o.val().length < min ) {
				        o.addClass( "ui-state-error" );
				        updateTips( "Length of " + n + " must be between " +
				          min + " and " + max + "." );
				        return false;
				      } else {
				        return true;
				      }
			    	}
			 
			    function checkRegexp( o, regexp, n ) {
			      if ( !( regexp.test( o.val() ) ) ) {
			        o.addClass( "ui-state-error" );
			        updateTips( n );
			        return false;
			      } else {
			        return true;
			      }
			    }
			    
			 	function editNameCallBack(response){
			 		//for shame, I just refresh the whole page
			 		alert(response);
			 		window.location.reload();
			 	}
			    $( "#dialog-form" ).dialog({
			      autoOpen: false,
			      height: 200,
			      width: 350,
			      modal: true,
			      buttons: {
			        "确定": function() {
			          var bValid = true;
			          allFields.removeClass( "ui-state-error" );
			          bValid = bValid && checkLength( name, "_photo_name", 1, 20 );
			          //bValid = bValid && checkRegexp( name, /^[a-z]([0-9a-z_])+$/i, "Username may consist of a-z, 0-9, underscores, begin with a letter." );
			          if ( bValid ) {
			            ayncRPhoto("AsyncPhoto","action=change_photo_name&&_photo_id="
			            	+$("#_photo_id").val()
			            	+"&&_photo_name="+encodeURIComponent($("#_photo_name").val()),
			            	editNameCallBack);
			            $( this ).dialog( "close" );
			          }
			        },
			        "取消": function() {
			          $( this ).dialog( "close" );
			        }
			      },
			      close: function() {
			        allFields.val( "" ).removeClass( "ui-state-error" );
			      }
			    });
            });           
	</script>
  </body>
</html>
