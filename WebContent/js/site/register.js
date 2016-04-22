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
	$("#loginBtn").click(function(){
		art.dialog.opener.login();
		art.dialog.close();
	});
});
function ManagerRgister(){
	//注册
	this.register=function(){
		if(mngRgister.checkField()){
			$.post('/siteUser/doRegister.action',{acount:$("#acount").val(),password:hex_md5($("#password").val()),email:$("#email").val(),identity:$("#identity").val(),department:$("#department").val()},function(data){
				if(data.code=="succeed"){
					art.dialog.alert('恭喜你，注册成功！您的登录帐号为：'+$("#acount").val(),function(){
						art.dialog.opener.login();
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