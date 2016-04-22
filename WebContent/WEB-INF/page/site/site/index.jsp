<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
</head>
<body>
	<fieldset class="fieldset_border">
		<legend class="legend_title">站点管理</legend>
			<div class="form_search_item" >
				<div class="left">
					<a href="javascript:siteManager.createSite()" class="base_btn"><span>新建站点</span></a>
				</div>
				<div class="right">
					<input type="text" class="piece" id="keyword" onkeydown="if(event.keyCode==13){siteManager.load();}"/>
					<a href="javascript: siteManager.load()" class="base_btn"><span>搜索</span></a>
				</div>
			</div>
			<table  class="table_border">
				<tr class="head">
					<td width="100">开启</td>
					<td >ID</td>
					<td >名称</td>
					<td >域名</td>
					<td >页面文件目录</td>
					<td >创建时间</td>
					<td >操作 </td>
				</tr>
				<tbody id="tableBody"></tbody>
			</table>
			<div class="table_under_btn" >
				<div class="flip"></div>
			</div><!--table_under_btn-->
	</fieldset>
	<script type="text/javascript">
		function SiteManager(){
			this.load = function(){
				loadByPage('/site/list.action',{keyword:$('#keyword').val()},this.showList);
			};
			this.showList = function(list){
				var html = '';
				for ( var item in list) {
					var site = list[item];
					if(site){
						var checked = site.open==1?'checked="checked"':'';
						var domain = site.domain.startWith('http://')?site.domain:'http://'+site.domain;
						html += (
								'<tr id="tr_'+site.id+'">'+
								'	<td><input type="checkbox" id="cb_'+site.id+'" '+checked+' onclick="siteManager.open('+site.id+')"/></td>'+
								'	<td>'+site.id+'</td>'+
								'	<td>'+site.name+'</td>'+
								'	<td><a target="_blank" href="'+domain+'">'+domain+'</a></td>'+
								'	<td>'+site.directory+'</td>'+
								'	<td>'+site.updateTime+'</td>'+
								'	<td>'+
								'		<a id="roleSet_'+site.id+'" href="javascript:siteManager.roleSet('+site.id+', \''+site.name+'\');">角色设置</a>'+
								'		<a href="javascript:siteManager.resetPassword('+site.id+');">重置密码</a>'+
								'		<a href="javascript:siteManager.siteManage('+site.id+');">网站管理</a>'+
								'		<a href="javascript:siteManager.editSite('+site.id+');">修改</a>'+
								'		<a href="javascript:siteManager.deleteSite('+site.id+');">删除</a>'+
								'	</td>'+
								'</tr>'
						);
					}
				}
				return html;
			};
			this.createSite = function(){
				art.dialog.open('/site/add.action', {
					width: 600,
					height: 240,
					title:'新建站点'
				});
			};
			this.deleteSite = function(id){
				art.dialog.confirm("确定删除吗？", function(){
					$.post('/site/delete.action',{id:id},function(data){
						if(data=='succeed'){
							$('#tr_'+id).remove();
						}
					});
				});
			};
			this.editSite = function(id){
				art.dialog.open('/site/edit.action?id='+id, {
					width: 600,
					height: 240,
					title:'修改站点'
				});
			};
			this.roleSet = function(id, name){
				art.dialog.open('/siteRole/dialog.action?siteId='+id, {
					width: 380,
					height: 450,
					title: name+' 角色设置'
				});
			};
			this.resetPassword = function(id){
				art.dialog.confirm("确定重置密码吗？", function(){
					$.post('/sys/resetPassword.action', {siteId:id}, function(data){
						if(data=='succeed'){
							art.dialog.alert('密码成功重置为“123456”');
						}
					});
				});
			};
			this.siteManage = function(id){
				art.dialog.confirm("确定进入网站管理吗？", function(){
					$.post('/sys/login.action', {siteId:id}, function(data){
						var result = $.parseJSON(data);
						if(result.status=='succeed'){
							window.location.href='/login/index.action';
						}else{
							art.dialog({
								title: '提示',
								icon: 'warning',
								content: result.message,
								close: function(){
									siteManager.flicker('roleSet_'+id);
								}
								});
						}
					});
				});
			};
			this.timeout = false;
			this.elementId = false;
			this.count = 0;
			this.flicker = function(elementId){
				if(this.timeout){
					window.clearTimeout(this.timeout);
				}
				this.elementId = elementId;
				this.count = 10;
				this.timeout = window.setTimeout(siteManager.addOrRemoveClass, 500);
			};
			this.addOrRemoveClass = function(){
				if(siteManager.count%2==0){
					$('#'+siteManager.elementId).css('color', 'red');
				}else{
					$('#'+siteManager.elementId).css('color', '');
				}
				siteManager.count--;
				if(siteManager.count>0)siteManager.timeout = window.setTimeout(siteManager.addOrRemoveClass, 300);
			};
			this.open = function(id){
				var status = $('#cb_'+id).attr('checked')=='checked'?1:0;
				$.post('/site/updateOpen.action', {id: id, status: status}, function(data){
					if(data=='succeed'){
						art.dialog.alert('设置成功');
					}else{
						art.dialog.alert('设置失败');
					}
				});
			};
		}
		var siteManager = new SiteManager();
		siteManager.load();
	</script>
</body>
</html>