<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
var eidtScode;
var scodeList={'interviewScore':0};
$(function(){
	eidtScode=new EidtScode("${id}");
	eidtScode.load();
	$("#interview").change(function(){
		if($(this).val()=="0"){
			scodeList.interviewScore=$("#interviewScore").val();
			$("#interviewScore").val("").attr("disabled",true);
		}else{
			$("#interviewScore").val(scodeList.interviewScore);
			$("#interviewScore").attr("disabled",false);
		}
	});
	$("#interviewScore").blur(function(){
		var temp=$(this).val();
		if(temp){
			if(!temp.onlyDigit){
				$(this).next().text("输入有误");
			}
			$("#interview").val("1");
		}else{
			$(this).next().text("");
			$("#interview").val("0");
		}
	});
});
function EidtScode(id){
	var url = '/zd_student/load.action';
	if('${examType}' == 0){
		url = '/zd_student2/load.action';
	}
	this.id=id;
	this.load = function (){
		$.post(url,{id:id},function(data){
			if(data.code=="succeed"){
				var stu=data.student;
				$("#name").text(stu.name);
				$("#graduate").text(stu.graduate);
				$("#interview").val(stu.interview);
				$("#interviewDate").text(stu.interviewDate?stu.interviewDate:'无');
				$("#interviewScore").val(stu.interviewScore);
				$("#admit").val(stu.admit);
			}else{
				art.dialog.tips("加载失败");
				art.dialog.close();
			}
		},'json');
	};
	this.save = function (){
		var interview=$("#interview").val();
		var interviewScore=$("#interviewScore").val();
		var admit=$("#admit").val();
		if (interview=="1" && !interviewScore) {
			$(this).next().text("参加了面试请输入面试成绩");
			return;
		}
		if (interviewScore && !interviewScore.onlyDigit) {
			$(this).next().text("输入有误");
		}else{
			$(this).next().text("");
		}
		$.post('/mh_scode/save.action',{id:this.id,interview:interview,interviewScore:interviewScore,admit:admit,examType:'${examType}'},function(data){
			if(data.code=='fail'){
				art.dialog.alert('保存失败');
			}else if(data.code=='succeed'){
				art.dialog.alert('保存成功');
				art.dialog.opener.mngScode.load();
				art.dialog.close();
			}
		},'json');
	};
}
</script>
<style type="text/css">
.form_item span{
line-height: 22px;
}
</style>
</head>
<body>
<form action="">
	<input type="hidden" name="id" id="id" value="${id }" />
    <div class="form_item">
		<span class="form_span">姓名：</span>
		<span id="name"></span>
	</div>
	<div class="form_item">
		<span class="form_span">学校：</span>
		<span id="graduate"></span>
	</div>
	<div class="form_item">
		<span class="form_span">面试时间：</span>
		<span id="interviewDate">无</span>
	</div>
	<div class="form_item">
		<span class="form_span">是否面试：</span>
		<select class="piece" style="width: 100px;"   id="interview" name="interview" >
			<option value="0">否</option>
			<option value="1">是</option>
		</select>
	</div>
	<div class="form_item">
		<span class="form_span">面试成绩：</span>
		<input class="piece floatInput"  style="width: 93px;" id="interviewScore" name="interviewScore" maxlength="3" />
		<span style="color:red;"></span>
	</div>
	<div class="form_item">
		<span class="form_span">是否录取：</span>
		<select class="piece" style="width: 100px;" id="admit" name="admit" >
			<option value="-1">待公布</option>
			<option value="1">是</option>
			<option value="0">否</option>
		</select>
		<span style="color:red;"></span>
	</div>
	<div class="form_submit">
			<a href="javascript:eidtScode.save()" class="base_btn"><span>保存</span></a>
	</div>
	<div class="clear"></div>
</form>
</body>
</html>
