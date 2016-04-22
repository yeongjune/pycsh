<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<script type="text/javascript">
var mngMessage;
$(function(){
	mngMessage=new ManagerMessage();
	mngMessage.load(1);
	$("#chk_ids").click(function(){
		if($(this).attr("checked")){
			$("input[name='chk_message_id']").attr('checked',true);
		}else{
			$("input[name='chk_message_id']").attr('checked',false);
		}
	});
});

function ManagerMessage(){
	this.load = function () {
		loadByPage('/message/list.action',{keyword:$('#keyword').val()},this.showList);
	};
	this.showList=function(list){
		var appStr='';
		for ( var key in list) {
			var item=list[key];
			appStr +='<tr id="tr_'+item.id+'">'+
					'	<td><input type="checkbox" name="chk_message_id" value="'+item.id+'" /></td>'+
					'	<td>'+(item.type==0?item.name:'匿名')+'</td>'+
					'	<td>'+(item.email?item.email:'')+'</td>'+
					'	<td>'+(item.phone?item.phone:'')+'</td>'+
					'	<td>'+(item.address?item.address:'')+'</td>'+
					'	<td width="100px">'+(item.reply?"已回复":"未回复")+'</td>'+
					'	<td width="100px">'+
					'		<a href="javascript:mngMessage.history(\''
							+ item.name
							+ '\',\''
							+ item.createTime
							+ '\','
							+ item.siteId
							+ ',' 
							+ item.id
							+ ');">历史</a>' +
					'		<a href="javascript:mngMessage.checkAndReply('+item.id+');">回复</a>'+
					'		<a href="javascript:mngMessage.del('+item.id+');">删除</a>'+
					'	</td>'+
					'</tr>';
		}
		$('#tableBody').html(appStr);
	};
	this.create = function (){
		art.dialog.open('/certificate/toEdit.action',{
			title : '新增证件类型',
			width : '500px',
			height : '250px'
		});
	};
	this.del =function (id){
		art.dialog.confirm('确定删除吗？',function(){
			$.post('/message/delete.action',{ids:id},function(data){
				if(data=='succeed'){
					mngMessage.load();
				}else if(data=='false'){
					$("#name_tip").text('未进入站点管理');
				}else{
					art.dialog.tips('删除失败');
				}
			});
		});
	};
	this.delMulti =function (){
		var ids=[];
		$("input[name='chk_message_id']:checked").each(function(){
			ids.push($(this).val());
		});
		if(ids.length==0){
			art.dialog.tips("您尚未选择任何要删除的留言");
			return;
		}
		art.dialog.confirm("您确定要批量删除已<br/>选中的留言吗？", function(){
			$.post('/message/delete.action',{ids:ids.join(',')},function(data){
				if(data=='succeed'){
					mngMessage.load();
				}else{
					art.dialog.tips('删除失败');
				}
			});
		});
	};
	this.checkAndReply = function(id){
		art.dialog.data("id", id);
		art.dialog.open("/message/checkAndReply.action",{
			title:"留言回复",
			width:"720px",
			height:"480px",
			lock:true,
			fixed:true,
			resize:false
		});	
	};
	
	this.history = function(name,createTime,siteId,id){
		art.dialog.data("name", name);
		art.dialog.data("createTime", createTime);
		art.dialog.data("siteId", siteId);
		art.dialog.data("id", id);
		art.dialog.open("/message/history.action",{
			title:"历史对话",
			width:"768px",
			height:"650px",
			lock:true,
			fixed:true,
			resize:true
		});
	};
}
</script>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">留言管理</legend>
		<div class="form_search_item" >
			<div class="left">
				<a href="javascript:mngMessage.delMulti()" class="base_btn"><span>删除</span></a>
			</div>
			<div class="right">
				<input type="text" class="piece" id="keyword" onkeydown="if(event.keyCode==13){mngMessage.load();}"/>
				<a href="javascript: mngMessage.load()" class="base_btn"><span>搜索</span></a>
			</div>
		</div>
		<table  class="table_border">
			<tr class="head">
				<td style="width: 40px"><input type="checkbox" id="chk_ids"/></td>
				<td >姓名</td>
				<td >邮箱</td>
				<td >电话</td>
				<td >联系地址</td>
				<td >回复状态</td>
				<td style="width: 60px">操作 </td>
			</tr>
			<tbody id="tableBody"></tbody>
		</table>
		<div class="table_under_btn" >
				<div class="flip"></div>
		</div>
</fieldset>
</body>
</html>