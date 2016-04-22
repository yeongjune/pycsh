<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<script type="text/javascript">

$(function(){

});


</script>
</head>
<body>

${fn:substring(sessionScope.weixinUser.loginName, 0, 4)}*****${fn:substring(sessionScope.weixinUser.loginName, 9, 11)}


${sessionScope.weixinUser.name }

</body>
</html>