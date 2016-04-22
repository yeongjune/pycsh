<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<script type="text/javascript">
var mngFriendyLink;
$(function(){
	mngFriendyLink=new ManagerFriendyLink();
	mngFriendyLink.load();
	
	$("#chk_ids").click(function(){
		if($(this).attr("checked")){
			$("input[name='chk_friendlyLink_id']").attr('checked',true);
		}else{
			$("input[name='chk_friendlyLink_id']").attr('checked',false);
		}
	});
});

function ManagerFriendyLink(){
	this.load = function () {
		$.post('/friendlylink/list.action',{keyword:$("#keyword").val()},function(data){
			$('#tableBody').html('');
			if(data){
				for ( var i = 0; i < data.length; i++) {
					var item=data[i];
					$('#tableBody').append(
							'<tr id="tr_'+item.id+'">'+
							'	<td><input type="checkbox" name="chk_friendlyLink_id" value="'+item.id+'" /></td>'+
							'	<td>'+item.name+'</td>'+
							'	<td>'+(item.linkUrl?item.linkUrl:'')+'</td>'+
							'	<td>'+
							'		<a href="javascript:mngFriendyLink.edit('+item.id+');">修改</a>'+
							'		<a href="javascript:mngFriendyLink.del('+item.id+');">删除</a>'+
							'	</td>'+
							'</tr>'
					); 
				}
			}
		},'json');
	};
	this.create = function (){
		art.dialog.open('/friendlylink/toEdit.action',{
			title : '新增友情链接',
			width : '550px',
			height : '250px'
		});
	};
	this.del =function (id){
		art.dialog.confirm('确定删除吗？',function(){
			$.post('/friendlylink/delete.action',{ids:id},function(data){
				if(data=='succeed'){
					$('#tr_'+id).remove();
				}else{
					art.dialog.tips('删除失败');
				}
			});
		});
	};
	this.delMulti =function (){
		var ids=[];
		$("input[type='checkbox'][name='chk_friendlyLink_id']:checked").each(function(){
			ids.push($(this).val());
		});
		if(!ids || ids.length==0){
			art.dialog.tips("您尚未选择任何要删除的友情链接");
			return;
		}
		art.dialog.confirm("您确定要批量删除已<br/>选中的友情链接吗？", function(){
			$.post('/friendlylink/delete.action',{ids:ids.join(',')},function(data){
				if(data=='succeed'){
					for (var index in ids) {
						$('#tr_'+ids[index]).remove();
					}
				}else{
					art.dialog.tips('删除失败');
				}
			});
		});
	};
	this.edit = function (id){
		art.dialog.open('/friendlylink/toEdit.action?id='+id,{
			title : '修改友情链接',
			width : '500px',
			height : '250px'
		});
	};
}
</script>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">友情链接管理</legend>
		<div class="form_search_item" >
			<div class="left">
				<a href="javascript:mngFriendyLink.create()" class="base_btn"><span>新增</span></a>
				<a href="javascript:mngFriendyLink.delMulti()" class="base_btn" id="deleteMulti"><span>删除</span></a>
			</div>
			<div class="right">
				<input type="text" class="piece" id="keyword" onkeydown="if(event.keyCode==13){mngFriendyLink.load();}"/>
				<a href="javascript: mngFriendyLink.load()" class="base_btn"><span>搜索</span></a>
			</div>
		</div>
		<table  class="table_border">
			<tr class="head">
				<td style="width: 40px"><input type="checkbox" id="chk_ids"/></td>
				<td >名称</td>
				<td >链接地址</td>
				<td style="width: 150px">操作 </td>
			</tr>
			<tbody id="tableBody"></tbody>
		</table>
</fieldset>
</body>
</html>