var siteUserLogin;
$(function(){
	siteUserLogin=new SiteUserLogin();
	$("#acount").blur(function(){
		var tips=$(this).next();
		if($(this).val()){
			tips.text("");
		}else{
			tips.text('INPUT ACCOUNT PLEASE');
		}
	});
	$("#password").blur(function(){
		var tips=$(this).next();
		if($(this).val()){
			tips.text("");
		}else{
			tips.text('INPUT PASSWORD PLEASE');
		}
	});
	$("#imgChange").click(function(){
		$(this).attr("src","");
		$(this).attr("src","/validCode.jpg?id="+Math.random()*1000);
	});
	$("#loginBtn").click(siteUserLogin.login);
	$("#registerBtn").click(siteUserLogin.register);
	$("#loginForm").submit(siteUserLogin.login);
});

function SiteUserLogin(){
	this.times=0;
	this.register = function (){
		art.dialog.opener.register('en_US');
		art.dialog.close();
	};
	this.login = function (){
		var acount=$("#acount").val();
		var password=$("#password").val();
		var validCode=$("#validCode").val();
		var pass=true;
		if(acount){
			$("#acount").next().text("");
		}else{
			$("#acount").next().text("INPUT ACCOUNT PLEASE");
			pass=false;
		}
		if(password){
			$("#password").next().text("");
		}else{
			$("#password").next().text("INPUT PASSWORD PLEASE");
			pass=false;
		}
		if(siteUserLogin.times>3){
			if(validCode){
				$("#validError").text("");
			}else{
				$("#validError").text("INPUT PASSOWRD PLEASE");
				pass=false;
			}
		}
		if(pass){
			$.post('/siteUser/doLogin.action',{local:'en_US',acount:acount,password:hex_md5(password),times:siteUserLogin.times,validCode:validCode},function(data){
				if(data.code=='succeed'){
					var tempUrl=$("#url").val();
					if(tempUrl){
						window.parent.location.href=tempUrl;
					}else{
						window.parent.location.reload();
					}
				}else{//errorCode:0登录失败，1帐号非空，2密码非空，3登录成功，4用户名不存在，5，密码错误,6验证码错误
					if(data.errorCode=="1"){
						$("#acount").next().text(data.msg);
						$("#acount").focus();
					}else if (data.errorCode=="2"||data.errorCode=="5"){
						$("#password").next().text(data.msg);
						$("#password").focus();
					}else if (data.errorCode=="6"){
						$("#validError").text(data.msg);
						$("#validCode").focus();
						$("#imgChange").click();
					}else{
						$("#acount").next().text(data.msg);
						$("#acount").focus();
					}
					siteUserLogin.times++;
					if(siteUserLogin.times>3){
						$("#div_validCode").show();
						$("#validCode").val('');
					}
				}
			},'json');
		}
		return false;
	};
}