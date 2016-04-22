<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>登录</title>
	<link rel="stylesheet" type="text/css" href="/skins/login/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/skins/login/css/login.css" />
	<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/js/base/util.js"></script>
	<script type="text/javascript" src="/js/base/md5.min.js"></script>
		<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<script type="text/javascript">

$(function(){
	if("${url}"!=""){
		if("${url}".indexOf("go-userSign.html") > 0){
			art.dialog.open.origin.location.href="${url}?${parameters}";
			//window.location.href="${url}?${parameters}";
		}else{
			window.location.href="${url}?${parameters}";
		}
	}else{
		art.dialog.close();
	}
});

</script>
</head>
<body>
</body>
</html>