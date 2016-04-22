<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>title</title>
<%@include file="/common/taglibs.jsp" %>
<script type="text/javascript" src="/js/base/md5.min.js"></script>
</head>
<body>
	<fieldset class="fieldset_border">
		<form action="">
			<div class="form_item">
				<span class="form_span">原密码：</span>
				<input type="password" id="password" class="piece" onblur="editPassword.checkPassword()"/><font color="red" id="password_tip"></font>
			</div>
			<div class="form_item">
				<span class="form_span">新密码：</span>
				<input type="password" id="newPassword" class="piece"/>
			</div>
			<div class="form_item">
				<span class="form_span">确认新密码：</span>
				<input type="password" id="confirmPassword" class="piece" onblur="editPassword.checkNewPassword()"/><font color="red" id="newPassword_tip"></font>
			</div>
			<div class="form_submit">
				<a href="javascript:editPassword.save()" class="base_btn" id="submitButton"><span>提交</span></a>
			</div>
			<div class="clear"></div>
		</form>
	</fieldset>

	<script type="text/javascript">
		function EditPassword(password){
			this.password = password;
			this.allowSubmit = false;
			this.allowSubmit2 = false;
			this.save = function(){
				var password = $('#password').val();
				var newPassword = $('#newPassword').val();
				this.checkPassword();
				this.checkNewPassword();
				if(this.allowSubmit && this.allowSubmit2){
					lockWindow();
					$.post('/sys/updatePassword.action', {password: hex_md5(password), newPassword: hex_md5(newPassword)}, function(data){
						openLock();
						if(data=='succeed'){
							art.dialog.close();
							art.dialog.alert('密码修改成功');
						}else{
							art.dialog.alert('密码修改失败');
						}
					});
				}
			};
			this.checkPassword = function(){
				var password = $('#password').val();
				password = hex_md5(password);
				if(password && password.trim()!=''){
					if(this.password==password){
						editPassword.allowSubmit = true;
						$('#password_tip').text('');
					}else{
						editPassword.allowSubmit = false;
						$('#password_tip').text('原密码不正确');
					}
				}else{
					editPassword.allowSubmit = false;
					$('#password_tip').text('需要输入原密码');
				}
			};
			this.checkNewPassword = function(){
				var newPassword = $('#newPassword').val();
				var confirmPassword = $('#confirmPassword').val();
				if(newPassword && newPassword.trim()!=''){
					if(newPassword==confirmPassword){
						editPassword.allowSubmit2 = true;
						$('#newPassword_tip').text('');
					}else{
						editPassword.allowSubmit2 = false;
						$('#newPassword_tip').text('两次输入新密码不一致');
					}
				}else{
					editPassword.allowSubmit2 = false;
					$('#newPassword_tip').text('输入新密码');
				}
			};
		}
		var editPassword = new EditPassword('${authority_user.password}');
	</script>
</body>
</html>