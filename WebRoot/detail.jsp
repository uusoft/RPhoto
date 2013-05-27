<%@ page language="java" import="java.util.*" 
import="com.raysmond.bean.User"
import="com.raysmond.bean.Album"
import="com.raysmond.db.dao.AlbumDao"
import="com.raysmond.db.impl.AlbumDaoImpl"
 pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/galleria.tld" prefix="galleria"%>
<%@ taglib uri="/WEB-INF/user_info.tld" prefix="user"%>
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
    <title>My JSP 'album.jsp' starting page</title>
	<link rel="stylesheet" type="text/css" href="styles/IVORY-master/css/ivory.css">
	<link rel="stylesheet" type="text/css" href="styles/jquery-ui/jquery-ui-1.10.2.custom.min.css">
	<link rel="stylesheet" type="text/css" href="styles/style.css">
    <script src="scripts/jquery-1.9.1.min.js"></script>
    <script src="scripts/galleria-1.2.9.js"></script>
    <script src="scripts/rphoto.js"></script>
	<script type="text/javascript" src="scripts/jquery-ui-1.10.2.custom.js"></script>
	<style>
	#galleria{height:585px}
	#photo_tag .ui-button-text-only .ui-button-text{padding:0 5px;}
	#tag_list .tag-item{margin-right:5px;}
	</style>
	<script>
	$(function() {
      var name = $( "#name" ),
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
    
    function addTagCallback(response){
    	reloadTagList();
    }
 
    $( "#dialog-form" ).dialog({
      autoOpen: false,
      height: 200,
      width: 350,
      modal: true,
      buttons: {
        "添加标签": function() {
          var bValid = true;
          allFields.removeClass( "ui-state-error" );
          bValid = bValid && checkLength( name, "newtag", 1, 20 );
          //bValid = bValid && checkRegexp( name, /^[a-z]([0-9a-z_])+$/i, "Username may consist of a-z, 0-9, underscores, begin with a letter." );
          if ( bValid ) {
            ayncRPhoto("UserTagControll",
            	"action=add_tag&&photo_id="+$("#add_comment_photo_id").val() 
            	+"&&tag_name="+encodeURIComponent($("#name").val()),
            	addTagCallback);
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
 
    $( "#create-tag" )
      .button()
      .click(function() {
        $( "#dialog-form" ).dialog( "open" );
      });
   });
  		function addTagAction(){
  			$("#dialog").dialog();
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
	  </ul>
	  <div style="float:right;margin-right:20px;" id="top_user_info">
		  <user:userInfo userId="<%=userId %>" />
	  </div>
	  </div>		
  </div>
  <div class="clear"></div>
  <div class="content">
		<div class="grid">
			<div class="row space-bot">
					<jsp:include page="message.jsp"></jsp:include>
			</div>
			<div class="row space-bot">
			<div class="c9 first">
				<galleria:galleria albumId="<%=albumId %>"/>
			</div>
			<div class="c3 last">
				<div class="note" style="padding:10px;font-size:14px;font-family:Arail,微软雅黑;line-height:150%;">
				<div style="height:75px;">
					<div style="float:left;margin-right:10px;"><img src="images/picture.jpg" style="width:64px;height:64px;border-radius:5px;" /></div>
					<div id="album_info" style="float:left;width:190px;">
						<!-- Async album info -->
					</div>
				</div>
				<div id="photo_info">
					图片标题：<span id="photo_title" class="photo_title">环球风景</span><br/>
					<div id="photo_tag" >
					<%if(isCurrentUser){ %>
					<a id="create-tag" style="float:left;font-size:14px;" class="yahei small" title="点击为该图片添加标签">标签：</a>
					<%}else{ %>
					标签：
					<%} %>
					<div id="tag_list" style="width:205px;float:right;">
						<!-- async tags -->
					</div>
					<div style="clear:both;"></div>
					<%if(isCurrentUser){ %>
					<div id="dialog-form" title="添加新标签">
					  <form class="hform" style="margin-top:20px;">
					  <fieldset>
					    <label for="name">标签名字</label>
					    <input type="text" name="name" id="name" class="text ui-widget-content ui-corner-all" />
					  </fieldset>
					  </form>
					</div>
					<%} %>
					</div>
				</div>
				<div id="photo_comment" style="margin-top:10px;">
					<span>评论：</span><br/>
					<form class="hform" id="photo_comment_form" action="CommentsControll" method="post" style="margin-bottom:5px;">
						<input type="hidden" name="action" value="add_photo_comment" />
						<input id="add_comment_photo_id" type="hidden" name="comment_photo_id" value="40" />
						<textarea id="add_comment_content" name="comment_content"  rows="3" style="width:100%;min-height:80px;height:80px;">
						</textarea>
					</form>
					<button onclick="javascript:addCommentAction()" class="small skyblue">发表评论</button>
					<div id="comments" style="height:auto;">
					
					</div>
				</div>
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
                
		// Load the classic theme
	    Galleria.loadTheme('scripts/galleria.classic.js');
	    // Initialize Galleria
	    Galleria.run('#galleria');
	    
	    loadAlbumInfo("<%=albumId%>");
	</script>
  </body>
</html>
