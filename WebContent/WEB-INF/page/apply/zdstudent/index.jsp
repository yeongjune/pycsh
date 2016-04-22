<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
var mngStudent;
$(function(){
	mngStudent=new ManagerStudent();

	$("#chk_ids").click(function(){
		if($(this).attr("checked")){
			$("input[name='chk_student_id']").attr('checked',true);
		}else{
			$("input[name='chk_student_id']").attr('checked',false);
		}
	});
	for(var i in  mngStudent.statusArray){
		$("#status").append("<option value='"+i+"'>"+mngStudent.statusArray[i]+"</option>");
	}
	
	$("#status").val("");//默认查询待审核的
	mngStudent.load();
});

function ManagerStudent(){
	this.statusArray=['待审核','审核通过','审核不通过']; //报名状态：0待审核;1审核通过；2审核不通过
	this.load = function () {
		loadByPage('/zd_student/list.action',{name:$("#name").val(),examYear:$("#examYear").val(),gender:$("#gender").val(),status:$("#status").val(),admit:$("#admit").val(),graduate:$("#graduate").val(),pageSize:10, isSetRoomNo:$('#isSetRoomNo').val()},this.showList);
	};
	this.showList= function(list){
		var tempStr="";
		var index=getIndex(list);
		for ( var key in list) {
			index++;
			var item = list[key];
			var tempdomicil="p省c市a区";
			if(item.domicileArea){
				tempdomicil=tempdomicil.replace('p',item.domiciProvince).replace('c',item.domicilCity).replace('a区',item.domicileArea);
			}else{
				tempdomicil=tempdomicil.replace('p省','').replace('c',item.domiciProvince).replace('a',item.domicilCity);
			}
			
			var number = item.number ;
			if(number > 999){
				number = (2015 + '' + number);
			}else if(number > 99){
				number = (2015 + '0' + number);
			}else if(number > 9){
				number = (2015 + '00' + number);
			}else{
				number = (2015 + '000' + number);
			}
			
			tempStr +='<tr id="tr_'+item.id+'">'+
					'	<td>'
							+'<input type="checkbox" name="chk_student_id" value="'+item.id+'" />'+
					'	</td>'+
					'	<td>'+index+'</td>'+
					'	<td>'+mngStudent.statusArray[item.status]+'</td>'+
					'	<td>'+item.name+'</td>'+
					'	<td>'+ number + '</td>'+
					'	<td>'+item.gender+ '</td>'+
					'	<td>'+item.IDCard+'</td>' +
					'	<td>'+item.inSchoolNo + '	</td>'+
					'	<td>'+item.graduate + '	</td>'+
					'	<td>'+item.updateTime.substring(0,10) + '	</td>'+
					'	<td>'+(item.interviewDate?item.interviewDate:'未定')+ '	</td>'+
					'	<td>'+item.testCard + '</td>'+
					'	<td>'+tempdomicil + '</td>'+
					'	<td> '+
						' <a href="javascript:mngStudent.editTestCard('+item.id+');">设置准考证号</a> '+
						' <a href="javascript:mngStudent.view('+item.id+');">查看</a> '+
						/* ' <a href="javascript:mngStudent.edit('+item.id+');">修改</a> '+ */
						'</td>'+
					'</tr>';
		}
		$('#tableBody').html(tempStr);
	};
	this.edit=function(id){
		art.dialog.open('/zd_student/toEdit.action?id='+id,{
			title : '修改报名信息',
			width: '75%',
			height: '95%'
		});
	};
	this.editTestCard=function(id){
		art.dialog.open('/zd_student/toEditTestCard.action?id='+id,{
			title : '设置准考证号',
			width: '30%',
			height: '20%'
		});
	};
	this.delMulti =function (){
		var ids=[];
		var names=[];
		$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
			ids.push($(this).val());
			names.push($(this).parent().next().next().next().text());
		});
		if(!ids || ids.length==0){
			art.dialog.tips("您尚未选择任何要删除项");
			return;
		}
		art.dialog.confirm("您确定要删除 [ "+names.join(",")+" ] 的报名信息吗？", function(){
			$.post('/zd_student/delete.action',{ids:ids.join(',')},function(data){
				if(data.code=='succeed'){
					for (var index in ids) {
						$('#tr_'+ids[index]).remove();
					}
				}else if(data.code=='false'){
					art.dialog.tips('未进入站点管理');
				}else{
					art.dialog.tips('删除失败');
				}
			},'json');
		});
	};
	this.view = function (id){
		art.dialog.open('/zd_student/view.action?id='+id,{
			title : '报名明细',
			width: '75%',
			height: '95%'
		});
	};
	//status 报名状态：0待审核;1审核通过；2审核不通过
	this.changeStatus =function (status){
		var ids=[];
		var names=[];
		var temp="";
		if(status==1){
			temp="审核通过";
		}else if(status==2){
			temp="审核不通过";
		}else if(status==0){
			temp="审核回退";
		}
		$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
			ids.push($(this).val());
			names.push($(this).parent().next().next().next().text());
		});
		if(ids.length==0){
			art.dialog.alert("请选择要"+temp+"的项");
			return;
		}
		if (status==1) {//审核通过
			art.dialog.confirm("您确定要"+temp+" [ "+names.join(",")+" ] 吗？", function(){
				$.post('/zd_student/doChangeStatus.action',{ids:ids.join(','),status:status},function(data){
				    if(data.code=='succeed'){
						art.dialog({icon:'succeed',title:'操作结果',  content: temp+ '操作成功',time:1});
						mngStudent.load();
					}else if(data.code=='false'){
						art.dialog.tips('未进入站点管理');
					}else{
						art.dialog({icon:'error',title:'操作结果',  content: temp+  '操作失败',time:1});
					}
				},'json');
			});
		}else{//审核回退或审核不通过
			art.dialog.open('/zd_student/toCheckRemark.action?status='+status+"&ids="+ids.join(',')+"&names="+names.join(','),{
				title:temp+'备注',
				width:'500px',
				height:'200px'
			});
		}
		
	};
	//初始化密码
	this.initPassword =function (){
		var ids=[];
		var names=[];
		$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
			ids.push($(this).val());
			names.push($(this).parent().next().next().next().text());
		});
		if(ids.length==0){
			art.dialog.alert("请选择要初始化密码的项");
			return;
		}

		art.dialog.confirm("您确定要初始化 [ "+names.join(",")+" ] 的密码吗？", function(){
			$.post('/zd_student/updatePassword.action',{ids:ids.join(',')},function(data){
			    if(data.code=='succeed'){
					art.dialog({icon:'succeed',title:'操作结果',content: '成功初始化 [ '+names.join(',')+ ' ] 的密码为：'+data.msg});
					mngStudent.load();
				}else if(data.code=='false'){
					art.dialog.tips('未进入站点管理');
				}else{
					art.dialog({icon:'error',title:'操作结果',content: '初始化密码失败',time:1});
				} 
			},'json');
		});
	};
	//设置面试日期时间
	this.setInterviewDate = function(){
		var ids=[];
		var names=[];
		var notpassNames=[];
		$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
			ids.push($(this).val());
			names.push($(this).parent().next().next().text());
			if($(this).parent().next().next().text() !="审核通过"){
				notpassNames.push($(this).parent().next().next().next().text());
			}
		});
		
		if(notpassNames.length>0){
			art.dialog.alert('【' + notpassNames.join(',')  +'】审核尚未通过，不能设置面试时间');
			return;
		}
		
		if(!ids || ids.length==0){
			art.dialog.tips("您尚未选择任何学生项");
			return;
		}
		art.dialog.open('/zd_student/toSetInterViewDate.action?ids='+ids.join(',')+"&names="+names.join(','),{
			title : '设置学生面试时间',
			width : 'auto',
			height : 'auto'
		});
	};

	//重置面试日期时间
	this.resetInterviewDate = function(){
		var ids=[];
		var names=[];
		var notpassNames=[];
		$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
			ids.push($(this).val());
			names.push($(this).parent().next().next().text());
			/* if($(this).parent().next().next().text() !="审核通过"){
				notpassNames.push($(this).parent().next().next().next().text());
			} */
		});
		
		if(!ids || ids.length==0){
			art.dialog.tips("您尚未选择任何学生项");
			return;
		}
		$.post('/zd_student/resetInterViewDate.action?ids='+ids.join(',')+"&names="+names.join(','),function(data){
			if('succeed' == data){
				art.dialog.alert('重置成功！');
				mngStudent.load();
			}
		});
	};
	
	//设置面试日期时间
	this.setRoomNo = function(){
		var ids=[];
		var names=[];
		var statusNotpassNames=[];
		var timeNotpassNames=[];
		$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
			ids.push($(this).val());
			names.push($(this).parent().next().next().next().text());
			if($(this).parent().next().next().text() !="审核通过"){
				statusNotpassNames.push($(this).parent().next().next().next().text());
			}
			if($(this).parent().next().next().next().next().next().next().next().next().next().text().trim() == '未定'){
				timeNotpassNames.push($(this).parent().next().next().next().text());
			}
		});
		
		if(statusNotpassNames.length>0){
			art.dialog.alert('【' + statusNotpassNames.join(',')  +'】审核尚未通过，不能设置考室');
			return;
		}

		if(timeNotpassNames.length>0){
			art.dialog.alert('【' + timeNotpassNames.join(',')  +'】尚未设置面试时间，不能设置考室');
			return;
		}
		
		if(!ids || ids.length==0){
			art.dialog.tips("您尚未选择任何学生项");
			return;
		}
		art.dialog.open('/zd_student/toSetRoomNo.action?ids='+ids.join(',')+"&names="+names.join(','),{
			title : '设置学生面试课室',
			width : 'auto',
			height : 'auto'
		});
	};
	
	//打印
	this.print = function(){
		var ids=[];
		var names=[];
		var year=$('#year').val();
		$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
			ids.push($(this).val());
			names.push($(this).parent().next().next().next().text());
		});
		if(ids.length > 0){
			art.dialog.confirm('您选中了 [ '+names.join(",")+' ]，请确认是否要打印(点击确认将进入打印预览)?',function(){
				window.open( '/zd_student/toPrint.action?'+(year?('year='+year+'&'):'')+'ids='+ids.join(','));
			});
		}else{
			if(year){
				art.dialog.confirm('您没有选中任何学生,将打印'+year+'年民航子弟学校初中所有新生报名信息，请确认(点击确认将进入打印预览)？',function(){
					window.open( '/zd_student/toPrint.action?'+'year='+year);
				});
			}else{
				art.dialog.confirm('您没有选择年份和任何学生，将打印所有包括以往年份的报名记录信息，请确认(点击确认将进入打印预览)?',function(){
					window.open( '/zd_student/toPrint.action');
				});
			}
		}
	};
	
	//打开导入面试时间/批次界面
	this.showInportInterviewDate=function (){
		excelImport('&workbook=interviewDateAndBatch1', '导入面试日期和批次', '');
	};
	//下载面试时间/批次导入模版
	this.downStudentTemp=function(){
		excelExport('interviewDateAndBatch1','导入面试日期和批次模版');
	};
}

