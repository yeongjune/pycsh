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
var editExam;
$(function(){
	editExam=new EditExam();
	if($("#seatCount").val()>0){
		$("#roomCount").attr("readonly",true);
		$("#roomCount_tip").text("已分配考场不能再修改考场数量");
	}
});

function EditExam(){
	this.save = function (){
		var examName=$("input[name='examName']");
		var examDate=$("input[name='examDate1']");
		var startTime=$("#startTime");
		var endTime=$("#endTime");
		var roomCount=$("#roomCount");
		var seatCount=$("#seatCount").val();
		var pass=true;
		if(!examName.val()){
			$(examName).next().text('考试名称不能为空');
			pass=false;
		}else{
			$(examName).next().text('');
		}
		
		if(!examDate.val()){
			$("#examDate_tip").text('请选择考试日期');
			pass=false;
		}else if(!startTime.val()){
			$("#examDate_tip").text('请选择开始考试时间');
			pass=false;
		}else if(!endTime.val()){
			$("#examDate_tip").text('请选择考试结束时间');
			pass=false;
		}else if(startTime.val()>endTime.val()){
			$("#examDate_tip").text('开考时间不能大于结束时间');
			pass=false;
		}else{
			$("input[name='examTime']").val(startTime.val()+'-'+endTime.val());
			$("#examDate_tip").text('');
		}
		if(roomCount==0){
			$("#roomCount_tip").text('考场数量不能小于1');
			pass=false;
		}
		
		if(pass){
			$.post('/exam/save.action',$("#examForm").serialize() ,function (data){
				if(data == 'succeed'){
					art.dialog.opener.managerExam.load();
					art.dialog.close();
				}else{
					if($("#id").val()){
						art.dialog.tips("修改失败");    
					}else{
						art.dialog.tips("新增失败");    
					}
				}
			});
		}
	};
}
</script>
</head>
<body style="width:540px;height:250px">
<form action="" id="examForm" >
<input name="id" type="hidden" value="${exam.id }" />
<input id="seatCount" type="hidden" value="${seatCount}" />
<input name="examTime"  type="hidden" value="${exam.examTime }" />
    <div class="view_rank">
		<span class="form_span">考试名称：</span>
		<input type="text" name="examName" class="piece" value="${empty exam ? examName : exam.examName }" maxlength="50" />
		<font color="red" id="examName_tip"></font>
	</div>
	<div class="form_item">
		<span class="form_span">考试日期：</span>
		<input type="text"  name="examDate1" class="piece"  value="<fmt:formatDate value="${empty exam.examDate ? '':exam.examDate}" type="date" pattern="yyyy-MM-dd"/>" maxlength="24" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:new Date()})" style="width:70px"/>
		<input type="text" id="startTime"  class="piece2"  maxlength="5" value="${empty exam.examTime ? '09:00':fn:split(exam.examTime,'-')[0] }" onClick="WdatePicker({dateFmt:'HH:mm'})" style="width:40px" />至
		<input type="text" id="endTime"  class="piece2"  maxlength="5" value="${empty exam.examTime ? '12:00':fn:split(exam.examTime,'-')[1] }" onClick="WdatePicker({dateFmt:'HH:mm'})" style="width:40px"/>
		<font color="red" id="examDate_tip"></font>
	</div>
	<div class="view_rank">
		<span class="form_span">考场数量：</span>
		<input type="text" name="roomCount" id="roomCount" class="piece" value="${empty exam ? 8 :exam.roomCount }" maxlength="50" />
		<font color="red" id="roomCount_tip"></font>
	</div>
    <div class="clear"></div>
	<div class="form_submit">
			<a href="javascript:editExam.save()" class="base_btn"><span>保存</span></a>
	</div>
	<div class="clear"></div>
</form>
</body>
</html>