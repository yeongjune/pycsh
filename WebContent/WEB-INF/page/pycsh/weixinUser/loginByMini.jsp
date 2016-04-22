<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>登录</title>
	<link rel="stylesheet" type="text/css" href="/template/charity/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/template/charity/css/index.css" />
    <link rel="stylesheet" type="text/css" href="/template/charity/css/module.css" />
    
	<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/js/base/util.js"></script>
	<script type="text/javascript" src="/js/base/md5.min.js"></script>
		<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
$(function(){
	if("${tips}"!=""){
		alert("${tips}");
	}
});

function sendCaptcha(){
	
	$.post("${ctx}/weixinUser/sendCaptcha.action",{"mobilesStr":$("#mobilesStr").val()},function(e){
		if(e=="ok"){
			alert("发送成功!");
		}else if(e=="notMobiles"){
			alert("请正确填写手机号!");
			$("#mobilesStr").focus();
		}
		
	},"text");
}


function submitLogin(){
	$("#password").val(hex_md5($("#passwordStr").val()));
	$("#loginForm").submit();
	
}

function toRegister(){
	
	$("#loginForm").attr("action","${ctx }/weixinUser/toRegister.action");
	$("#loginForm").submit();
	
}


function toFindPassword(){
	
	$("#loginForm").attr("action","${ctx }/weixinUser/toFindPassword.action");
	$("#loginForm").submit();
	
}


function putTitle(emt,str){
	if($(emt).val()==str){
		
		$(emt).val("");
	}
}

function blurTitle(emt,str){
	if($(emt).val()==""){
		
		$(emt).val(str);
	}
}

function showPassowrd(){
	$("#passwordTips").hide();
	$("#passwordStr").show();
	$("#passwordStr").focus();
}

function showPasswordTips(){
	
	if($("#passwordStr").val()==""){
		$("#passwordTips").show();
		$("#passwordStr").hide();
	}
	
	
}

function isSubmit(){
	var event = event || window.event || arguments.callee.caller.arguments[0];
	if(event.keyCode==13){
		submitLogin();
	}
	
}
</script>
</head>
<body>
<form id="loginForm" action="${ctx }/weixinUser/loginByPassword.action" method="post">
	<div class="po_rbox">
	<div class="po_r_ti">广州市番禺区慈善会 用户登录</div>
    <div class="r_in">
    	<ul>
        	<li><input type="text" class="r_in_input" id="mobilesStr" value="请输入手机号码" name="loginName" onfocus="putTitle(this,'请输入手机号码');" onblur="blurTitle(this,'请输入手机号码');"/></li>
        	<li>
        		<input type="text" class="r_in_input" id="passwordTips" value="请输入密码" onfocus="showPassowrd();"/>
        		<input type="password" class="r_in_input"id="passwordStr" style="display: none;" onblur="showPasswordTips();" onkeydown="isSubmit();"/>
        		<input type="hidden" name="password" id="password" />
        	</li>
        	
        	     
            <li><a class="z_btn"  href="javascript:void(0);" onclick="submitLogin();" >登录</a></li>
            <li><a class="f_d" href="javascript:void(0);" onclick="toRegister();">注册</a> <a class="f_d" href="javascript:void(0);" onclick="toFindPassword();">找回密码</a></li>
        </ul>
        <input type="hidden" name="url" value="${url }"/>
		<input type="hidden" name="parameters" value="${parameters }"/>
    </div>
</div>
</form>
</body>

</html>