/**
 * excel导入
 * @param params 写法：&a=a&b=a
 * @param title
 * @param tip 导入说明 
 */
function excelImport(params, title, tip){
	title = title?title:'数据导入';
	art.dialog.open('/excel/entryImport.action?tip='+tip+params,
			{
				id: 'excelImportDialog',
				width:'500px',
				height:'250px',
				border:false,
				padding:0,
				lock: true,
				title: title,
			    background: 'white', // 背景色
			    opacity: 0.5,	// 透明度
				drag: true,
				fixed: true,
				zIndex: 0,
				esc: true,
				resize: false,
				close:function(){
					var iframe=this.iframe.contentWindow;
	   				var succeed=$(iframe.document).find(".work_progressbar .work_progressbar_text").text();
	   				if(succeed=="导入成功"){
	   					mngStudent.load();
	   				}
				}
			});
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
	<legend class="legend_title">考生信息管理</legend>
		<div class="form_search_item">
			<div class="right">
				<form id="searchForm">
					年份：<input type="text" class="piece" style="width: 80px;" name="examYear" id="examYear"  value="${examYear }"  onfocus="WdatePicker({dateFmt:'yyyy'})" onchange="mngStudent.load()" />
					姓名：<input type="text" class="piece" style="width: 120px;" id="name" name="name" onkeydown="if(event.keyCode==13){mngStudent.load();}"/>
					学校：<input type="text" class="piece" style="width:120px" id="graduate"  onkeydown="if(event.keyCode==13){mngStudent.load();}" />
					性别：
					<select  id="gender" name="gender" class="piece2" onchange="mngStudent.load()">
						<option value="">全部</option>
						<option value="男">男</option>
						<option value="女">女</option>
					</select>
					申请状态：
					<select  id="status" name="status" class="piece2" style="width: 95px;" onchange="mngStudent.load()" >
						<option value="">全部</option> 
					</select>
					是否已设置考室：
					<select  id="isSetRoomNo" name="isSetRoomNo" class="piece2" style="width: 95px;" onchange="mngStudent.load()" >
						<option value="0">全部</option> 
						<option value="1">是</option> 
						<option value="2">否</option> 
					</select>
					<a href="javascript:mngStudent.load()" class="base_btn"><span>搜索</span></a>
				</form>
			</div>
			<div class="clear"></div>
		</div>
		<div class="form_search_item">
			<div class="left">
				<a href="javascript:mngStudent.changeStatus(1);" class="base_btn"><span>审核通过</span></a>
				<a href="javascript:mngStudent.changeStatus(2);" class="base_btn"><span>审核不通过</span></a>
				<a href="javascript:mngStudent.changeStatus(0);" class="base_btn"><span>审核回退</span></a>
				<a href="javascript:mngStudent.initPassword()" class="base_btn" title="点击初始化密码为123456"><span>初始化密码</span></a>
				<a href="javascript:mngStudent.setInterviewDate();" class="base_btn"><span>设置面试时间</span></a>
				<a href="javascript:mngStudent.resetInterviewDate();" class="base_btn"><span>重置面试时间</span></a>
				<a href="javascript:mngStudent.setRoomNo();" class="base_btn"><span>设置考室</span></a>
				<a onclick="mngStudent.print()"   class="base_btn"><span>打印学生</span></a>
				<a href="javascript:mngStudent.showInportInterviewDate();" class="base_btn"><span>导入面试时间/批次</span></a>
				<a href="javascript:mngStudent.downStudentTemp()">下载导入模版</a>
			</div>
			<div class="clear"></div>
		</div>
		<table  class="table_border">
			<tr class="head">
				<td style="min-width: 30px;" class="thead"> <input type="checkbox" id="chk_ids"/></td>
				<td width="40px">行号</td>
				<td style="min-width: 60px;" class="thead">审核状态</td>
				<td style="min-width: 60px;" class="thead">姓名</td>
				<td style="min-width: 60px;" class="thead">编号</td>
				<td style="min-width: 40px;" class="thead">性别</td>
				<td style="min-width: 60px;" class="thead">身份证号</td>
				<td style="min-width: 60px;" class="thead">学籍号</td>
				<td style="min-width: 60px;" class="thead">毕业学校</td>
				<td style="min-width: 60px;" class="thead">报名日期</td>
				<td style="min-width: 60px;" class="thead">面试时间</td>
				<td style="min-width: 50px;" class="thead">准考证号</td>
				<td style="min-width: 80px;" class="thead">户籍所在地</td>
				<td style="min-width: 50px;">操作</td>
			</tr>
			<tbody id="tableBody"></tbody>
		</table>
		<div class="table_under_btn" >
			<a href="javascript:mngStudent.delMulti()" class="base_btn" style="float: left;" id="deleteMulti"><span>删除</span></a>
			<div class="flip">
			</div>
		</div><!--table_under_btn-->
		<div class="clear"></div>
</fieldset>
</body>
</html>