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
					<td width="150">剩余金额(元)</td>
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



<div id="recordDiv" style="display: none;">
	<table  class="table_border">
		<tr>
			<td width="300px;">项目名</td>
			<td width="80px;">捐款金额</td>
			<td width="90px;">日期</td>
			<td width="80px;">操作人</td>
		</tr>
		<tbody id="recordList"></tbody>
	</table>
	<div class="clear"></div>
</div>
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
		loadByPage('/donateRecord/loadRecordList.action',{name:$('#name').val()},this.showList);
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
				'	<td>'+(project.name==null?'':project.name)+'</td>'+
				'	<td>'+project.money+'</td>'+
				'<td>'+project.lastMoney+'</td>';
				if(project.type==1){
					html += '<td>支付宝</td>';
				}else{
					html += '<td>微信</td>';
				}
				html += ''+
				'	<td>'+project.createTime+'</td>';
				html += '<td>';
				html += '<a href="javascript:projectManager.toView('+project.id+');">捐款详情</a>';
				if(project.lastMoney!=0){
					
					html += ' | <a href="javascript:void();" onclick="toProjectList('+project.id+')">分配捐款</a>';
				}
				html += '	</td>'+
				'</tr>';
				 $('#tableBody').append(html); 
			}else{
				
			}
			index++;
		}
	};


	this.toView = function(id){
		
		$.post("/donateRecord/loadDonateRecord.action",{"id":id},function(e){
			$("#recordList").html("");
			
			for(item in e){
				
				var record = e[item];
				var html="";
				html+=" <tr>";
				html+="<td style='text-align: left;padding-left:5px;'>"+record.name+"</td>";
				html+="<td>"+record.money+"</td>";
				html+="<td>"+record.createTimeFormat+"</td>";
				html+="<td>"+(record.userName==null ? '捐款人' : record.userName)+"</td>";
				
				html+=" </tr>";
				$("#recordList").append(html);
			}
			
			art.dialog({
				content : $("#recordDiv").html(),
				title:'捐款详情'
			});
				
			
		},"json");
		
	};
}

function toProjectList(id){
	art.dialog.open('/donateRecord/toProjectList.action?donateId='+id, {
		width: '100%',
		height: "100%",
		title:'选择捐赠项目',
		close: function (){
			projectManager.load();
		}
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