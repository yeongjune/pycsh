<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title }</title>
<script type="text/javascript">
var managerExam;
$(function(){
	managerExam=new ManagerExam();
	managerExam.load();
});
function ManagerExam(){
	this.load = function () {
		loadByPage('/exam/list.action', {examName:$("#keyword").val()}, this.showList);
	};
	this.showList= function(list){
		$('#tableBody').html('');
		for ( var i = 0; i < list.length; i++) {
			var item=list[i];
			$('#tableBody').append(
					'<tr id="tr_'+item.id+'">'+
					'	<td class="exanName">'+item.examName+'</td>'+
					'	<td>'+item.examDate.substr(0,10)+' '+item.examTime+'</td>'+
					'	<td>'+item.roomCount+'</td>'+
					'	<td>'+(item.seatCount?item.seatCount:0)+'</td>'+
					'	<td>'+
					'		<a href="javascript:managerExam.create('+item.id+');">修改</a>'+
					'		<a href="javascript:managerExam.del('+item.id+');">删除</a>'+
					'		<a href="javascript:managerExam.deployRoom('+item.id+');">分配考场</a>'+
					'		<a href="javascript:managerExam.showExamStudent('+item.id+');">查看考生</a>'+
					'		<a href="/exam/showDeployRoom.action?id='+item.id+'" target="_blank">打印考场</a>'+
					'	</td>'+
					'</tr>'
			); 
			
		}
	};
	//编辑或新建
	this.create = function(id){
		if(!id)id='';
		art.dialog.open('/exam/toEdit.action?id='+id,{
			title:(id?'修改考场分配信息':'新增考场分配信息'),
			width:'auto',
			height:'auto'
		});
	};
	//删除考场
	this.del =function (id){
		art.dialog.confirm('确定删除吗？',function(){
			$.post('/exam/delete.action',{id:id},function(data){
				if(data=='succeed'){
					managerExam.load();
					$("#tableBody2").html('');
				}else{
					art.dialog.tips('删除失败');
				}
			});
		});
	};
	
	//分配考场
	this.deployRoom=function(id){
		art.dialog.confirm('您确认要将当前未分配考场的学生分配到该次考试吗？',function(){
			$.post('/exam/deployRoom.action',{id:id},function(data){
				if(data=="succeed"){
					art.dialog.tips('成功分配考场,您可以查看考生和打印考场');
					managerExam.load();
				}else{
					art.dialog.tips('分配考场失败');
				}
			});
		});
	};
	
	//查看考场的考生
	this.showExamStudent = function(id){
		if(!id)id='';
		var examName=$("#tr_"+id).find(".exanName").text();
		art.dialog.open('/exam/toShowExamStudent.action?id='+id,{
			title:examName+' 考生列表',
			width:'75%',
			height:'90%'
		});
	};
}
</script>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">考场分配</legend>
		<div class="form_search_item" >
			<div class="left">
				<a href="javascript:managerExam.create('');" class="base_btn"><span>新增考试</span></a>
				操作说明：单击考试行可以显示出其参考学生
			</div>
			<div class="right">
				<input type="text" class="piece" id="keyword" onkeydown="if(event.keyCode==13){managerExam.load();}"/>
				<a href="javascript:managerExam.load();" class="base_btn"><span>搜索</span></a>
			</div>
		</div>
		<table  class="table_border">
			<tr class="head">
				<td >考试名称</td>
				<td >考试时间</td>
				<td >考场数量</td>
				<td >考生人数</td>
				<td style="width: 250px">操作 </td>
			</tr>
			<tbody id="tableBody"></tbody>
		</table>
		<div class="page_1 table_under_btn" >
			<div class="flip"></div>
		</div>
</fieldset>
</body>
</html>