<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
<%@include file="/common/taglibs.jsp" %>

<script type="text/javascript">

	function createRecord(id){
		art.dialog.open('/userSign/toAddRecord.action', {
			width: 800,
			height: 600,
			title:'项目进展',
			ok:function(){
				
				var title =this.iframe.contentWindow.$("#title").val();
				var recordTime =this.iframe.contentWindow.$("#recordTime").val();
				var content =this.iframe.contentWindow.UE.getEditor('myEditor').getContent();
				if(title==""){
					art.dialog.alert('标题不能为空!');
					return false;
				}else if(content==""){
					art.dialog.alert('内容不能为空!');
					return false;
				}else if(recordTime==""){
					art.dialog.alert('时间不能为空!');
					return false;
				}else{
					$.post("/userSign/saveCharityRecord.action",{title:title,content:content,recordTime:recordTime,id:id},function(e){
						if(e=="ok"){
							projectManager.load();
						}else{
							art.dialog.alert('保存失败,请检查内容是否正确!');
							return false;
						}
						
					},"text");
				}
			}
		});
	}
	
	function updateRecord(id){
		art.dialog.open('/userSign/toUpdateRecord.action?id='+id, {
			width: 800,
			height: 600,
			title:'项目进展',
			ok:function(){
				var title =this.iframe.contentWindow.$("#title").val();
				var recordTime =this.iframe.contentWindow.$("#recordTime").val();
				var content =this.iframe.contentWindow.UE.getEditor('myEditor').getContent();
				
				if(title==""){
					art.dialog.alert('标题不能为空!');
					return false;
				}else if(content==""){
					art.dialog.alert('内容不能为空!');
					return false;
				}else if(recordTime==""){
					art.dialog.alert('时间不能为空!');
					return false;
				}else{
					$.post("/userSign/updateCharityRecord.action",{title:title,content:content,recordTime:recordTime,id:id},function(e){
						if(e=="ok"){
							projectManager.load();

						}else{
							art.dialog.alert('保存失败,请检查内容是否正确!');
							return false;
						}
						return false;
					},"text");
	
				}
			}
		});
	}
</script>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">项目进展</legend>
			<div class="form_search_item" >
				<div class="left">
						<a href="javascript:void();" onclick="createRecord(${id})" class="base_btn"><span>新增进展</span></a>
				</div>

			</div>
			<table  class="table_border" style="width: 99.7%;">
				<tr class="head">
					<td>时间</td>
					<td>进展标题</td>
					<td>操作</td>

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
});

function ProjectManager(siteId){
	this.siteId = siteId;
	this.load = function(){
		loadByPage('/userSign/loadCharityRecordList.action?id=${id}',{},this.showList);
	};
	this.showList = function(list){
		$('#tableBody').html('');
		var index = 0;
		for ( var item in list) {
			var project = list[item];
			if(project){
				var html = '';
				html = '<tr id="tr_'+project.id+'">'+

				'	<td>'+(project.recordTimeFormat==null?'':project.recordTimeFormat)+'</td>'+
				'	<td>'+project.title+'</td>';
				html += '<td>';
				html += '<a href="javascript:void(0);" onclick="updateRecord('+project.id+');">修改</a>';
				'	</td>'+
				'</tr>';
				 $('#tableBody').append(html); 
			}else{
				
			}
			index++;
		}
	};


	

	this.toView = function(id){
		art.dialog.open('/userSignManager/toViewCharityProject.action?id='+id, {
			width: 800,
			height: 800,
			title:'项目详情'
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