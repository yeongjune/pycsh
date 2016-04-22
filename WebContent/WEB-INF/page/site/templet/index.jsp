<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
</head>
<body>
	<input id="siteId" type="hidden" value="${siteId }"/>
	<input id="siteName" type="hidden" value="${siteName }"/>
	<fieldset class="fieldset_border">
		<legend class="legend_title">模板管理</legend>
			<div class="form_search_item" >
				<div class="left">
					<a href="javascript:templateManager.createTemplate()" class="base_btn"><span>新建模板</span></a>
				</div>
				<div class="right">
					<input type="text" class="piece" id="keyword" onkeydown="if(event.keyCode==13){templateManager.load();}"/>
					<a href="javascript: templateManager.load()" class="base_btn"><span>搜索</span></a>
				</div>
			</div>
			<table  class="table_border">
				<tr class="head">
					<td >ID</td>
					<td >名称</td>
					<td >操作 </td>
				</tr>
				<tbody id="tableBody"></tbody>
			</table>
			<div class="table_under_btn" >
				<div class="flip"></div>
			</div><!--table_under_btn-->
	</fieldset>
	<script type="text/javascript">
		function TemplateManager(siteId){
			this.siteId = siteId;
			this.load = function(){
				loadByPage('/templet/list.action',{siteId: this.siteId, keyword:$('#keyword').val()},this.showList);
			};
			this.showList = function(list){
				$('#tableBody').html('');
				for ( var item in list) {
					var template = list[item];
					if(template){
						$('#tableBody').append(
								'<tr id="tr_'+template.id+'">'+
								'	<td>'+template.id+'</td>'+
								'	<td>'+template.name+'</td>'+
								'	<td>'+
								'		<a href="javascript:templateManager.selectData(\''+ template.id +'\');">装配数据</a>'+
								'		<a href="javascript:templateManager.deleteTemplate(\''+template.id+'\');">删除</a>'+
								'	</td>'+
								'</tr>'
						);
					}
				}
			};
			this.createTemplate = function(){
				if(this.siteId>0){
					art.dialog.open('/templet/add.action?siteId='+this.siteId, {
						width: 500,
						height: 200,
						title:'添加模版'
					});
				}else{
					art.dialog.alert('你不是网站管理员，不能添加模板');
				}
			};
			this.deleteTemplate = function(id){
				art.dialog.confirm("确定删除吗？", function(){
					$.post('/templet/delete.action',{id:id},function(data){
						if(data=='succeed'){
							$('#tr_'+id).remove();
						}
					});
				});
			};
			this.editTemplate = function(id){
				art.dialog.open('/templet/edit.action?id='+id, {
					width: 500,
					height: 200,
					title:'修改模版'
				});
			};
			this.selectData = function(id){
				art.dialog.open("/templet/selectData.action?id=" + id + "&siteId=${siteId}", {
					width: 350,
					height: 300,
					title: '装配数据'
				});
			};
		}
		var templateManager = new TemplateManager('${siteId}');
		templateManager.load();
	</script>
</body>
</html>