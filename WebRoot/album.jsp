<%@ page language="java" import="java.util.*" import="com.raysmond.bean.User" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/user_albums.tld" prefix="rasymond"%>
<%@ taglib uri="/WEB-INF/user_info.tld" prefix="user"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String userId = request.getParameter("uid");
	String ispublic = "public";
	ispublic = request.getParameter("r");
	boolean isCurrentUser = false;
	if(userId==null||userId.equals("")){
		User user = (User)session.getAttribute("AUTH_USER");
		if(user==null){
			String msg = new String("请先登录！".getBytes(),"ISO-8859-1");
			response.sendRedirect("login.jsp?error="+msg);
			return;
		}
		userId = Integer.toString(user.getUid());
		isCurrentUser = true;
		if(ispublic==null||ispublic.equals("")){
			ispublic = "all";
		}
	}
	else{
		User user = (User)session.getAttribute("AUTH_USER");
		if(user!=null&&Integer.parseInt(userId)==user.getUid()){
			if(ispublic==null||ispublic.equals("")){
				ispublic = "all";
			}
			isCurrentUser = true;
		}
		else{
			ispublic = "public";
			isCurrentUser = false;
		}
	}
	//URL中没有设置r，或者用户没有登录
	if(ispublic==null||ispublic.equals("")){
		ispublic = "public";
		}
    
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>专辑</title>
	<link rel="stylesheet" type="text/css" href="styles/IVORY-master/css/ivory.css">
	<link rel="stylesheet" type="text/css" href="styles/jquery-ui/jquery-ui-1.10.2.custom.min.css">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
	<script type="text/javascript" src="scripts/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="scripts/jquery-ui-1.10.2.custom.js"></script>
	<script type="text/javascript" src="scripts/rphoto.js"></script>
	<script>
	function editAlbum(_aid,_name){
		$("#album_name").val(_name);
		$("#album_aid").val(_aid);
		$( "#dialog-form" ).dialog( "open" );
	}
	function deleteAlbum(_aid){
		
	}
	</script>
	<style>
	.album_item:hover{
		opacity:0.8;
	}
	</style>
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
				<% if(isCurrentUser){ %>
				<div class="row space-bot">
					<button type="button"  
						onclick="window.location.href='album/add_album.jsp'"  
						class="orange small" 
						style="margin-bottom:0;">新建专辑</button>
					<button type="button"  
						onclick="window.location.href='album/upload_photo.jsp'"  
						class="orange small" 
						style="margin-bottom:0;">上传图片</button>	
					<form class="hform" action="" style="float:left;width:200px;margin-bottom:0;">
					<select style="width:90%;height:30px;" onchange="window.location.href=(this.options[this.selectedIndex].value)">
					<%
						String right = request.getParameter("r");
						if(right==null||right.equals("")){
							right = "all";
						}
						out.print("<option "+(right.equals("all")?"selected":"")+" value=\"album.jsp?r=all\">全部专辑</option>");
						out.print("<option "+(right.equals("public")?"selected":"")+" value=\"album.jsp?r=public\">公开专辑</option>");
						out.print("<option "+(right.equals("private")?"selected":"")+" value=\"album.jsp?r=private\">私有专辑</option>");
					 %>
					</select>
					</form>
				</div>
				<% } %>
				<div class="row space-bot">
					<rasymond:userAlbumsTag ispublic="<%=ispublic %>" userId="<%=userId %>" />
				</div>
				<div class="row space-bot" style="margin-bottom:0;">
					<div id="dialog-form" title="修改专辑名">
					  <form class="hform" style="margin-top:20px;">
					  <fieldset>
					    <label for="album_name">新的专辑名</label>
					    <input type="hidden" id="album_aid" name="album_aid" />
					    <input type="text" name="album_name" id="album_name" class="text ui-widget-content ui-corner-all" />
					  </fieldset>
					  </form>
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
            $(function(){
            	  var name = $( "#album_name" ),
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
			          bValid = bValid && checkLength( name, "album_name", 1, 20 );
			          //bValid = bValid && checkRegexp( name, /^[a-z]([0-9a-z_])+$/i, "Username may consist of a-z, 0-9, underscores, begin with a letter." );
			          if ( bValid ) {
			            ayncRPhoto("AysncAlbum","action=change_album_name&&album_id="
			            	+$("#album_aid").val()
			            	+"&&album_name="+encodeURIComponent($("#album_name").val()),
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
            toolbar('header');            
</script>
  </body>
</html>
