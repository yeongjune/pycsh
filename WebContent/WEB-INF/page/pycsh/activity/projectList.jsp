<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/base/util.js"></script>
<!-- 弹出框引入 -->
<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<style type="text/css">
.form_search_item {
  height: 30px;
}
.base_btn span {
  display: inline-block;
  height: 26px;
  background: url(../images/btn.jpg) no-repeat right 0px;
  line-height: 26px;
  padding-right: 15px;
  border: 0;
  color: #FFF;
  margin: 0 0 0 2px;
  cursor: pointer;
  font-family: "微软雅黑";
}
.table_border {
  width: 100%;
  border-collapse: collapse;
  margin: 5px 0 5px 0;
}
.table_border th {
  border: 1px solid #d3e5f3;
  text-align: center;
  line-height: 26px;
}
.table_border td {
  border: 1px solid #d3e5f3;
  text-align: center;
  line-height: 26px;
}
.piece {
  border: 1px #D7D7D7 solid;
  height: 24px;
  width: 200px;
  padding-left: 5px;
  color: #555;
  line-height: 24px;
  margin-right: 5px;
  background: #FAFAFA;
  outline: none;
}
.head {
  background: url(../skins/blue/images/main_07.gif) repeat-x;
  height: 26px;
  line-height: 26px;
  font-weight: bold;
  text-align: center;
}
/* 蓝色按钮样式*/
.base_btn{ display:inline-block;height: 26px; background: url(../skins/blue/images/btn.jpg) no-repeat left 0px; padding-left: 15px; padding-right: 0;
				 color: #FFF; line-height: 26px;  margin: 0 0 0 2px;}
.base_btn:hover{ background: url(../skins/blue/images/btn.jpg) no-repeat left -29px;}
.base_btn span{display:inline-block;height: 26px; background: url(../skins/blue/images/btn.jpg) no-repeat right 0px; line-height: 26px; 
					padding-right: 15px; border: 0; color: #FFF;  margin: 0 0 0 2px; cursor: pointer; font-family: "微软雅黑"}
.base_btn:hover span{ background: url(../skins/blue/images/btn.jpg) no-repeat right -29px; }
</style>
</head>
<body>
			<div class="form_search_item">
				<div class="right" style="float: right;">
					<input type="text" class="piece" id="name" />
					<a href="javascript:void(0)" onclick="loadProject()" class="base_btn"><span>搜索</span></a>
				</div>
			</div>			
			
			<table  class="table_border">
				<thead>
					<tr class="head">
						<th>项目名称</th>
						<th width="250px;">项目周期</th>
						<th width="80px;">已筹(元)</th>
						<th width="80px;">已捐人数</th>
						<th width="80px;">操作</th>
					</tr>
				</thead>
				<tbody id="tableBody">
									
				</tbody>
			</table>
			<div class="table_under_btn" >
				<div class="flip">
				</div>
			</div><!--table_under_btn-->
		<div class="clear"></div>
<script type="text/javascript">

$(function(){
	loadByPage('/projectFront/loadList.action',{"status":1,"name":$("#name").val()},loadList);

});
	
	function loadList(list){
		$("#idsDiv").html("");
		$('#tableBody').html("");
		for(var item in list){
			var poj = list[item];
			var html="";
			var statusStr = "";
			if(poj.status==3){
				statusStr="募款中";
			}
			html+='<tr class="project_data">';
			//html+='<td rowspan="3"><img src="'+poj.smallPicUrl+'" width="150"/></td>';
			html+='<td ><a href="javascript:toViewProject('+poj.id+')">'+poj.name+'</a></td>';
			html+='<td >'+poj.endTimeFormat+' 至 '+poj.endTimeFormat+'   '+(poj.organization ==undefined ? '' :poj.organization)+'</td>';
			html+='<td ><span id="pojMoney'+poj.id+'">0</span></td>';	
			html+='<td ><span id="pojCount'+poj.id+'">0</span></td>';	
			html+='<td ><a href="javascript:void(0);" onclick="selectProject('+poj.id+',\''+poj.name+'\')">关联此项目</a></td>';
			html+="<input type='hidden' name='ids' value='"+poj.id+"'/>";
			html+='</tr>';
			$('#tableBody').append(html);
			$("#idsDiv").append(html);
		}
		
		loadRecord();
	}


function loadRecord(){

	$.post("/projectFront/loadRecordStatistics.action",$("#recordForm").serialize(),function(e){

		for(var item in e){
			var tmp=e[item];
			$("#pojMoney"+tmp.projectId).html(tmp.money);
			$("#pojCount"+tmp.projectId).html(tmp.userCount);
		}
		
	},"json");
	
}

function selectProject(id,name){
	$("#projectId",art.dialog.opener.document).val(id);
	$("#projectName",art.dialog.opener.document).show();
	$("#projectName",art.dialog.opener.document).val(name);
	art.dialog.close();
	
}

function loadProject(){
	loadByPage('/projectFront/loadList.action',{"status":1,"name":$("#name").val()},loadList);
	
}

function toViewProject(id){
	art.dialog.open('/project/toView.action?id='+id, {
		width: '100%',
		height: '100%',
		title:'项目详情'
	});
	
}
//键盘enter键触发搜索事件
document.onkeydown=keyDownSearch;  
function keyDownSearch(e) {    
    // 兼容FF和IE和Opera    
    var theEvent = e || window.event;    
    var code = theEvent.keyCode || theEvent.which || theEvent.charCode;    
    if (code == 13) {    
    	//具体处理函数    
    	loadProject();
        return false;    
    }    
    return true;    
}  
</script>
<form id="recordForm" method="post">
				<div id="idsDiv" style="display: none;"></div>
			</form>
</body>
</html>