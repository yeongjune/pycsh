<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">报名管理</legend>
			<div class="form_search_item" >
				<div class="left">
					<!--<a href="javascript:projectManager.createProject()" class="base_btn"><span>新增捐款</span></a>
				--></div>
				<div class="right">
					认证状态:
					<select id="status" name="status" onchange="projectManager.load();">
						<option value="">全部</option>
						<option value="0">未认证</option>
						<option value="1">已认证</option>
						<option value="2">不通过</option>
						
					</select>
					
					<input type="text" class="piece" id="keyword" />
					<a href="javascript:projectManager.load()" class="base_btn"><span>搜索</span></a>
				</div>
			</div>
			<table  class="table_border" style="width: 99.7%;">
				<tr class="head">
					<td >单位名称</td>
					<td width="80px;">单位法人</td>
					<td width="80px;">联系人</td>
					<td width="120px;">联系电话</td>
					<td width="130px;">时间</td>
					<td width="80px;">是否认证</td>
					<td width="80px;">承诺书</td>
					<!-- <td>申报书</td> -->
					<td width="150px;">操作</td>

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
		loadByPage('/userSignManager/loadUserSignList.action',{status:$('#status').val(),keyword:$("#keyword").val()},this.showList);
	};
	this.showList = function(list){
		$('#tableBody').html('');
		var index = 0;
		for ( var item in list) {
			var project = list[item];
			if(project){
				var html = '';
				var status ="";
				if(project.status==0){
					status="未认证";
				}
				if(project.status==1){
					status="已认证";
				}
				if(project.status==2){
					status="不通过";
				}
				html = '<tr id="tr_'+project.id+'">'+
				'	<td style="text-align: left;padding-left: 5px;"><a href="javascript:projectManager.toView('+project.id+');">'+project.company+'</a></td>'+
				'	<td>'+(project.corporation==null?'':project.corporation)+'</td>'+
				'	<td>'+(project.contact==null?'':project.contact)+'</td>'+
				'	<td>'+(project.contactPhone==null?'':project.contactPhone)+'</td>'+
				'	<td>'+project.createTime+'</td>'+
				'	<td>'+status+'</td>';
				html += '<td>';
				if(project.promise!=null){
					html += '<a href="javascript:void(0);" onclick="window.open(\''+project.promise+'\',\'_blank\');">下载文件</a>';
				}else{
					html += '<a style="color:#AAAAAA;">暂未上传</a>';
				}
				html += '</td>';
				/*
				html += '<td>';
				if(project.application!=null){
					html += '<a href="javascript:void(0);" onclick="window.open(\''+project.application+'\',\'_blank\');">下载文件</a>';
				}else{
					html += '<a style="color:#AAAAAA;">暂未上传</a>';
				}
				html += '</td>';
				*/
				html += '<td>';
				html += '<a href="javascript:projectManager.toView('+project.id+');">查看</a>';
				if(project.status==0){
					html += ' | <a href="javascript:projectManager.toUpdateStatus('+project.id+');">认证</a>';
				}
				
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
		art.dialog.open('/userSignManager/toViewUserSign.action?id='+id, {
			width: 650,
			height: 600,
			title:'申请详情'
		});
	};
	this.toUpdateStatus = function(id){
		var html = '<label><input type="radio" checked="checked" name="status" value="1"/>认证通过</label>   <label><input type="radio" name="status" value="2"/>认证不通过</label><br/><br/>意见:<textarea id="opinions" rows="5" cols="40" ></textarea>';
		art.dialog({
			width : 200,
			height : 150,
			title : '认证申请',
			content : html,
			ok : function(){
				$.post('/userSignManager/updateStatus.action', {id:id,status:$('input[name="status"]:radio:checked').val(),opinions:$("#opinions").val()}, function(e){
					if(e=="ok"){
						art.dialog.alert('操作成功!');
						projectManager.load();
					}else{
						art.dialog.alert('操作失败');
					}
					
				}, 'text');
			}
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