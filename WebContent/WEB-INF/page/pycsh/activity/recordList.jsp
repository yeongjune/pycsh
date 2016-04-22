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
					
				</div>
				<div class="right">
					姓名: <input type="text" class="piece" id="name" style="width: 80px;"/>
					身份证: <input type="text" class="piece" id="idcard" style="width: 120px;"/>
					电话: <input type="text" class="piece" id="phone" style="width: 120px;"/>
					活动名称: <input type="text" class="piece" id="actName" style="width: 120px;"/>
					<a href="javascript:projectManager.load()" class="base_btn"><span>搜索</span></a>
				</div>
			</div>
			<table  class="table_border" style="width: 99.7%;">
				<tr class="head">
					<td width="30px">序号</td>
					<td>姓名</td>
					<td>身份证号</td>
					<td>电话号码</td>
					<td>报名活动</td>
					<td>捐款金额</td>
					<td>序列号</td>
					<td>报名时间 </td>
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
		loadByPage('/activity/loadRecordList.action',{name:$('#name').val(),phone:$('#phone').val(),idcard:$('#idcard').val(),actName:$('#actName').val(),actId:"${actId}"},this.showList);
	};
	this.showList = function(list){
		$('#tableBody').html('');
		var index = 0;
		for ( var item in list) {
			var record = list[item];
			if(record){
				var html = '';
				html = '<tr id="tr_'+record.id+'"></td>';
				html += '	<td>'+(index+1)+'</td>';
				html += '	<td>'+record.name+'</td>';
				html += '	<td>'+(record.idcard == null ? '' : record.idcard)+'</td>';
				html += '	<td>'+record.phone+'</td>';
				html += '	<td>'+record.actName+'</td>';
				html += '	<td>'+record.money+'</td>';
				html += '	<td>'+record.code.substring(0,4)+'-'+record.code.substring(4,8)+'-'+record.code.substring(8,12)+'-'+record.code.substring(12,16)+'</td>';
				html += '	<td>'+record.createTime+'</td>';
				
				html += '	</tr>';
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