<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<script type="text/javascript">

var mngContact;
$(function(){
	mngContact=new ManagerContact();
	mngContact.load();
});

function ManagerContact(){
	this.load = function () {
		$.post('/contact/list.action',function(data){
			$('#tableBody').html('');
			if(data){
				for ( var i = 0; i < data.length; i++) {
					var item=data[i];
					$('#tableBody').append(
							'<tr id="tr_'+item.id+'">'+
							'	<td>'+item.type+'</td>'+
							'	<td>'+item.title+'</td>'+
							'	<td>'+( item.type=='二维码'? ('<img src="'+item.typeValue+'" style="width:50px;height:50px;" />'):item.typeValue)+'</td>'+
							'	<td>'+
							'		<a href="javascript:mngContact.edit('+item.id+');">修改</a>'+
							'		<a href="javascript:mngContact.del('+item.id+');">删除</a>'+
							'		<a href="javascript:mngContact.changeOrder('+item.id+',-1);" title="上移">↑</a>'+
							'		<a href="javascript:mngContact.changeOrder('+item.id+',1);" title="下移">↓</a>'+
							'	</td>'+
							'</tr>'
					); 
				}
			}
		},'json');
	};
	this.create = function (){
		art.dialog.open('/contact/toEdit.action',{
			title : '新增联系方式',
			width : '550px',
			height : '250px'
		});
	};
	this.del =function (id){
		art.dialog.confirm('确定删除吗？',function(){
			$.post('/contact/delete.action',{id:id},function(data){
				if(data=='succeed'){
					$('#tr_'+id).remove();
				}else{
					art.dialog.tips('删除失败');
				}
			});
		});
	};
	
	this.edit = function (id){
		art.dialog.open('/contact/toEdit.action?id='+id,{
			title : '修改联系方式',
			width : '500px',
			height : '250px'
		});
	};
	//修改排序
	this.changeOrder=function (id,upOrdown){
		$.post('/contact/changeOrder.action',{id:id,upOrdown:upOrdown},function(data){
			if(data=="succeed"){
				mngContact.load();
			}else{
				art.dialog.tips('操作失败');
			}
		});
	};
}
</script>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">联系方式管理</legend>
		<div class="form_search_item" >
			<div class="left">
				<a href="javascript:mngContact.create()" class="base_btn"><span>新增</span></a>
			</div>
		</div>
		<table  class="table_border">
			<tr class="head">
				<td >联系方式</td>
				<td >显示标题</td>
				<td >联系</td>
				<td style="width: 150px">操作 </td>
			</tr>
			<tbody id="tableBody"></tbody>
		</table>
</fieldset>
</body>
</html>