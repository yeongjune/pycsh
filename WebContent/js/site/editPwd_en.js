$(function(){
	$(".msgBoxContent").on("blur", "input[type='password']", function(){
		var this_e = $(this);
		if(this_e.val()){
			this_e.next().text("");
		}else {
			this_e.next().text("this option is empty");
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
			oPassword.next().text("original password empty");
			flag = false;
		}
		if(passwordVal){
			password.next().text("");
		}else{
			password.next().text("new password empty");
			flag = false;
		}
		if(rePasswordVal){
			rePassword.next().text("");
		}else{
			rePassword.next().text("repetive password empty");
			flag = false;
		}
		
		if(flag){
			$.post("/siteUser/editPwd.action", {id:id, oPassword:hex_md5(oPasswordVal), password:hex_md5(passwordVal)}, function(data){
				if(data == 1){
					art.dialog('update password success！');
				}else if(data == 0){
					art.dialog('original password is wrong！');
				}else{
					art.dialog('update fail, please contact the administrator！');
				}
			});
		}
	}
};