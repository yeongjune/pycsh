<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>title</title>
<%@include file="/common/taglibs.jsp" %>
<script type="text/javascript"	src="/js/base/md5.min.js"></script>
</head>
<body>
	<fieldset class="fieldset_border">
		<form action="">
			<div class="form_item">
				<span class="form_span">帐号：</span>
				<input type="text" id="acount" class="piece" name="acount"/>
				<span style="color:red">*</span>
			</div>
			<div class="form_item">
				<span class="form_span">密码：</span>
				<input type="password" id="password" class="piece" name="password"/>
				<span style="color:red">*</span>
			</div>
			<div class="form_item">
				<span class="form_span">确认密码：</span>
				<input type="password" id="confirmPassword" class="piece" name="confirmPassword"/>
				<span style="color:red">*</span>
			</div>
			<div class="form_item">
				<span class="form_span">邮箱：</span>
				<input type="text" id="email" name="email" class="piece"/>
				<span style="color:red"></span>
			</div>
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
			<div class="form_submit">
				<a href="javascript:void(0)" class="base_btn" id="registerBtn"><span>注册</span></a>
			</div>
			<div class="clear"></div>
		</form>
	</fieldset>

	<script type="text/javascript">
	var mngRgister;
	$(function(){
		mngRgister=new ManagerRgister();
		
		$("#imgChange").click(function(){
			$(this).attr("src","");
			$(this).attr("src","/validCode.jpg?id="+Math.random()*1000);
		});
		
		$("#registerBtn").click(function(){
			mngRgister.register();
		});
	});
	function ManagerRgister(){
		//注册
		this.register=function(){
			if(mngRgister.checkField()){
				$.post('/siteUser/doRegister.action',{acount:$("#acount").val(),password:hex_md5($("#password").val()),email:$("#email").val(),identity:$("#identity").val(),department:$("#department").val()},function(data){
					if(data.code=="succeed"){
						art.dialog.alert('恭喜你，注册成功！您的登录帐号为：'+$("#acount").val(),function(){
							art.dialog.close();
						});
					}else{
						art.dialog.tips(data.msg);
					}
				},'json');
			}
		};
		//验证表单
		this.checkField=function(){
			var acount=$("#acount");
			var password=$("#password");
			var confirmPassword=$("#confirmPassword");
			var email=$("#email");
			var pass=true;
			if (!acount.val()) {
				acount.next().text('帐号不能为空');
				acount.focus();
				pass=false;
			}else{
				acount.next().text('');
			}
			if (!password.val()) {
				password.next().text('密码不能为空');
				if(pass){
					password.focus();
					pass=false;
				}
			}else{
				password.next().text('');
			}
			if (!confirmPassword.val()) {
				confirmPassword.next().text('请输入确认密码');
				if(pass){
					confirmPassword.focus();
					pass=false;
				}
			}else{
				confirmPassword.next().text('');
			}
			if(confirmPassword.val()&&password.val()!=confirmPassword.val()){
				confirmPassword.next().text('密码不一致');
				if(pass){
					confirmPassword.focus();
					pass=false;
				}
			}
			if(email.val()){
				var reg = new RegExp(".+@.+\\..+");
				if(!reg.test(email.val())){
					email.next().text('邮箱格式不正确');
					if(pass){
						email.focus();
						pass=false;
					}
				}else{
					email.next().text('');
				}
			}
			return pass;
		};
	}
	</script>
</body>
</html>