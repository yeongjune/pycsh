<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${site.name }</title>
<style type="text/css">
*{padding: 0;margin: 0px;font-size:12px;}
.other_btn{border:solid 1px #ccc;width:66px;height: 26px;border-radius:3px;}
.other_btn:hover{font-weight: bold;}
</style>
<link href="/skins/blue/css/table_form.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"	src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript"	src="/js/base/md5.min.js"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=idialog"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="/js/site/login.js"></script>
</head>
<body style="padding-top: 45px">
 <form id="loginForm" action="/userCenter/login.action" method="post">
 	<input id="url" type="hidden" value="${url}" />
 	<div style="text-align: center;font-size: 20px;font-weight: bold;">用户登录</div>
	<div class="msgBoxContent">
		<div class="form_item">
			<span class="form_span">帐　　号：</span>
			<input type="text" class="piece" name="acount" id="acount" maxlength="20"/>
			<span style="color:red">*</span>
		</div>
		<div class="form_item">
			<span class="form_span">密　　码：</span>
			<input type="password" class="piece" name="password" id="password" maxlength="20"/>
			<span style="color:red">*</span>
		</div>
		<div class="form_item" id="div_validCode" style="display: none">
			<span class="form_span">　验证码：</span>
			<input type="text" class="piece2" name="validCode" id="validCode" maxlength="5" style="width: 80px"/>
			<img src="/validCode.jpg" style="vertical-align: middle" alt="点击更换验证码" id="imgChange" />
			<span style="color:red" id="validError"></span>
		</div>

		<div style="text-align: center;">
			<input type="submit" class="other_btn" id="loginBtn" value="登录" />
			<input type="button" class="other_btn" id="registerBtn" value="注册"/>
		</div>
	</div>
 </form>
</body>
</html>

