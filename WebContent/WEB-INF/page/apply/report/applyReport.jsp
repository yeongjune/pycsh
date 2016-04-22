<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<script type="text/javascript">
var reportApply;
$(function(){
	reportApply=new ReportApply();
	reportApply.load();
	$("#chk_ids").click(function(){
		if($(this).attr("checked")){
			$("input[name='chk_student_id']").attr('checked',true);
		}else{
			$("input[name='chk_student_id']").attr('checked',false);
		}
	});
	for(var i in  reportApply.statusArray){
		$("#status").append("<option value='"+i+"'>"+reportApply.statusArray[i]+"</option>");
	}
	
});

function ReportApply(){
	this.statusArray=['待审核','审核通过','审核不通过','审核回退'];
	//加载
	this.load = function () {
		 $.post('/report/getApplyReportList.action',{graduate:$("#graduate").val(),examYear:$("#examYear").val()},function(data){
			if(data){
				var tempStr="";
				var applyCount=0;
				var interviewCount=0;
				var watingCheck=0;
				var passCheck=0;
				var backCheck=0;
				var notPassCheck=0;
				var admitCount=0;
				var notAdmitCount=0;
				var watingAdmitCount=0;
				for (var i=0;i<data.length;i++) {
					var item = data[i];
					tempStr +='<tr>'+
							'	<td>'+item.graduate+'</td>'+
							'	<td>'+item.applyCount+'</td>'+
							'	<td>'+item.interviewCount+'</td>'+
							'	<td>'+item.watingCheck+'</td>'+
							'	<td>'+item.passCheck+'</td>'+
							'	<td>'+item.backCheck+'</td>'+
							'	<td>'+item.notPassCheck+'</td>'+
							'	<td>'+item.admitCount+'</td>'+
							'	<td>'+item.notAdmitCount+'</td>'+
							'	<td>'+item.watingAdmitCount+'</td>'+
							'</tr>';
					applyCount += item.applyCount;
					interviewCount += item.interviewCount;
					watingCheck += item.watingCheck;
					passCheck += item.passCheck;
					backCheck += item.backCheck;
					notPassCheck += item.notPassCheck;
					admitCount += item.admitCount;
					notAdmitCount += item.notAdmitCount;
					watingAdmitCount += item.watingAdmitCount;
				}
				tempStr +='<tr class="head">'+
				'	<td style="text-align:right;">总共:</td>'+
				'	<td>'+applyCount+'</td>'+
				'	<td>'+interviewCount+'</td>'+
				'	<td>'+watingCheck+'</td>'+
				'	<td>'+passCheck+'</td>'+
				'	<td>'+backCheck+'</td>'+
				'	<td>'+notPassCheck+'</td>'+
				'	<td>'+admitCount+'</td>'+
				'	<td>'+notAdmitCount+'</td>'+
				'	<td>'+watingAdmitCount+'</td>'+
				'</tr>';
				$('#tableBody_1').html(tempStr);
			}
		},'json');
	};
	//导出报表
	this.exportApply = function (){
		excelExport('applyInfor', 'applyInfor', $("#searchForm").serialize());
		//window.location.href='/report/exportApplyReport.action?'+$("#searchForm").serialize();
	};
}
/**
 * excel导出
 * @param workbook
 * @param fileName 导出的文件名称
 * @param params 写法：&a=a&b=a
 */
function excelExport(workbook,fileName,params){
	window.location.href='/excel/export.action?workbook='+workbook+'&sheet=Sheet1'+(fileName?'&fileName='+fileName:'')+(params?'&'+params:'');
}
</script>

</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">报名情况</legend>
		<div class="form_search_item" style="line-height:32px;">
			<div class="right">
				<form id="searchForm">
					年份：<input type="text" class="piece" style="width: 80px;" name="examYear" id="examYear"  value="${examYear }"  onfocus="WdatePicker({dateFmt:'yyyy'})" onchange="reportApply.load();" />
					学校：<select class="piece"  id="graduate" name="graduate"  onchange="reportApply.load();">
						<option value="">--全部--</option>
						<c:forEach var="item" items="${graduateList }">
							<option value="${item}">${item }</option>
						</c:forEach>
					</select>
					<a href="javascript: reportApply.load()" class="base_btn"><span>搜索</span></a>
				</form>
			</div>
			<div class="left">
				<a href="javascript:reportApply.exportApply();" class="base_btn"><span>导出</span></a>
			</div>
		</div>
		<div class="clear"></div>
		<table  class="table_border">
			<tr class="head">
				<td rowspan="2">毕业学校</td>
				<td rowspan="2">申请人数</td>
				<td rowspan="2">安排面试</td>
				<td colspan="4">报名状态</td>
				<td colspan="3">录取状态</td>
			</tr>
			<tr class="head">
				<td>待审核</td>
				<td>审核通过</td>
				<td>审核回退</td>
				<td>审核不通过</td>
				<td>录取</td>
				<td>不录取</td>
				<td>待公布</td>
			</tr>
			<tbody id="tableBody_1"></tbody>
		</table>
</fieldset>
</body>
</html>