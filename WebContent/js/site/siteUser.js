//用户登录、注册、退出 功能
//弹出登录窗口,传入en参数值表示为英文
this.login=function(local){
	local=local?local:'';
	var title=local=='en_US'?'USER LOGIN':'用户登录';
	art.dialog.open('/siteUser/toLogin.action?local='+local,{
		title : title,
		width : '500px',
		height: '250px',
		lock:true,
		fixed:true,
		resize:false
	});
};

/**
 * 弹出注册窗口,传入en参数值表示为英文
 * identities 格式为数组，进行一个身份分类
 */
this.register=function(local){
	local=local?local:'';
	if(local.indexOf("en_US") != -1){
		title = "USER REGIST";
	}else{
		title = "用户注册";
	}
	art.dialog.open('/siteUser/toRegister.action?local='+local,{
		title : title,
		width : '500px',
		height: '400px',
		lock:true,
		fixed:true,
		resize:false
	});
};

this.editPwd=function(id,local){
	local=local?local:'';
	art.dialog.data("id", id);
	var title=local=='en_US'?'EDIT PASSWORD':'密码修改';
	art.dialog.open('/siteUser/toEditPwd.action?local='+local,{
		title : title,
		width : '500px',
		height: '300px',
		lock:true,
		fixed:true,
		resize:false
	});
};

//退出
this.logout=function(){
	window.location.href="/siteUser/logout.action";
};
