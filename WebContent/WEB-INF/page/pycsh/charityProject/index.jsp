<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">项目管理</legend>
			<div class="form_search_item" >
				<div class="left">
					
				</div>
				<div class="right">
					认证状态:
					<select id="status" name="status" onchange="projectManager.load();">
						<option value="">全部</option>
						<option value="0">未审核</option>
						<option value="1">已通过</option>
						<option value="2">不通过</option>
						
					</select>
					
					<input type="text" class="piece" id="keyword" />
					<a href="javascript:projectManager.load()" class="base_btn"><span>搜索</span></a>
				</div>
			</div>
			<table  class="table_border" style="width: 99.7%;">
				<tr class="head">
					<td >项目名称</td>
					<td width="120px;">项目类型</td>
					<td width="90px;">申请时间</td>
					<td width="80px;">状态</td>
					<td width="80px;">进度</td>
					<td width="80px;">申报书</td>
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
		loadByPage('/userSignManager/loadCharityProjectList.action',{status:$('#status').val(),keyword:$("#keyword").val()},this.showList);
	};
	this.showList = function(list){
		$('#tableBody').html('');
		var index = 0;
		for ( var item in list) {
			var project = list[item];
			if(project){
				var html = '';
				var checked ="";
				if(project.checked==0){
					checked="未审核";
				}
				if(project.checked==1){
					checked="已通过";
				}
				if(project.checked==2){
					checked="不通过";
				}
				var status ="";//1：发起，2：审核，3：募款，4：执行，5：结束
				if(project.status==1){
					status="发起";
				}
				if(project.status==2){
					status="审核";
				}
				if(project.status==3){
					status="募款";
				}
				if(project.status==4){
					status="执行";
				}
				if(project.status==5){
					status="结束";
				}
				html = '<tr id="tr_'+project.id+'">'+

				'	<td style="text-align: left;padding-left: 5px;"><a href="javascript:projectManager.toView('+project.id+');">'+project.name+'</a></td>'+
				'	<td>'+(project.typeName==null?'':project.typeName)+'</td>'+
				'	<td>'+(project.createTimeFormat==null?'':project.createTimeFormat)+'</td>'+
				'	<td>'+checked+'</td>'+
				'	<td>'+status+'</td>';
				html += '<td>';
				if(project.application!=null){
					html += '<a href="javascript:void(0);" onclick="window.open(\''+project.application+'\',\'_blank\');">下载文件</a>';
				}else{
					html += '<a style="color:#AAAAAA;">暂未上传</a>';
				}
				html += '</td>';
				html += '<td>';
				html += '<a href="javascript:projectManager.toView('+project.id+');">查看</a>';
				if(project.checked==0){
					html += ' | <a href="javascript:projectManager.toUpdateStatus('+project.id+');">审核</a>';
				}
				
				'	</td>'+
				'</tr>';
				 $('#tableBody').append(html); 
			}else{
				
			}
			index++;
		}
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

	this.toView = function(id){
		art.dialog.open('/userSignManager/toViewCharityProject.action?id='+id, {
			width: 800,
			height: 600,
			title:'项目详情'
		});
	};
	this.toUpdateStatus = function(id){
		var html = '<label><input type="radio" checked="checked" name="status" value="1"/>审核通过</label>   <label><input type="radio" name="status" value="2"/>审核不通过</label><br/><br/>意见:<textarea id="opinions" rows="5" cols="40" ></textarea>';
		art.dialog({
			width : 200,
			height : 150,
			title : '审核项目',
			content : html,
			ok : function(){
				$.post('/userSignManager/updateCharityProjectStatus.action', {id:id,status:$('input[name="status"]:radio:checked').val(),opinions:$("#opinions").val()}, function(e){
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