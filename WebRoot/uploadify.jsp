<%@ page language="java" contentType="text/html; charset=GBK"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>Upload</title>

<link href="uploadify-v2.1.4/uploadify.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="scripts/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="uploadify-v2.1.4/swfobject.js"></script>
<script type="text/javascript" src="uploadify-v2.1.4/jquery.uploadify.v2.1.4.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$("#uploadify").uploadify({
			'uploader' : 'uploadify-v2.1.4/uploadify.swf',
			'script' : 'servlet/Uploadify',//后台处理的请求
			'cancelImg' : 'uploadify-v2.1.4/cancel.png',
			'folder' : 'uploads',//您想将文件保存到的路径
			'queueID' : 'fileQueue',//与下面的id对应
			'queueSizeLimit' : 5,
			'fileDesc' : 'rar文件或zip文件',
			'fileExt' : '*.jpg;*.png', //控制可上传文件的扩展名，启用本项时需同时声明fileDesc
			'auto' : false,
			'multi' : true,
			'simUploadLimit' : 2,
			'buttonText' : 'BROWSE'
		});
	});
</script>
</head>

<body>
	<div id="fileQueue"></div>
	<input type="file" name="uploadify" id="uploadify" />
	<p>
		<a href="javascript:jQuery('#uploadify').uploadifyUpload()">开始上传</a>&nbsp;
		<a href="javascript:jQuery('#uploadify').uploadifyClearQueue()">取消所有上传</a>
	</p>
</body>
</html>