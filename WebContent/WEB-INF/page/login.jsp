<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录</title>
	<link rel="stylesheet" type="text/css" href="/skins/login/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/skins/login/css/login.css" />
	<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/js/base/util.js"></script>
	<script type="text/javascript" src="/js/base/md5.min.js"></script>
	<script type="text/javascript">
		var fail_count = parseInt("${fail_count}");
		function login(){
			var account = $('#account').val();
			var password = $('#password').val();
			var captcha = $('#captcha').val();
			var remember_me = $('#remember_me').attr('checked');
			if(account && account.trim()!='' && password && password.trim()!=''){
				$.post('/login/login.action',{account:account, password:hex_md5(password), captcha: captcha, writeCookie: remember_me=='checked'?'1':'0'}, function(data){
					var result = $.parseJSON(data);
					if(result.status=='succeed'){
						window.location.href='/login/index.action';
					}else{
						$('#Prompt').text(result.message);
						fail_count = parseInt(result.failCount);
						showHideCaptchaDiv();
					}
				});
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
	</script>
</head>
<body>
        <div class="all">
            <!--logo图-->
            <div class="logo">
                <img src="/skins/login/image/logo.png" />
            </div>
            <div class="main_Extend">
                <div class="main">
                    <div class="info">
                        <div class="DividingLine">
	                        <div class="title">
	                            <h1>
	                            <c:choose>
	                            	<c:when test="${empty sessionScope.site}">睿驰建站系统管理后台</c:when>
	                            	<c:otherwise>${sessionScope.site.name}网站后台</c:otherwise>
	                            </c:choose>
	                            </h1>
	                        </div>
                        </div>
	                    <p id="Prompt" class="Prompt" ></p>
                        <table>
                            <tr>
                                <td class="table_title">用户名 </td>
                                <td>
                                    <input type="text" id="account" value="${page_account }" onkeypress="if(event.keyCode==13){endInputId();}" class="inputBox" /></td>
                            </tr>
                            <tr>
                                <td class="table_title">密&nbsp;&nbsp;码 </td>
                                <td>
                                    <input type="password" id="password" value="${page_password }" onkeypress="if(event.keyCode==13){login();}" class="inputBox" /></td>
                            </tr>
                            <tr id="captcha_div" style="display: none;">
                                <td class="table_title">验证码 </td>
                                <td>
                                    <input type="text" id="captcha" class="inputBox_small" onkeypress="if(event.keyCode==13){login();}"/><img src="/validCode.jpg" class="Captcha" title="看不清，点击刷新" onclick="reloadValidCode(this)"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="table_title"></td>
                                <td>
                                    <input type="button" value="登  录" id="btn" class="btn" onclick="login()"/>
                                    <div  class="ForgetPW">
                                    &nbsp;&nbsp;<input type="checkbox" id="remember_me" style="position: relative; top: 3px; margin: 0;" name="remember_me" />
                                    <label for="remember_me">记住密码</label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>

                </div>
            </div>
            <div class="foot">copyrignt 2009-2013 广州睿驰计算机有限公司 技术支持</div>
        </div>
	<script type="text/javascript">
		function showHideCaptchaDiv(){
			if(fail_count<5){
				$('#captcha_div').hide();
			}else{
				$('#captcha_div').show();
			}
		}
		showHideCaptchaDiv();
		$('#account').focus();
		
		$(function(){
			var account = $('#account').val().trim();
			var password = $('#password').val().trim();
			if( account != '' && password != '' ){
				$('#btn').trigger('click');
			}
		});
	</script>
</body>
</html>