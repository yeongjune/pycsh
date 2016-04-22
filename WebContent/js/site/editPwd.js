$(function(){
	$(".msgBoxContent").on("blur", "input[type='password']", function(){
		var this_e = $(this);
		if(this_e.val()){
			this_e.next().text("");
		}else {
			this_e.next().text("密码不能为空");
		}
	});
	
	var id = art.dialog.data("id");
	$("#editBtn").on("click", function(){
		editPwd.edit(Number(id));
	});
});

var editPwd = {
		
		
	edit : function(id){
		var flag = true;
		var oPassword = $("#oPassword");
		var password = $("#password");
		var rePassword = $("#rePassword");
		var oPasswordVal = oPassword.val();
		var passwordVal = password.val();
		var rePasswordVal = rePassword.val();
		//非空检测
		if(oPasswordVal){
			oPassword.next().text("");
		}else{
			oPassword.next().text("请输入原始密码");
			flag = false;
		}
		if(passwordVal){
			password.next().text("");
		}else{
			password.next().text("请输入新密码");
			flag = false;
		}
		if(rePasswordVal){
			rePassword.next().text("");
		}else{
			rePassword.next().text("请输入确认密码");
			flag = false;
		}
		
		if(flag){
			$.post("/siteUser/editPwd.action", {id:id, oPassword:hex_md5(oPasswordVal), password:hex_md5(passwordVal)}, function(data){
				if(data == 1){
					art.dialog('密码修改成功！');
				}else if(data == 0){
					art.dialog('原始密码输入错误！');
				}else{
					art.dialog('密码修改失败，请联系管理员！');
				}
			});
		}
	}
};