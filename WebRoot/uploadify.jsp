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
			'script' : 'servlet/Uploadify',//��̨���������
			'cancelImg' : 'uploadify-v2.1.4/cancel.png',
			'folder' : 'uploads',//���뽫�ļ����浽��·��
			'queueID' : 'fileQueue',//�������id��Ӧ
			'queueSizeLimit' : 5,
			'fileDesc' : 'rar�ļ���zip�ļ�',
			'fileExt' : '*.jpg;*.png', //���ƿ��ϴ��ļ�����չ�������ñ���ʱ��ͬʱ����fileDesc
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
		<a href="javascript:jQuery('#uploadify').uploadifyUpload()">��ʼ�ϴ�</a>&nbsp;
		<a href="javascript:jQuery('#uploadify').uploadifyClearQueue()">ȡ�������ϴ�</a>
	</p>
</body>
</html>