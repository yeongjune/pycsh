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
	
	if($("#passwordStr1").val()==$("#passwordStr2").val()&&$("#passwordStr1").val()!=""){
		$("#password").val(hex_md5($("#passwordStr1").val()));
		$("#loginForm").submit();
	}else{
		alert("两次密码不一致!");
	}
	
	
	
}

function toLoginByMini(){
	
	$("#registerForm").attr("action","${ctx }/weixinUser/toLoginByMini.action");
	$("#registerForm").submit();
	
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


function showPassowrd1(){
	$("#passwordTips1").hide();
	$("#passwordStr1").show();
	$("#passwordStr1").focus();
}

function showPasswordTips1(){
	
	if($("#passwordStr1").val()==""){
		$("#passwordTips1").show();
		$("#passwordStr1").hide();
	}
	
	
}

function showPassowrd2(){
	$("#passwordTips2").hide();
	$("#passwordStr2").show();
	$("#passwordStr2").focus();
}

function showPasswordTips2(){
	
	if($("#passwordStr2").val()==""){
		$("#passwordTips2").show();
		$("#passwordStr2").hide();
	}
	
	
}



</script>
</head>
<body>
<form id="loginForm" action="${ctx }/weixinUser/updateResetPassword.action" method="post">
	<div class="po_rbox">
	<div class="po_r_ti">广州市番禺区慈善会 重置密码</div>
    <div class="r_in">
    	<ul>
        	<li>
        		<input type="text" class="r_in_input" id="passwordTips1" value="请输入密码" onfocus="showPassowrd1();"/>
        		<input type="password" class="r_in_input"  name="passwordStr1" id="passwordStr1"  onblur="showPasswordTips1();" style="display: none;"/>
        	</li>
        	<li>
        		<input type="text" class="r_in_input" id="passwordTips2" value="请再次输入密码" onfocus="showPassowrd2();"/>
        		<input type="password" class="r_in_input" name="passwordStr2" id="passwordStr2"  onblur="showPasswordTips2();" style="display: none;"/>
        		<input type="hidden" name="password" id="password"/>
        	</li>
        	     
            <li><a class="z_btn"  href="javascript:void(0);" onclick="submitLogin();" >确定</a></li>
            <li><a class="f_d" href="javascript:void(0);" onclick="toLoginByMini();">返回</a></li>
        </ul>
        <input type="hidden" name="url" value="${url }"/>
		<input type="hidden" name="parameters" value="${parameters }"/>
    </div>
</div>
</form>
</body>

</html>