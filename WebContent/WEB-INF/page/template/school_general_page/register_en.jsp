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
<script type="text/javascript" src="/js/site/register_en.js"></script>
</head>
<body style="padding-top: 45px">
 <form id="registerForm" method="post" onsubmit="return false;">
 	<input id="url" type="hidden" value="${url}" />
 	<div style="text-align: center;font-size: 20px;font-weight: bold;">USER REGIST</div>
	<div class="msgBoxContent">
		<div class="form_item">
			<span class="form_span">ACCOUNT：</span>
			<input type="text" class="piece" name="acount" id="acount" maxlength="20"/>
			<span style="color:red">*</span>
		</div>
		<div class="form_item">
			<span class="form_span">PASSWORD：</span>
			<input type="password" class="piece" name="password" id="password" maxlength="20"/>
			<span style="color:red">*</span>
		</div>
		<div class="form_item">
			<span class="form_span">PASSWORD AGAIN：</span>
			<input type="password" class="piece"  id="confirmPassword" maxlength="20"/>
			<span style="color:red">*</span>
		</div>
		<!-- <div class="form_item">
			<span class="form_span">NICKNAME：</span>
			<input type="text" class="piece" name="nikeName" id="nikeName" maxlength="20"/>
			<span style="color:red"></span>
		</div> -->
		<div class="form_item">
			<span class="form_span">E-MAIL：</span>
			<input type="text" class="piece" name="email" id="email" maxlength="100"/>
			<span style="color:red"></span>
		</div>
		<div class="form_item">
			<span class="form_span">IDENTITY：</span>
			<select id="identity" class="piece" style="width: 208px;">
				<option value="学生">STUDENT</option>
				<option value="教师">TEACHER</option>
			</select>
			<span style="color:red"></span>
		</div>
		<div class="form_item">
			<span class="form_span">CLASS/DEPARTMENT：</span>
			<input type="text" class="piece" name="department" id="department" maxlength="20" placeholder="department/class/team..."/>
			<span style="color:red"></span>
		</div>
		<div style="text-align: center;">
			<input type="submit" class="other_btn" id="registerBtn" value="REGIST"/>
			<input type="button" class="other_btn" id="loginBtn" value="LOGIN" />
		</div>
	</div>
 </form>
</body>
</html>

