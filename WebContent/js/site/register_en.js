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
		art.dialog.opener.login('en_US');
		art.dialog.close();
	});
});
function ManagerRgister(){
	//注册
	this.register=function(){
		if(mngRgister.checkField()){
			$.post('/siteUser/doRegister.action',{local:'en_US',acount:$("#acount").val(),password:hex_md5($("#password").val()),email:$("#email").val(),identity:$("#identity").val(),department:$("#department").val()},function(data){
				if(data.code=="succeed"){
					art.dialog.alert('SUCCEED TO REGIST,GOOD LUCKY FOR YOU,YOUR ACCOUNT IS：'+$("#acount").val(),function(){
						art.dialog.opener.login('en_US');
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
			acount.next().text('INPUT ACCOUNT PLEASE');
			acount.focus();
			pass=false;
		}else{
			acount.next().text('');
		}
		if (!password.val()) {
			password.next().text('INPUT PASSWORE PLEASE');
			if(pass){
				password.focus();
				pass=false;
			}
		}else{
			password.next().text('');
		}
		if (!confirmPassword.val()) {
			confirmPassword.next().text('INPUT PASSWORD AGAIN');
			if(pass){
				confirmPassword.focus();
				pass=false;
			}
		}else{
			confirmPassword.next().text('');
		}
		if(confirmPassword.val()&&password.val()!=confirmPassword.val()){
			confirmPassword.next().text('PASSWORD NOT MATCH');
			if(pass){
				confirmPassword.focus();
				pass=false;
			}
		}
		if(email.val()){
			var reg = new RegExp(".+@.+\\..+");
			if(!reg.test(email.val())){
				email.next().text('E-MAIL FORMAT ERROR');
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