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
			<div class="view_rank">
				<span class="view_rank_span">ID：</span>${id }
			</div>
			<div class="view_rank">
				<span class="view_rank_span">帐号：</span><font id="account"></font>
			</div>
			<div class="form_item">
				<span class="form_span">名称：</span>
				<input type="text" id="name" class="piece"/><font color="red" id="name_tip"></font>
			</div>
			<div class="form_submit">
				<a href="javascript:userUpdate.update()" class="base_btn"><span>提交</span></a>
			</div>
			<div class="clear"></div>
		</form>
	</fieldset>

	<script type="text/javascript">
		function UserUpdate(id){
			this.id = id;
			this.allowSubmit = false;
			this.load = function(){
				$.post('/user/load.action',{id:this.id},function(data){
					var user = $.parseJSON(data);
					$('#name').val(user.name);
					$('#account').text(user.account);
				});
			};
			this.update = function(){
				var name = $('#name').val();
				if(name && name.trim()!=''){
					lockWindow();
					$.post('/user/update.action', {id: this.id, name: name}, function(data){
						openLock();
						if(data=='succeed'){
							art.dialog.opener.userManager.load();
							art.dialog.close();
						}
					});
				}else{
					if(name.trim()!=''){
						$('#name_tip').text('');
					}else{
						$('#name_tip').text('名称不能为空');
					}
				}
			};
		}
		var userUpdate = new UserUpdate('${id}');
		userUpdate.load();
	</script>
</body>
</html>