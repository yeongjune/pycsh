<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<script type="text/javascript">
var reportScode;
$(function(){
	reportScode=new ReportScode();
	reportScode.load();
	
});

function ReportScode(){
	//加载
	this.load = function () {
		 $.post('/report/getScopeReportList.action',{graduate:$("#graduate").val(),examYear:$("#examYear").val()},function(data){
			if(data){
				var tempStr="";
				var applyCount=0;
				var interviewCount=0;
				var avgOfChinese=0;
				var avgOfMaths=0;
				var avgOfEnglish=0;
				var AvgOfInterview=0;
				var admitCount=0;
				var notAdmitCount=0;
				var watingAdmitCount=0;
				var len=data.length;
				for (var i=0;i<data.length;i++) {
					var item = data[i];
					tempStr +='<tr>'+
							'	<td>'+item.graduate+'</td>'+
							'	<td>'+item.applyCount+'</td>'+
							'	<td>'+item.interviewCount+'</td>'+
							/*
							'	<td>'+(item.avgOfChinese?item.avgOfChinese:'')+'</td>'+
							'	<td>'+(item.avgOfMaths?item.avgOfMaths:'')+'</td>'+
							'	<td>'+(item.avgOfEnglish?item.avgOfEnglish:'')+'</td>'+
							*/
							'	<td>'+(item.AvgOfInterview?item.AvgOfInterview:'')+'</td>'+
							'	<td>'+item.admitCount+'</td>'+
							'	<td>'+item.notAdmitCount+'</td>'+
							'	<td>'+item.watingAdmitCount+'</td>'+
							'</tr>';
					applyCount += item.applyCount;
					interviewCount += item.interviewCount;
					avgOfChinese += (item.avgOfChinese?item.avgOfChinese:0);
					avgOfMaths += (item.avgOfMaths?item.avgOfMaths:0);
					avgOfEnglish += (item.avgOfEnglish?item.avgOfEnglish:0);
					AvgOfInterview += (item.AvgOfInterview?item.AvgOfInterview:0);
					admitCount += item.admitCount;
					notAdmitCount += item.notAdmitCount;
					watingAdmitCount += item.watingAdmitCount;
				}
				tempStr +='<tr class="head">'+
				'	<td style="text-align:right;">总共:</td>'+
				'	<td>'+applyCount+'</td>'+
				'	<td>'+interviewCount+'</td>'+
				
				/* '	<td>'+(avgOfChinese==0 ? '': avgOfChinese/len)+'</td>'+
				'	<td>'+(avgOfMaths==0 ? '': avgOfMaths/len)+'</td>'+
				'	<td>'+(avgOfEnglish==0 ? '': avgOfEnglish/len)+'</td>'+ */
				
				'	<td>'+(AvgOfInterview==0 ? '': AvgOfInterview/len)+'</td>'+
				'	<td>'+admitCount+'</td>'+
				'	<td>'+notAdmitCount+'</td>'+
				'	<td>'+watingAdmitCount+'</td>'+
				'</tr>';
				$('#tableBody_2').html(tempStr);
			}
		},'json');
	};
	//查看
	this.view = function (graduate){
		art.dialog.open('/student/list.action?graduate='+graduate,{
			title : '学校学生报名列表',
			width: '75%',
			height: '95%'
		});
	};
	//导出报表
	this.exportScode = function (){
		excelExport('scodeInfor', 'scodeInfor', $("#searchForm").serialize());
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
	<legend class="legend_title">成绩统计</legend>
		<div class="form_search_item" style="line-height:32px;">
			<div class="right">
				<form id="searchForm">
					年份：<input type="text" class="piece" style="width: 80px;" name="examYear" id="examYear"  value="${examYear }"  onfocus="WdatePicker({dateFmt:'yyyy'})"   onchange="reportScode.load();" />
					学校：<select class="piece"  id="graduate" name="graduate" onchange="reportScode.load()">
						<option value="">--全部--</option>
						<c:forEach var="item" items="${graduateList }">
							<option value="${item}">${item }</option>
						</c:forEach>
					</select>
					<a href="javascript:reportScode.load()" class="base_btn"><span>搜索</span></a>
				</form>
			</div>
			<div class="left" style="margin-top: 5px;">
				<a href="javascript:reportScode.exportScode();" class="base_btn"><span>导出</span></a>
			</div>
		</div>
		<div class="clear"></div>
		<div   style="width: 100%;overflow: auto;">
			<table  class="table_border">
				<tr class="head">
					<td rowspan="2">毕业学校</td>
					<td rowspan="2">申请人数</td>
					<td rowspan="2">安排面试</td>
					<td rowspan="2">面试成绩平均分</td>
					<td colspan="3">录取状态</td>
				</tr>
				<tr class="head">
					<!-- 
					<td>语文</td>
					<td>数学</td>
					<td>英语</td> 
					<td>面试</td>
					-->
					<td>录取</td>
					<td>不录取</td>
					<td>待公布</td>
				</tr>
				<tbody id="tableBody_2"></tbody>
			</table>
		</div>
</fieldset>
</body>
</html>