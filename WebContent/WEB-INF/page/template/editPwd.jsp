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
<script type="text/javascript"	src="/js/site/editPwd.js"></script>
</head>
<body style="padding-top: 45px">
 <form id="editPwdForm" method="post">
 	<input id="url" type="hidden" value="${url}" />
 	<div style="text-align: center;font-size: 20px;font-weight: bold;">修改密码</div>
	<div class="msgBoxContent">
		<div class="form_item">
			<span class="form_span">当前密码：</span>
			<input type="password" class="piece" name="oPassword" id="oPassword" maxlength="20"/>
			<span style="color:red">*</span>
		</div>
		<div class="form_item">
			<span class="form_span">密　　码：</span>
			<input type="password" class="piece" name="password" id="password" maxlength="20"/>
			<span style="color:red">*</span>
		</div>
		<div class="form_item">
			<span class="form_span">确认密码：</span>
			<input type="password" class="piece" name="rePassword" id="rePassword" maxlength="20"/>
			<span style="color:red">*</span>
		</div>
		<div style="text-align: center;">
			<input type="button" class="other_btn" id="editBtn" value="修改" />
		</div>
	</div>
 </form>
</body>
</html>

