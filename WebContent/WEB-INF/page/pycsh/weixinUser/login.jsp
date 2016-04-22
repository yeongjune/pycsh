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
<script type="text/javascript">

$(function(){
	if("${tips}"!=""){
		alert("${tips}");
	}
});

function sendCaptcha(){
	
	$.post("${ctx}/weixinUser/sendCaptcha.action",{},function(e){
		if(e=="ok"){
			alert("发送成功!");
		}
		
	},"text");
}


function submitLogin(){
	
	$("#loginForm").submit();
	
}
</script>
</head>
<body>
<form id="loginForm" action="${ctx }/weixinUser/loginByCaptcha.action" method="post">

<fieldset class="fieldset_border">
	<legend class="legend_title">登录</legend>
		<div class="form_search_item" >
			<input type="text" name="loginName" /> <a id="sendCaptchaBtn" href="javascript:void(0);" onclick="sendCaptcha();">发送验证码</a>
			
			<input type="text" name="captcha" />
			<a  href="javascript:void(0);" onclick="submitLogin();">登录</a>
		</div>
		
</fieldset>
</form>
</body>
</html>