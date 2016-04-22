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
<script type="text/javascript" src="/js/site/register.js"></script>
</head>
<body style="padding-top: 45px">
 <form id="registerForm" method="post" onsubmit="return false;">
 	<input id="url" type="hidden" value="${url}" />
 	<div style="text-align: center;font-size: 20px;font-weight: bold;">用户注册</div>
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
		<div class="form_item">
			<span class="form_span">确认密码：</span>
			<input type="password" class="piece"  id="confirmPassword" maxlength="20"/>
			<span style="color:red">*</span>
		</div>
		<!-- <div class="form_item">
			<span class="form_span">昵　　称：</span>
			<input type="text" class="piece" name="nikeName" id="nikeName" maxlength="20"/>
			<span style="color:red"></span>
		</div> -->
		<div class="form_item">
			<span class="form_span">邮　　箱：</span>
			<input type="text" class="piece" name="email" id="email" maxlength="100"/>
			<span style="color:red"></span>
		</div>
		<!-- 
		<div class="form_item">
			<span class="form_span">身　　份：</span>
			<input type="text" class="piece" name="identity" id="identity" maxlength="20" placeholder="学生/客人/老师/业务员等..."/>
			<span style="color:red"></span>
		</div>
		<div class="form_item">
			<span class="form_span">部　　门：</span>
			<input type="text" class="piece" name="department" id="department" maxlength="20" placeholder="团队/部门/班别等..."/>
			<span style="color:red"></span>
		</div>
		 -->
		<div style="text-align: center;">
			<input type="submit" class="other_btn" id="registerBtn" value="注册"/>
			<input type="button" class="other_btn" id="loginBtn" value="登录" />
		</div>
	</div>
 </form>
</body>
</html>

