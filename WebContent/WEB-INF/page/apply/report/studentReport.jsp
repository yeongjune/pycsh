<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title }</title>
<style type="text/css">
/*缩略图*/
.listheadImage{
	margin:5px;
	width: 60px;
	height: 60px;
	cursor:pointer;
	vertical-align: middle;
	border:1px solid #DEDEDE;
	border-radius:3px;
	-webkit-border-radius:3px;
	-moz-border-radius:3px;
}
</style>
<script type="text/javascript">
var reportStudent;
$(function(){
	reportStudent=new ReportStudent();
	reportStudent.load();
	$("#chk_ids").click(function(){
		if($(this).attr("checked")){
			$("input[name='chk_student_id']").attr('checked',true);
		}else{
			$("input[name='chk_student_id']").attr('checked',false);
		}
	});
	for(var i in  reportStudent.statusArray){
		$("#status").append("<option value='"+i+"'>"+reportStudent.statusArray[i]+"</option>");
	}
	
});

function ReportStudent(){
	this.statusArray=['待审核','审核通过','审核不通过','审核回退'];
	//加载
	this.load = function () {
		loadByPage('/student/list.action',{name:$("#name").val(),graduate:$("#graduate").val(),examYear:$("#examYear").val(),status:$("#status").val(),admit:$("#admit").val(),pageSize:5},this.showList, tableBody_3);
	};
	//显示列表
	this.showList= function(list){
		var tempStr="";
		for ( var key in list) {
			var item = list[key];
			tempStr +='<tr id="tr_'+item.id+'">'+
					'	<td><img class="listheadImage" src="'+item.headPicUrl+'"  onclick="reportStudent.view('+item.id+')" alt="单击查看['+item.name+']明细" title="单击查看['+item.name+']明细" /></td>'+
					'	<td>'+reportStudent.statusArray[item.status]+'</td>'+
					'	<td>'+item.name+'</td>'+
					'	<td>'+item.gender+ '</td>'+
					'	<td>'+item.certificateType+":"+ item.certificate + '</td>'+
					'	<td>'+item.enrollmentNumbers + '</td>'+
					'	<td>'+item.nationality + '</td>'+
					'	<td>'+item.nativePlace + '</td>'+
					'	<td>'+
					(item.domiciProvince?item.domiciProvince:'') +
					(item.domicilCity?item.domicilCity:'') + 
					(item.domicileArea?item.domicileArea:'') + 
					item.domicile + '</td>'+
					'	<td>'+(item.domiciProvince?item.domiciProvince:'') +
					(item.domicilCity?item.domicilCity:'') + 
					(item.domicileArea?item.domicileArea:'') + 
					item.graduate + '</td>'+ 
					'	<td>'+item.birthday.substring(0,10) + '</td>'+
					'	<td>'+item.phoneNumber + '</td>'+
					'	<td>'+(item.interview==1?'是':'否') + '</td>'+
					'	<td>'+(item.admit==1?'是':(item.admit==-1?'待公布':'否')) + '</td>'+
					'	<td><a href="javascript:reportStudent.view('+item.id+');">查看</a></td>'+
					'</tr>';
		}
		return tempStr;
		//$('#tableBody_3').html(tempStr);
	};
	//查看
	this.view = function (id){
		art.dialog.open('/student/view.action?id='+id,{
			title : '报名明细',
			width: '75%',
			height: '95%'
		});
	};
	//导出报表
	this.exportStudent = function (){
		excelExport('studentInfor', 'studentInfor', $("#searchForm").serialize());
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
	<legend class="legend_title">学生信息</legend>
		<div class="form_search_item" style="line-height:32px;">
			<div class="right">
				<form id="searchForm">
					年份：<input type="text" class="piece" style="width: 80px;" name="examYear" id="examYear"  value="${examYear }"  onfocus="WdatePicker({dateFmt:'yyyy'})" onkeydown="if(event.keyCode==13){reportStudent.load();}" />
					姓名：<input type="text" class="piece" style="width: 80px;" id="name" name="name" onkeydown="if(event.keyCode==13){reportStudent.load();}"/>
					学校：
					<select class="piece"  id="graduate" name="graduate" style="width: 80px;" onchange="reportStudent.load()" >
						<option value="">--全部--</option>
						<c:forEach var="item" items="${graduateList }">
							<option value="${item}">${item }</option>
						</c:forEach>
					</select>
					申请状态：
					<select  id="status" name="status" class="piece2" style="width: 80px;" onchange="reportStudent.load()">
						<option value="">全部</option> 
					</select>
					是否录取：<select  id="admit" name="admit" class="piece2" style="width: 80px;" onchange="reportStudent.load()">
						<option value="">全部</option>
						<option value="1">是</option>
						<option value="0">否</option>
						<option value="-1">待公布</option>
					</select>
					<a href="javascript: reportStudent.load()" class="base_btn"><span>搜索</span></a>
				</form>
			</div>
			<div class="left" style="margin-top: 5px;">
				<a href="javascript:reportStudent.exportStudent();" class="base_btn"><span>导出</span></a>
			</div>
		</div>
		<div class="clear"></div>
		<div   style="width: 100%;overflow: auto;">
			<table  class="table_border" >
				<tr class="head">
					<td style="min-width: 70px;" >照片</td>
					<td style="min-width: 70px;" >报名状态</td>
					<td style="min-width: 60px;" >姓名</td>
					<td style="min-width: 40px;" >性别</td>
					<td style="min-width: 80px;" >证件号码</td>
					<td style="min-width: 80px;" >小学籍号</td>
					<td style="min-width: 40px;" >民族</td>
					<td style="min-width: 40px;" >籍贯</td>
					<td style="min-width: 80px;" >户籍所在地</td>
					<td style="min-width: 80px;" >毕业学校</td>
					<td style="min-width: 80px;" >出生日期</td>
					<td style="min-width: 80px;" >手机号</td>
					<td style="min-width:60px;"  >是否面试</td>
					<td style="min-width:60px;"  >是否录取</td>
					<td style="min-width: 40px;">操作</td>
				</tr>
				<tbody id="tableBody_3"></tbody>
			</table>
		</div>
		
		<div class="clear"></div>
		<div class="table_under_btn" >
			<div class="flip">
			</div>
		</div><!--table_under_btn-->
</fieldset>
</body>
</html>