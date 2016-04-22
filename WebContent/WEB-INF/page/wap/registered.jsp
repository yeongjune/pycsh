<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<link rel="shortcut icon" type="image/x-icon" href="/skins/wap/images/iliubang.ico"/>
<link rel="stylesheet" type="text/css" href="/skins/wap/css/base.css" />
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/base/util.js"></script>
<script type="text/javascript" src="/js/base/md5.min.js"></script>
<title>注册</title>
<script type="text/javascript">

var sendFlag =true;
function sendCaptcha(){
	if(sendFlag){
		sendFlag=false;
		$.post("${ctx}/weixinUser/sendCaptcha.action",{"mobilesStr":$("#phone").val()},function(e){
			if(e=="ok"){
				waitTime=60;
				$("#sendBtn").html("重新发送("+waitTime+")");
				setInterval(sendTime,1000);
				alert("发送成功!");
				
			}else if(e=="notMobiles"){
				alert("请正确填写手机号!");
				$("#phone").focus();
			}
			sendFlag=true;
			
		},"text");
	}
	
}


function saveRegister(){
	$.post("/wxUser/bindPhone.action",$("#registerForm").serialize(),function(e){
		if(e=="ok"){
			alert("注册成功!");
			window.location.href="${sessionScope.callBackUrl}";
		}
		if(e=="isRes"){
			alert("该微信账号已注册!");
		}
		if(e=="captchaError"){
			alert("验证码错误!");
		}
		if(e=="userError"){
			alert("手机号错误!");
		}
		
		
	},"text");
	//$("#registerForm").submit();
	
}

var waitTime = 0;
function sendTime(){
	if(waitTime==0){
		sendFlag=true;
		$("#sendBtn").html("重新发送");
	}else{
		waitTime--;
		sendFlag=false;
		$("#sendBtn").html("重新发送("+waitTime+")");
	}
}


</script>
</head>

<body class="bj">
	<div class="box ">
		<div class="r_title">注册番禺区慈善会账号</div>
		<form id="registerForm" action="${ctx }/wxUser/bindPhone.action" method="post">
		
        <div class="r_list">
        	<ul>
            	<li><div class="r_l_t">${wxUser.nickname }<font class="gray">(微信默认昵称)</font><input name="name" id="name" type="hidden" value="${wxUser.nickname }"/></div></li>
                <li>
                	<div class="pho_t">手机号</div>
                    <div class="pho_inp"><input name="phone" id="phone" type="text" class="input"/></div>
                </li>
                <li>
                	<div class="pho_t">密码</div>
                    <div class="pho_inp"><input name="password" id="password" type="password" class="input"/></div>
                </li>
                 <li>
                	<div class="pho_t">验证码</div>
                    <div class="pho_inp"><input name="validateCode"  type="text" class="input_d"/></div>
                    <a class="button" onclick="sendCaptcha();" id="sendBtn" href="javascript:void(0);">获取验证码</a>
                </li>
            </ul>
            <div class="clear"></div>
        </div>
       </form>
        <div class="r_btn"><a onclick="saveRegister();" href="javascript:void(0);" >注册</a></div>
    </div><!--box-->

</body>

</html>