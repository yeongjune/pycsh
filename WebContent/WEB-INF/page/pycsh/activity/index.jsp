<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">活动管理</legend>
			<div class="form_search_item" >
				<div class="left">
					<a href="javascript:projectManager.createProject()" class="base_btn"><span>新建活动</span></a>
				</div>
				<div class="right">
					<input type="text" class="piece" id="name" />
					<a href="javascript:projectManager.load()" class="base_btn"><span>搜索</span></a>
				</div>
			</div>
			<table  class="table_border" style="width: 99.7%;">
				<tr class="head">
					<td width="30px">序号</td>
					<td >活动名称</td>
					<td width="180">筹款周期</td>
					<!--<td width="100">排序</td>-->
					<td width="80">审核状态</td>
					<td width="80">进展</td>
					<td width="60">开放状态</td>
					<td width="200px">操作 </td>
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
var columnId;
var columnName;
var columnType;
var projectManager;
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
		loadByPage('/activity/loadList.action',{name:$('#name').val()},this.showList);
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
				'	<td style="text-align: left;padding-left:10px;">'
						+'<a href="javascript:projectManager.toViewProject('+project.id+');" style="text-decoration:none;">'+project.name+'</a></td>'+
				'	<td>'+project.startTimeFormat+' 至  '+project.endTimeFormat+'</td>';
				/*
				'	<td>'+
				'		<a href="javascript:projectManager.changeSort('+project.id+',1);" title="上移">↑</a>'+
				'		<a href="javascript:projectManager.changeSort('+project.id+',2);" title="下移">↓</a>'+
				'		<a href="javascript:projectManager.changeSort('+project.id+',3);" >置顶</a>'+
				'		<a href="javascript:projectManager.changeSort('+project.id+',4);" >置尾</a>'+
				'	</td>';
				*/
				html += '	<td>';
				switch (project.checked) {
				case 0:
					html += '无需审核';
					break;
				case 1:
					html += '等待审核';
					break;
				case 10:
					html += '审核不通过';
					break;
				case 11:
					html += '审核通过';
					break;
				default:
					break;
				}
				html += '</td>';
				html += '	<td>';
				switch (project.status) {
				case 1:
					html += '<a href="javascript:projectManager.updateProgress('+project.id+',1);" class="openStatus">发起</a>';
					break;
				case 2:
					html += '<a href="javascript:projectManager.updateProgress('+project.id+',2);" class="openStatus">审核</a>';
					break;
				case 3:
					html += '<a href="javascript:projectManager.updateProgress('+project.id+',3);" class="openStatus">募款</a>';
					break;
				case 4:
					html += '<a href="javascript:projectManager.updateProgress('+project.id+',4);" class="openStatus">执行</a>';
					break;
				case 5:
					html += '<a href="javascript:projectManager.updateProgress('+project.id+',5);" class="openStatus">结束</a>';
					break;
				default:
					break;
				}
				html += '</td>';
				html += '	<td>';
				if(project.isOpen==0){
					html += '<a href="javascript:projectManager.saveOpenStatus('+project.id+',1);" title="" >未开放</a>';
				}else{
					html += '<a href="javascript:projectManager.saveOpenStatus('+project.id+',0);" >已开放</a>';
				}
				html += '</td>';
				html += '<td>';
				html += '		<a href="javascript:projectManager.editProject('+project.id+');">修改</a>'+
				'		<a href="javascript:projectManager.deleteProject('+project.id+');">删除</a>'+
				'		<a href="javascript:projectManager.toViewProject('+project.id+');">查看</a>'+
				'		<a href="javascript:projectManager.toViewRecord('+project.id+');">报名名单</a>'+
				'		<a href="javascript:projectManager.exportRecord('+project.id+');">导出名单</a>'+
				'		<a href="javascript:projectManager.sendMsg('+project.id+');">发送短信通知</a>'+
				
				
				'	</td>'+
				'</tr>';
				 $('#tableBody').append(html); 
			}else{
				
			}
			index++;
		}
		if (list&&list.length>0) {
			$("#deleteMutil").show();
			$("#moveMutil").show();
			$("#changeStatus").show();
		}else{
			$("#deleteMutil").hide();
			$("#moveMutil").hide();
			$("#changeStatus").hide();
		}
	};
	this.createProject = function(){
		art.dialog.open('/activity/toAddActivity.action', {
			width: '100%',
			height: '100%',
			title:'添加活动'
		});
	};
	this.deleteProject = function(id){
		art.dialog.confirm("确定删除吗？", function(){
			$.post('/activity/delete.action',{ids:id},function(data){
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
			art.dialog.alert("您尚未选中任何要删除的活动！");
			return;
		}

		art.dialog.confirm("您确定要批量删除已选中的活动吗？", function(){
			$.post('/activity/delete.action',{ids:ids.join(',')},function(data){
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
		art.dialog.open('/activity/toUpdateActivity.action?id='+id, {
			width: '100%',
			height: '100%',
			title:'修改活动'
		});
	};
	this.updateProgress = function(id,progress){
		art.dialog.open('/activity/toUpdateProgress.action?id='+id, {
			width: 400,
			height: 150,
			title:'修改活动进展'
		});
	};
	this.checkProject = function(id){
		var html = '<label><input type="radio" name="isCheckedState" value="1"/>审核通过</label><label><input type="radio" name="isCheckedState" value="0"/>审核不通过</label>';
		art.dialog({
			width : 200,
			height : 150,
			title : '审核活动',
			content : html,
			ok : function(){
				$.post('/activity/changeCheckState.action', 'id='+id+'&state='+$('input[name="isCheckedState"]:radio:checked').val(), function(data){
					projectManager.load();
				}, 'json');
			}
		});
	};
	this.toViewProject = function(id){
		art.dialog.open('/activity/toViewActivity.action?id='+id, {
			width: '100%',
			height: '100%',
			title:'活动详情'
		});
	};
	this.toViewRecord = function(id){
		loadUrlPage('/activity/toRecordList.action?actId='+id,'menu_name=项目管理')
	};
	this.exportRecord = function(id){
		window.open("/activity/exportRecord.action?actId="+id);
	};
	
	this.moveMutilProject = function(){
		var ids=[];
		var columType='';
		var pass=true;
		$("input[type='checkbox'][name='chk_project_id']:checked").each(function(){
			if(columType==''){
				columType=$(this).next().val();	
			}else if(columType != $(this).next().val()){
				pass=false;
				return false;
			} 
			ids.push($(this).val());
		});
		
		if(!pass){
			art.dialog.alert("您选择了多个类型的活动，不同类型的活动不能移动到同一栏目");
			return;
		}
		
		if (!ids||ids.length==0) {
			art.dialog.alert("您尚未选中任何要移动的活动！");
			return;
		}
		art.dialog.open('/activity/toMoveColumn.action?ids='+ids.join(',') + "&columType="+columType, {
			width: '250px',
			height: '435px',
			title:'选择栏目'
		});
	};
	//修改排序
	this.changeSort = function(id,flag){
		$.post('/activity/updateProjectSort.action',{id:id,flag:flag},function(data){
			if(data=='succeed'){
				projectManager.load();
			}else{
				art.dialog.tips('操作失败');
			}
		});
	};
	//修改活动的开放状态
	this.saveOpenStatus = function(id,flag){
		$.post('/activity/upateOpenStatus.action',{id:id,flag:flag},function(data){
			if(data=='succeed'){
				projectManager.load();
				if(flag==0){
					art.dialog.tips('活动状态已改为未开放');
				}else{
					art.dialog.tips('活动状态已改为开放');
				}
			}else{
				art.dialog.tips('操作失败');
			}
		});
	};
	//设定所选文章的新旧状态
	this.settingStatus = function(){
		
		var ids=[];
		var vals=[];
		$("input[type='checkbox'][name='chk_project_id']:checked").each(function(){
			var this_e = $(this);
			ids.push(this_e.val());
			vals.push(this_e.parent("td").siblings(".status").attr("value").toString());
		});
		
		if (!ids||ids.length==0) {
			art.dialog.alert("您尚未选中任何要设置的选项！");
			return;
		} 
		
		art.dialog.confirm("您确定要修改新旧状态?", function(){
			$.post('/activity/updateStatus.action',{ids:ids.join(','),status : vals.join(",")},function(data){
				if(data=='true'){
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
	
	this.sendMsg = function(id){
		$.post('/sendMsg/getLastMsgConunt.action',{"actId":id},function(e){
			if(e=="ok"){
				var html = '<textarea rows="5" cols="50" id="text"></textarea>';
				art.dialog({
					width : 400,
					height : 250,
					title : '短信内容',
					content : html,
					ok : function(){
						$.post('/sendMsg/sendMsg.action',{"actId":id,"text":$("#text").val()},function(e){
							if(e=="ok"){
								art.dialog.alert("发送成功!");
							}
							if(e=="sendError"){
								art.dialog.alert("发送失败!");
							}
							if(e=="noSendPhone"){
								art.dialog.alert("没有需要发送的号码!");
							}
							if(e=="countOut"){
								art.dialog.alert("已超出短信剩余条数!");
							}
						},"text");
					}
				});
				
			}
			
		},"text");
	};
}


var setting = {
	data: {
		key:{
			name:"name",
			title:"id",
			url:"javascript:void();"
		},
		simpleData: {
			enable: true,
			idKey:"id",
			pIdKey:"pid",
			rootPid:0
		}
	},
	callback: {
		onClick: function(event, treeId, treeNode){
			if (columnId != treeNode.id) {
				columnId = treeNode.id;
				columnType = treeNode.type;
				projectManager.load();
			}else{
				 $.fn.zTree.getZTreeObj("columnTree").cancelSelectedNode();
				columnId = null;
				columnType= null;
				projectManager.load();
			}
			
		}
	}
};



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