<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<script type="text/javascript">
var mngRecruitDate;
$(function(){
	mngRecruitDate=new MngRecruitDate();
});
function MngRecruitDate(){
	this.save = function (){
		var startDate=$("#startDate").val();
		var endDate=$("#endDate").val();
		/* var printStartDate=$("#printStartDate").val();
		var printEndDate=$("#printEndDate").val(); */
		if (!startDate) {
			$("#startDate_tip").text('报名开始时间不能为空');
			return;
		}else{
			$("#startDate_tip").text('');
		}
		if (!endDate) {
			$("#endDate_tip").text('报名截止时间不能为空');
			return;
		}else{
			$("#endDate_tip").text('');
		}
		
		$.post('/recruite/doSave.action',{startDate : startDate, endDate : endDate/* , printStartDate:printStartDate, printEndDate: printEndDate */},function(data){
			if(data=='fail'){
				art.dialog.alert('保存失败');
			}else if(data=='succeed'){
				art.dialog.alert('保存成功');
			}else if(data=='false'){
				art.dialog.tips('未进入站点管理');
			}
		});
	};
}
</script>
</head>
<body>

<fieldset class="fieldset_border">
	<legend class="legend_title">报名时间管理</legend>
		<form action="">
		    <div style="float:left;">
		    	<div class="view_rank">
					<span class="form_span" style="font-weight: bold;">报名起止时间</span>
				</div>
			    <div class="form_item">
					<span class="form_span">开始时间：</span>
					<input type="text" id="startDate" class="piece" value="<fmt:formatDate value="${ recruitDate.startDate}"  type="date" pattern="yyyy-MM-dd HH:mm" />"   maxlength="16" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',maxDate:'#F{$dp.$D(\'endDate\',{d:0})}'})" />
					<font color="red" id="startDate_tip"></font>
				</div>
				 <div class="form_item">
					<span class="form_span">截止时间：</span>
					<input type="text" id="endDate" class="piece" value="<fmt:formatDate value="${ recruitDate.endDate}"  type="date" pattern="yyyy-MM-dd HH:mm" />" maxlength="16" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',minDate:'#F{$dp.$D(\'startDate\',{d:0})}'})" />
					<font color="red" id="endDate_tip"></font>
				</div>
				<%-- <div class="view_rank" style="border-bottom:1px solid #DEDEDE;width: 500px;">
					<span class="form_span"  style="font-weight: bold;">打印准考证时间段</span>
				</div>
				 <div class="view_rank">
					<span class="form_span">开始时间：</span>
					<input type="text" id="printStartDate" class="piece" value="<fmt:formatDate value="${ recruitDate.printStartDate}"  type="date" pattern="yyyy-MM-dd" />"  maxlength="10" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:new Date()})" />
					<font color="red" id="printStartDate_tip"></font>
				</div>
				 <div class="view_rank">
					<span class="form_span">截止时间：</span>
					<input type="text" id="printEndDate" class="piece" value="<fmt:formatDate value="${ recruitDate.printEndDate}"  type="date" pattern="yyyy-MM-dd" />"  maxlength="10" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:new Date()})" />
					<font color="red" id="printEndDate_tip"></font>
				</div> --%>
		    </div>
		    <div class="clear"></div>
			<div class="form_submit">
					<a href="javascript:mngRecruitDate.save()" class="base_btn" id="submitButton"><span>保存</span></a>
			</div>
			<div class="clear"></div>
		</form>
</fieldset>

</body>
</html>
