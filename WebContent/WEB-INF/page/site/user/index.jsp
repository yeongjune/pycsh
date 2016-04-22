<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
</head>
<body>
	<fieldset class="fieldset_border">
		<legend class="legend_title">用户管理</legend>
			<div class="form_search_item" >
				<div class="left">
					<a href="javascript:userManager.createUser()" class="base_btn"><span>新建用户</span></a>
				</div>
				<div class="right">
					<input type="text" class="piece" id="keyword" onkeydown="if(event.keyCode==13){userManager.load();}"/>
					<a href="javascript: userManager.load()" class="base_btn"><span>搜索</span></a>
				</div>
			</div>
			<table  class="table_border">
				<tr class="head">
					<td width="100">启用</td>
					<td >ID</td>
					<td >帐号</td>
					<td >姓名</td>
					<td >修改时间</td>
					<td >操作 </td>
				</tr>
				<tbody id="tableBody"></tbody>
			</table>
			<div class="table_under_btn" >
				<div class="flip"></div>
			</div><!--table_under_btn-->
	</fieldset>
	<script type="text/javascript">
		function UserManager(siteId){
			this.siteId = siteId;
			this.load = function(){
				loadByPage('/user/list.action',{siteId: siteId, keyword:$('#keyword').val()},this.showList);
			};
			this.showList = function(list){
				var html = '';
				for ( var item in list) {
					var user = list[item];
					if(user){
						var userId = parseInt('${authority_user.id}');
						var disabled = user.id==userId?'disabled="disabled"':'';
						var checked = user.enable==1?'checked="checked"':'';
						html += (
								'<tr id="tr_'+user.id+'">'+
								'	<td><input '+disabled+' type="checkbox" id="cb_'+user.id+'" '+checked+' onclick="userManager.updateEnable('+user.id+')"/></td>'+
								'	<td>'+user.id+'</td>'+
								'	<td>'+user.account+'</td>'+
								'	<td>'+user.name+'</td>'+
								'	<td>'+user.updateTime+'</td>'+
								'	<td>'+
								(user.account=='admin'?'':'<a href="javascript:userManager.roleSet('+user.id+', \''+user.name+'\');">角色设置</a>')+
								'		<a href="javascript:userManager.editUserColumnRole('+user.id+', \''+user.name+'\');">栏目角色设置</a>'+
								'		<a href="javascript:userManager.editUser('+user.id+');">修改</a>'+
								'		<a href="javascript:userManager.deleteUser('+user.id+');">删除</a>'+
								(user.account=='admin'?'':'    <a href="javascript:userManager.resetPwd('+user.id+');">重置密码</a>')+
								'	</td>'+
								'</tr>'
						);
					}
				}
				return html;
			};
			this.createUser = function(){
				art.dialog.open('/user/add.action?siteId='+this.siteId, {
					width: 500,
					height: 200,
					title:'添加用户'
				});
			};
			this.deleteUser = function(id){
				art.dialog.confirm("确定删除吗？", function(){
					$.post('/user/delete.action',{id:id},function(data){
						if(data=='succeed'){
							$('#tr_'+id).remove();
						}
					});
				});
			};
			this.editUser = function(id){
				art.dialog.open('/user/edit.action?id='+id, {
					width: 500,
					height: 200,
					title:'修改用户'
				});
			};
			this.roleSet = function(id, name){
				art.dialog.open('/userRole/dialog.action?userId='+id, {
					width: 380,
					height: 450,
					title: name+' 角色设置'
				});
			};
			this.editUserColumnRole = function(id, name){
				art.dialog.open('/userColumnRole/dialog.action?userId='+id, {
					width: 380,
					height: 450,
					title: name+' 栏目角色设置'
				});
			};
			this.updateEnable = function(id){
				var status = $('#cb_'+id).attr('checked')=='checked'?1:0;
				$.post('/user/updateEnable.action', {siteId: siteId, id: id, status: status}, function(data){
					if(data=='succeed'){
						art.dialog.alert('设置成功');
					}else{
						art.dialog.alert('设置失败');
					}
				});
			};
			this.resetPwd = function(id){
				$.post("/user/resetPwd.action", {id: id}, function(data){
					if(data > 0){
						art.dialog("重置成功");
					}else{
						art.dialog("重置失败");
					}
				});
			};
		}
		var userManager = new UserManager('${siteId}');
		userManager.load();
	</script>
</body>
</html>