<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>注册</title>
	<link rel="stylesheet" type="text/css" href="/template/charity/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/template/charity/css/index.css" />
    <link rel="stylesheet" type="text/css" href="/template/charity/css/module.css" />
	<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/js/base/util.js"></script>
	<script type="text/javascript" src="/js/base/md5.min.js"></script>
<script type="text/javascript">

$(function(){
	if("${tips}"!=""){
		alert("${tips}");
	}
});

var sendFlag =true;
function sendCaptcha(){
	if(sendFlag){
		sendFlag=false;
		$.post("${ctx}/weixinUser/sendCaptcha.action",{"mobilesStr":$("#mobilesStr").val()},function(e){
			if(e=="ok"){
				waitTime=60;
				$("#sendCaptchaBtn").html("重新发送("+waitTime+")");
				setInterval(sendTime,1000);
				alert("发送成功!");
				
			}else if(e=="notMobiles"){
				alert("请正确填写手机号!");
				$("#mobilesStr").focus();
				
			}
			else if(e=="notMsgCount"){
				alert("短信服务暂时停用,不便之处敬请原谅!");
				$("#mobilesStr").focus();
				
			}
			sendFlag=true;
			
		},"text");
	}
	
}

var waitTime = 0;
function sendTime(){
	if(waitTime==0){
		sendFlag=true;
		$("#sendCaptchaBtn").html("重新发送");
	}else{
		waitTime--;
		sendFlag=false;
		$("#sendCaptchaBtn").html("重新发送("+waitTime+")");
	}
}

function saveRegister(){
	$("#password").val(hex_md5($("#passwordStr").val()));
	$("#registerForm").submit();
	
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

</script>
</head>
<body>
<form id="registerForm" action="${ctx }/weixinUser/saveRegister.action" method="post">
	<div class="po_rbox">
	<div class="po_r_ti">广州市番禺区慈善会 会员注册</div>
    <div class="r_in">
    	<ul>
        	<li><input type="text" class="r_in_input" id="mobilesStr" value="请输入手机号码" name="loginName" onfocus="putTitle(this,'请输入手机号码');" onblur="blurTitle(this,'请输入手机号码');"/></li>
        	<li>
        		<input type="text" class="r_in_input"  value="请输入密码" name="passwordStr" id="passwordStr" onfocus="putTitle(this,'请输入密码');" onblur="blurTitle(this,'请输入密码');"/>
        		<input type="hidden" name="password" id="password"/>
        	</li>
            <li><input type="text" class="r_in_tinput" value="" name="captcha" /><a class="i_btn" id="sendCaptchaBtn" href="javascript:void(0);" onclick="sendCaptcha();" >获取验证码</a></li>
           
            <li><a class="z_btn" href="javascript:void(0);" onclick="saveRegister();">注册</a></li>
            <li><a class="f_d" href="javascript:void(0);" onclick="toLoginByMini();">返回登陆</a></li>
        </ul>
        <input type="hidden" name="url" value="${url }"/>
		<input type="hidden" name="parameters" value="${parameters }"/>
    </div>
</div>
</form>
</body>
</html>