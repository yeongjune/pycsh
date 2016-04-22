<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">投稿管理</legend>
			<div class="form_search_item" >
				<div class="left">
					
				</div>
				<div class="right">
					标题:<input type="text" class="piece" id="title" />
					作者:<input type="text" class="piece" id="author" />
					电话:<input type="text" class="piece" id="phone" />
					<a href="javascript:projectManager.load()" class="base_btn"><span>搜索</span></a>
				</div>
			</div>
			<table  class="table_border" style="width: 99.7%;">
				<tr class="head">
					<td width="30px">序号</td>
					<td >标题</td>
					<td width="180">作者</td>
					<td width="80">电话</td>
					<td width="80">合作单位</td>
					<td width="60">查看状态</td>
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
	this.load = function(currentPage){
		loadByPage('/contribute/loadList.action',{title:$('#title').val(),author:$("#author").val(),phone:$("#phone").val(),currentPage:currentPage},this.showList);
	};
	this.showList = function(list){
		$('#tableBody').html('');
		var index = 0;
		for ( var item in list) {
			var con = list[item];
			if(con){
				var html = '';
				html = '<tr id="tr_'+con.id+'">'+
				'	<td>'+(index+1)+'</td>';
				html += '	<td>'+con.title+'</td>';
				html += '	<td>'+con.author+'</td>';
				html += '	<td>'+con.phone+'</td>';
				html += '	<td>'+(con.partners==null ? '' : con.partners)+'</td>';
				html += '	<td>'+(con.status==1 ? '已阅' : '未读' )+'</td>';
				html += '<td>';
				html += '		<a href="javascript:void(0);" onclick="viewContribute('+con.id+')">查看</a>';
				html += '		<a href="javascript:void(0);" onclick="deleteContribute('+con.id+')">删除</a>';
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
	
}



function viewContribute(id){
	art.dialog.open('/contribute/toView.action?id='+id, {
		width: '100%',
		height: '100%',
		title:'查看投稿',
		close:function(){
			if(document.getElementById('currentPage')){
				projectManager.load($('#currentPage').val());
			}else{
				projectManager.load();
			}
			
		}
	});
}
function deleteContribute(id){
	art.dialog.confirm("确定删除吗？", function(){
		$.post('/contribute/delete.action',{id:id},function(data){
			if(data=='ok'){
				//$('#tr_'+id).remove();
				projectManager.load();
			}else{
				art.dialog.alert('操作失败');
			}
		});
	});
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