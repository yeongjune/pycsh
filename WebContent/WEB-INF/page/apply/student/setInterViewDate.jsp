<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
var interViewMng;
$(function(){
	interViewMng=new InterViewMng();
});

function InterViewMng(){
	this.save = function (){
		var interViewDate=$("#interViewDate1");
		var startTime=$("#startTime");
		var endTime=$("#endTime");
		var batch=$("#batch");
		
		var pass=true;
		var tempInterviewDate="";
		if(!batch.val()){
			$("#batch_tip").text('请输入批次');
			pass=false;
		}else{
			$("#batch_tip").text('');
		}
		if(!interViewDate.val()){
			$("#interViewDate_tip").text('请选择面试日期');
			pass=false;
		}else if(!startTime.val()){
			$("#interViewDate_tip").text('请选择开始面试时间');
			pass=false;
		}else if(!endTime.val()){
			$("#interViewDate_tip").text('请选择面试结束时间');
			pass=false;
		}else if(startTime.val()>endTime.val()){
			$("#interViewDate_tip").text('开始时间不能大于结束时间');
			pass=false;
		}else{
			tempInterviewDate=interViewDate.val()+' '+startTime.val()+'-'+endTime.val();
			$("input[name='interviewDate']").val(tempInterviewDate);
			$("#interViewDate_tip").text('');
		}

		if(pass){
			$.post('/student/saveInterViewDate.action',$("#interViewDateForm").serialize() ,function (data){
				if(data == 'succeed'){
					art.dialog.close();
					art.dialog({
						title: "操作结果",
						content: '已成功设置学生的【'+$("#names").text()+'】的面试时间为:'+tempInterviewDate +','+batch.val(),
						time : 5,
						close : function(){
							art.dialog.opener.mngStudent.load();
							art.dialog.close();
						}
					});
				}else if (data=='fail'){
					art.dialog.tips("设置面试时间失败");
				}else{
					art.dialog.tips("设置面试时间失败");
				}
			});
		}
	};
}
</script>
</head>
<body style="min-width:500px;min-height:200px">
<form action="" id="interViewDateForm" >
<input name="ids" type="hidden" value="${ids }" />
<input name="interviewDate" type="hidden" />
	<div class="form_item">
		<span class="form_span">面试学生：</span><span style="line-height:22px" id="names">${names }</span>
	</div>
	<div class="form_item">
		<span class="form_span">批次：</span>
		<input type="text" id="batch" name="batch" class="piece" value="${student.batch }"  maxlength="50" /><font color="red" id="batch_tip"></font>
	</div>
	<div class="form_item">
		<span class="form_span">面试时间：</span>
		<input type="text" id="interViewDate1" class="piece" value="${fn:substring(student.interviewDate,0,10)}"  maxlength="24" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:new Date()})" style="width:70px"/>
		<input type="text" id="startTime"  class="piece2" value="${fn:substring(student.interviewDate,11,16)}" maxlength="5"  onClick="WdatePicker({dateFmt:'HH:mm'})" style="width:40px" />至
		<input type="text" id="endTime"  class="piece2" value="${fn:substring(student.interviewDate,17,22)}"  maxlength="5" onClick="WdatePicker({dateFmt:'HH:mm'})" style="width:40px"/>
		<font color="red" id="interViewDate_tip"></font>
	</div>
	<div class="form_submit">
			<a href="javascript:interViewMng.save()" class="base_btn"><span>保存</span></a>
	</div>
	<div class="clear"></div>
</form>
</body>
</html>