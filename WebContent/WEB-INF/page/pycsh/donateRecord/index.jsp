<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">捐款管理</legend>
			<div class="form_search_item" >
				<div class="left">
					<!--<a href="javascript:projectManager.createProject()" class="base_btn"><span>新增捐款</span></a>
				--></div>
				<div class="right">
					<input type="text" class="piece" id="name" />
					<a href="javascript:projectManager.load()" class="base_btn"><span>搜索</span></a>
				</div>
			</div>
			<table  class="table_border" style="width: 99.7%;">
				<tr class="head">
					<td width="30px">序号</td>
					<td width="80">手机号码</td>
					<td width="90">姓名</td>
					<td width="150">捐款金额(元)</td>
					<td >捐款项目名称</td>
					<td width="60">捐款途径</td>
					<td width="90">捐款日期</td>
					<td width="110px">操作 </td>
				</tr>
				<tbody id="tableBody"></tbody>
			</table>
			<div class="table_under_btn" >
				<div class="flip">
				</div>
			</div><!--table_under_btn-->
		<div class="clear"></div>
</fieldset>
<script type="text/javascript">
$(function(){
	projectManager = new ProjectManager('${siteId}');
	projectManager.load();
	
	$("#chk_ids").click(function(){
		if($(this).attr("checked")){
			$("input[name='chk_project_id']").attr('checked',true);
		}else{
			$("input[name='chk_project_id']").attr('checked',false);
		}
	});
});

function ProjectManager(siteId){
	this.siteId = siteId;
	this.load = function(){
		loadByPage('/donateRecord/list.action',{name:$('#name').val()},this.showList);
	};
	this.showList = function(list){
		$('#tableBody').html('');
		var index = 0;
		for ( var item in list) {
			var project = list[item];
			if(project){
				var html = '';
				html = '<tr id="tr_'+project.id+'">'+
				'	<td>'+(index+1)+'</td>'+
				'	<td>'+project.loginName+'</td>'+
				'	<td>'+(project.wName==null?'':project.wName)+'</td>'+
				'	<td>'+project.money+'</td>'+
				'	<td style="text-align: left;padding-left:10px;">'+project.pName+'</td>';
				if(project.type==1){
					html += '<td>支付宝</td>';
				}else{
					html += '<td>微信</td>';
				}
				html += ''+
				'	<td>'+project.createTime+'</td>';
				html += '<td>';
				html += '<a href="javascript:projectManager.toView('+project.id+');">查看</a>'+
				'	</td>'+
				'</tr>';
				 $('#tableBody').append(html); 
			}else{
				
			}
			index++;
		}
	};
	this.createProject = function(){
		art.dialog.open('/donateRecord/add.action', {
			width: '100%',
			height: '100%',
			title:'添加项目'
		});
	};
	this.deleteProject = function(id){
		art.dialog.confirm("确定删除吗？", function(){
			$.post('/donateRecord/delete.action',{ids:id},function(data){
				if(data=='succeed'){
					//$('#tr_'+id).remove();
					projectManager.load();
				}else{
					art.dialog.alert('操作失败');
				}
			});
		});
	};
	this.deleteMutilProject = function(){
		var ids=[];
		$("input[type='checkbox'][name='chk_project_id']:checked").each(function(){
			ids.push($(this).val());
		});
		
		if (!ids||ids.length==0) {
			art.dialog.alert("您尚未选中任何要删除的项目！");
			return;
		}

		art.dialog.confirm("您确定要批量删除已选中的项目吗？", function(){
			$.post('/donateRecord/delete.action',{ids:ids.join(',')},function(data){
				if(data=='succeed'){
					/* for (var index in ids) {
						$('#tr_'+ids[index]).remove();
					} */
					projectManager.load();
				}else{
					art.dialog.alert('操作失败');
				}
			});
		});
	};
	this.editProject = function(id){
		art.dialog.open('/donateRecord/toEdit.action?id='+id, {
			width: '100%',
			height: '100%',
			title:'修改项目'
		});
	};
	this.toView = function(id){
		art.dialog.open('/donateRecord/toView.action?id='+id, {
			width: 600,
			height: 400,
			title:'捐款详情'
		});
	};
}

//键盘enter键触发搜索事件
document.onkeydown=keyDownSearch;  
function keyDownSearch(e) {    
    // 兼容FF和IE和Opera    
    var theEvent = e || window.event;    
    var code = theEvent.keyCode || theEvent.which || theEvent.charCode;    
    if (code == 13) {    
    	projectManager.load();//具体处理函数    
        return false;    
    }    
    return true;    
}  
</script>
</body>
</html>