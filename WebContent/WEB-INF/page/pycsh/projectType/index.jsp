<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">项目类型管理</legend>
			<div class="form_search_item" >
				<div class="left">
					<a href="javascript:projectManager.createProject()" class="base_btn"><span>新建项目类型</span></a>
				</div>
				<div class="right">
					<input type="text" class="piece" id="name" />
					<a href="javascript:projectManager.load()" class="base_btn"><span>搜索</span></a>
				</div>
			</div>
			<table  class="table_border" style="width: 99.7%;">
				<tr class="head">
					<td width="30px">序号</td>
					<td >项目类型名称</td>
					<td width="80px;">类型级别</td>
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
		loadByPage('/projectType/getList.action',{name:$('#name').val()},this.showList);
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
						+'<a href="javascript:projectManager.toViewProject('+project.id+');" style="text-decoration:none;">'+project.name+'</a></td>';
				if(project.pId==0){
					html += "<td>一级类型</td>";
				}else{
					html += "<td>二级类型</td>";
				}
				html += '<td>		<a href="javascript:projectManager.editProject('+project.id+');">修改</a>'+
				'		<a href="javascript:projectManager.deleteProject('+project.id+');">删除</a>'+
				'		<a href="javascript:projectManager.toViewProject('+project.id+');">查看</a>'+
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
		art.dialog.open('/projectType/add.action', {
			width: 400,
			height: 200,
			title:'添加项目类型'
		});
	};
	this.deleteProject = function(id){
		art.dialog.confirm("下级类型也一并删除，确定吗？", function(){
			$.post('/projectType/delete.action',{id:id},function(data){
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
			art.dialog.alert("您尚未选中任何要删除的项目类型！");
			return;
		}

		art.dialog.confirm("您确定要批量删除已选中的项目类型吗？", function(){
			$.post('/projectType/delete.action',{ids:ids.join(',')},function(data){
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
		art.dialog.open('/projectType/toEdit.action?id='+id, {
			width: 400,
			height: 200,
			title:'修改项目类型'
		});
	};

	
	this.toViewProject = function(id){
		art.dialog.open('/projectType/toView.action?id='+id, {
			width: 400,
			height: 200,
			title:'项目类型详情'
		});
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
			art.dialog.alert("您选择了多个类型的项目类型，不同类型的项目类型不能移动到同一栏目");
			return;
		}
		
		if (!ids||ids.length==0) {
			art.dialog.alert("您尚未选中任何要移动的项目类型！");
			return;
		}
		art.dialog.open('/projectType/toMoveColumn.action?ids='+ids.join(',') + "&columType="+columType, {
			width: '250px',
			height: '435px',
			title:'选择栏目'
		});
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