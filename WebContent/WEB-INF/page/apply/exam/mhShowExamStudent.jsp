<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
var showExamSeat;
$(function(){
	showExamSeat=new ShowExamSeat();
	showExamSeat.load();
});
function ShowExamSeat(){
	this.load = function () {
		loadByPage('/mh_exam/listSeat.action',{id:$("#id").val(),studentName:$("#keyword").val(),examType:'${exam.examType}'},this.showList);
	};
	this.showList= function(list){
		var contentStr="";
		for ( var i = 0; i < list.length; i++) {
			var item=list[i];
			contentStr +='<tr id="tr_student_'+item.id+'" class="exam_line">'+
					'	<td>'+item.name+'</td>'+
					'	<td>'+item.graduate+'</td>'+
					'	<td>'+item.watingRoomNo+'</td>'+
					'	<td>'+item.roomNo+'</td>'+
					'	<td>'+
					'		<a href="javascript:showExamSeat.viewStudent(' + item.studentId + ');">查看</a>'+
					'	</td>'+
					'</tr>';
		}
		$('#tableBody').html(contentStr);
		if(contentStr=="" && !$("#keyword").val()){
			art.dialog.confirm('该考场还没考生，你是否要分配该考场考生',function(){
				$.post('/mh_exam/deployRoom.action',{id:$("#id").val()},function(data){
					if(data=="succeed"){
						art.dialog.tips('成功分配考场,您可以查看考生和打印考场');
						showExamSeat.load();
					}else{
						art.dialog.tips('分配考场失败');
					}
				});
			});
		}
	};

	this.viewStudent = function (id){
		
		var url = '/zd_student2/view.action?id='+id;
		if('${exam.examType}' > 0){
			url = '/zd_student/view.action?id='+id;
		}
		art.dialog.open(url,{
			title : '报名明细',
			width: '75%',
			height: '95%'
		});
	};
}
</script>
</head>
<body>
<fieldset class="fieldset_border">
<input id="id" value="${exam.id }" type="hidden" />
		<legend class="legend_title">参考学生</legend>
	<div class="form_search_item" >
		<div class="left">
			<strong>考试名称</strong>：${exam.examName } 
			<strong>考试时间：</strong><fmt:formatDate value="${exam.examDate }" pattern="yyyy-MM-dd"/> ${exam.examTime } 
		</div>
		<div class="right">
			<input type="text" class="piece" id="keyword" onkeydown="if(event.keyCode==13){showExamSeat.load();}"/>
			<a href="javascript:showExamSeat.load();" class="base_btn" ><span>搜索</span></a>
			<a href="/exam/showDeployRoom.action?id=${exam.id }" class="base_btn" target="_blank" ><span>打印考场</span></a>
		</div>
	</div>
	<table  class="table_border">
		<tr class="head">
			<td >姓名</td>
			<td >毕业学校</td>
			<td >候考室</td>
			<td >考室</td>
			<td style="width:100px">操作</td>
		</tr>
		<tbody id="tableBody"></tbody>
	</table>
		<div class="table_under_btn" >
			<div class="flip"></div>
		</div>
</fieldset>
</body>
</html>