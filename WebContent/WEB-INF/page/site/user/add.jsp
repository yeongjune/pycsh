<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>title</title>
<%@include file="/common/taglibs.jsp" %>
</head>
<body>
	<fieldset class="fieldset_border">
		<form action="">
			<div class="form_item">
				<span class="form_span">帐号：</span>
				<input type="text" id="account" class="piece" onblur="userAdd.checkAccount()"/><font color="red" id="account_tip"></font>
			</div>
			<div class="form_item">
				<span class="form_span">姓名：</span>
				<input type="text" id="name" class="piece"/><font color="red" id="name_tip"></font>
			</div>
			<div class="form_submit">
				<a href="javascript:userAdd.save()" class="base_btn" id="submitButton"><span>提交</span></a>
			</div>
			<div class="clear"></div>
		</form>
	</fieldset>

	<script type="text/javascript">
		function UserAdd(siteId){
			this.siteId = siteId;
			this.allowSubmit = false;
			this.save = function(){
				var name = $('#name').val();
				var account = $('#account').val();
				this.checkAccount();
				if(this.allowSubmit && name && name.trim()!=''){
					lockWindow();
					$.post('/user/save.action', {siteId: this.siteId, name: name, account: account}, function(data){
						openLock();
						if(data=='succeed'){
							art.dialog.opener.userManager.load();
							art.dialog.close();
						}else{
							alert('保存失败');
						}
					});
				}else{
					if(name.trim()!=''){
						$('#name_tip').text('');
					}else{
						$('#name_tip').text('姓名不能为空');
					}
				}
			};
			this.checkAccount = function(){
				var account = $('#account').val();
				if(account && account.trim()!=''){
					$.ajax({
						url:'/user/accountIsExist.action',
						data:{siteId: siteId, account: account},
						async:false,
						success:function(data, textStatus){
							if(data=='false'){
								userAdd.allowSubmit = true;
								$('#account_tip').text('');
							}else{
								userAdd.allowSubmit = false;
								if(data=='true'){
									$('#account_tip').text('帐号已经存在');
								}else{
									$('#account_tip').text('');
								}
							}
						}
					});
				}else{
					userAdd.allowSubmit = false;
					$('#account_tip').text('帐号不能为空');
				}
			};
		}
		var userAdd = new UserAdd('${siteId}');
	</script>
</body>
</html>