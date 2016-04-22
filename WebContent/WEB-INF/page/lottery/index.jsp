<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>登陆</title>
<%
    //（1）做开发时，可去掉下面注释！以便清理缓存！
    //（2）项目完成时，必须把下面内容注释起来！(否则ie6下出现网页过期)
    request.getSession().getServletContext().setAttribute("css", "");
	//request.getSession().getServletContext().setAttribute("css", "");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	response.flushBuffer();
	request.setAttribute("ctx", request.getContextPath());
%>

<!-- css import -->
<link href="${css }/skins/lottery/css/base.css" rel="stylesheet" type="text/css" />
<link href="${css }/skins/lottery/css/login.css" rel="stylesheet" type="text/css" />

<!-- jquery 支持-->
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>

<!-- png透明 -->
<script type="text/javascript" src="/plugin/iepngfix_tilebg.js"></script>

<!-- cookie 操作 -->
<script type="text/javascript" src="/plugin/jquery.cookie.js"></script>
<script type="text/javascript" src="/js/base/md5.min.js"></script>
<!-- 弹出框引入 -->
<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>

<script type="text/javascript" src="/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript" src="/js/base/util.js"></script>
<script type="text/javascript" src="/js/base/PagedQuery.js"></script>

<script type="text/javascript" src="/plugin/ztree3.5.14/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="/plugin/ztree3.5.14/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript" src="/plugin/ztree3.5.14/jquery.ztree.exedit-3.5.min.js"></script>

<script>
	// 默认弹出框锁屏
	artDialog.defaults.lock = true;
	artDialog.defaults.fixed = true;
	artDialog.defaults.resize = false;
</script>

<script type="text/javascript">
		var fail_count = parseInt("${fail_count}");
		if(!fail_count) fail_count = 5;
		function login(){
			var account = $('#account').val();
			var password = $('#password').val();
			var captcha = $('#captcha').val();
			var remember_me = $('#remember_me').attr('checked');
			if(account && account.trim()!='' && password && password.trim()!=''){
				$.post('/login/login.action',{account:account, password:hex_md5(password), writeCookie: remember_me=='checked'?'1':'0'}, function(data){
					var result = data;
					if(result.status=='succeed'){//登陆成功，跳转到摇号系统首页
						window.location.href='/lottery/index.action';
					}else{
						$('#Prompt').text(result.message);
						fail_count = parseInt(result.failCount);
						showHideCaptchaDiv();
					}
				}, 'JSON');
			}else{
				$('#Prompt').text('请输入帐号、密码');
			}
		}
		function endInputId(){
			var account = $('#account').val();
			if(account && account.trim()!=''){
				$('#password').focus();
			}
		}
		
		var weeks = ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'];
		
		function task(){
			var time = new Date();
			var year = time.getFullYear();
			var month = time.getMonth() + 1;
			var date = time.getDate();
			
			var weekDay = time.getDay();
			var hour = time.getHours();
			var minute = time.getMinutes();
			var second = time.getSeconds();
			
			if(minute < 10){
				minute = "0" + minute;
			}
			if(second < 10){
				second = "0" + second;
			}
			
			var dateStr = year + '年' + month + '月' + date + '日';
			var timeStr = weeks[weekDay] + ' ' + hour + ':' + minute + ':' + second;
			
			$('#date').html(dateStr);
			$('#time').html(timeStr);
		}
		window.setInterval("task()", 1000); 
		
	</script>
</head>
<body>

<div class="login_head">
<div class="logo"><img src="${css }/skins/lottery/images/login.png" /></div>
<div class="time">今天是  <span id="date">2015年1月1日</span>  <span id="time">星期日  0:00:00</span></div>
</div>
<div class="login">
<form>
        <div class="input">
        	<label class="iconfont"></label>
            <input name="TPL_username" id="account" onkeypress="if(event.keyCode==13){endInputId();}" class="login-text" maxlength="32" tabindex="1" type="text"/>
            <span class="input_d_t" id="a_tip">请输入您的用户名</span>            	
        </div>
		<div class="input">
				<label class="iconfont mm"></label>
				<input name="TPL_password" type="password" id="password" onkeypress="if(event.keyCode==13){login();}" class="login-text"/>
                <span class="input_d_t" id="p_tip">请输入您的密码</span>
		</div>			
		<div class="pass">
				<input class="checkbox_input" id="remember_me" type="checkbox"/><label for="remember_me">&nbsp;&nbsp;记住密码</label>
		        <!-- <a href="#" target="_blank">忘记密码?</a> -->
     	</div>     	    		
        <div class="submit">
        	<div id="Prompt" style="text-align: center;margin: 5px;color: red;"></div>
        	<input type="button" class="button_input" id="btn" onclick="login()" value="登 录" />
        </div>
        
        
    </form>
    <!-- <div class="login_txt"><a href="/lottery/student/toCheck.action">结果查询>></a></div> -->
</div>
<div class="footer">copyrignt 2009-2015 广州市睿驰计算机有限公司 技术支持</div>




<!-- <fieldset class="fieldset_border" style="min-height: 380px;">
	<legend class="legend_title">摇号系统</legend>
		<div style="margin-left: 252px;">
		<div >
			<div style="width: 99.7%;text-align: center;">
				<div style=" margin: 8px 0 12px 0;text-align: center;clear: both;">
					<span style="text-align: right;width: 140px;line-height: 22px;margin-right: 5px;">用户名 </span>
					<input type="text" id="account" value="" onkeypress="if(event.keyCode==13){endInputId();}" class="inputBox">
				</div>
				<div style=" margin: 8px 0 12px 0;text-align: center;clear: both;">
					<span style="text-align: center;width: 140px;line-height: 22px;margin-right: 5px;">密&nbsp;码</span>
					<input type="password" id="password" value="" onkeypress="if(event.keyCode==13){login();}" class="inputBox">
				</div>
				<div id="captcha_div" style=" margin: 8px 0 12px 0;text-align: center;clear: both;">
                	<span  style="text-align: center;width: 140px;line-height: 22px;margin-right: 5px;">验证码 </td>
                    <input type="text" id="captcha" onkeypress="if(event.keyCode==13){login();}" class="inputBox" />
                    <img src="/validCode.jpg" title="看不清，点击刷新" onclick="reloadValidCode(this)"/>
                </div>
				<div style=" margin: 8px 0 12px 0;text-align: center;clear: both;">
					<input type="button" value="登  陆" id="btn" class="btn" onclick="login()">
                    <div class="ForgetPW">
                    &nbsp;&nbsp;<input type="checkbox" id="remember_me" style="position: relative; top: 3px; margin: 0;" name="remember_me">
                    <label for="remember_me">记住密码</label>
                    </div>
				</div>
			</div>
		</div>
		<div class="clear"></div>
</fieldset> -->
<script type="text/javascript">
		function showHideCaptchaDiv(){
			if(fail_count<5){
				$('#captcha_div').hide();
			}else{
				$('#captcha_div').show();
			}
		} 
		showHideCaptchaDiv();
		
		$(function(){
			var account = $('#account').val().trim();
			var password = $('#password').val().trim();
			if( account != '' && password != '' ){
				$('#btn').trigger('click');
			}
		});
		
		$('.input_d_t').click(function(){
			$(this).prev('input').focus();
		});
		
		$('input').each(function(i){
			if($(this).attr('type') == 'text' || $(this).attr('type') == 'password'){
				$(this).focus(function(){
					$(this).next('.input_d_t').hide();
				});
				$(this).blur(function(){
					if($(this).val() == ''){
						$(this).next('.input_d_t').show();
					}
				});
			}
		});
		
	</script>
</body>
</html>