<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
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
	
	$("#status").val("0");//默认查询待审核的
	mngStudent.load();
});

function ManagerStudent(){
	this.statusArray=['待审核','审核通过','审核不通过','审核回退']; //报名状态：0待审核;1审核通过；2审核不通过；3审核回退
	this.load = function () {
		loadByPage('/student/list.action',{name:$("#name").val(),examYear:$("#examYear").val(),gender:$("#gender").val(),status:$("#status").val(),admit:$("#admit").val(),graduate:$("#graduate").val(),pageSize:5},this.showList);
	};
	this.showList= function(list){
		var tempStr="";
		for ( var key in list) {
			var item = list[key];
			var tempdomicil=item.domicileArea;
			var tempgraduate=item.graduateArea;
			if (tempdomicil!="其他") {
				tempdomicil=item.domiciProvince+item.domicilCity+item.domicileArea+item.domicile;
			}else{
				tempdomicil=item.domicile;
			}
			if (tempgraduate!="其他") {
				tempgraduate=item.graduateProvince+item.graduateCity+item.graduateArea+item.graduate;
			}else{
				tempgraduate=item.graduate;
			}
			tempStr +='<tr id="tr_'+item.id+'">'+
					'	<td><input type="checkbox" name="chk_student_id" value="'+item.id+'" /><input type="hidden" name="chk_student_status" value="'+item.status+'" /></td>'+
					'	<td><img class="listheadImage" src="' +item.headPicUrl +'"  onclick="mngStudent.view('+item.id+')" alt="单击查看['+item.name+']明细" title="单击查看['+item.name+']明细" /></td>'+
					'	<td>'+mngStudent.statusArray[item.status]+'</td>'+
					'	<td title="'+item.name+'">'+item.name+'</td>'+
					'	<td>'+item.account+'</td>'+
					'	<td>'+item.gender+ '</td>'+
					'	<td>'+item.certificate +'('+ item.certificateType + ')</td>'+
					'	<td>'+tempgraduate + '	</td>'+
					'	<td>'+tempdomicil + '</td>'+
					'	<td>'+item.updateTime.substring(0,10) + '	</td>'+
					'	<td>'+(item.interviewDate?item.interviewDate+(item.batch?'<br/>'+item.batch:''):'未定')+ '</td>'+
					'	<td> '+
						' <a href="javascript:mngStudent.view('+item.id+');">查看</a><br/> '+
						' <a href="javascript:mngStudent.edit('+item.id+');">修改</a> '+
						'</td>'+
					'</tr>';
		}
		$('#tableBody').html(tempStr);
	};
	this.edit=function(id){
		art.dialog.open('/student/toEdit.action?id='+id,{
			title : '修改报名信息',
			width: '75%',
			height: '95%'
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
			$.post('/student/delete.action',{ids:ids.join(',')},function(data){
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
		art.dialog.open('/student/view.action?id='+id,{
			title : '报名明细',
			width: '75%',
			height: '95%'
		});
	};
	//status 报名状态：0待审核;1审核通过；2审核不通过；3审核回退
	this.changeStatus =function (status){
		var ids=[];
		var names=[];
		var temp="";
		if(status==1){
			temp="审核通过";
		}else if(status==2){
			temp="审核不通过";
		}else if(status==3){
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
				$.post('/student/doChangeStatus.action',{ids:ids.join(','),status:status},function(data){
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
			art.dialog.open('/student/toCheckRemark.action?status='+status+"&ids="+ids.join(',')+"&names="+names.join(','),{
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
			$.post('/student/updatePassword.action',{ids:ids.join(',')},function(data){
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
			names.push($(this).parent().next().next().next().text());
			/* if($(this).parent().next().next().text() !="审核通过"){
				notpassNames.push($(this).parent().next().next().next().text());
			} */
		});
		
		if(notpassNames.length>0){
			art.dialog.alert('【' + notpassNames.join(',')  +'】审核尚未通过，不能设置面试时间');
			return;
		}
		
		if(!ids || ids.length==0){
			art.dialog.tips("您尚未选择任何学生项");
			return;
		}
		art.dialog.open('/student/toSetInterViewDate.action?ids='+ids.join(',')+"&names="+names.join(','),{
			title : '设置学生面试时间',
			width : 'auto',
			height : 'auto'
		});
	};
	//进入打印界面
	this.printList = function (){
		var examYear=$("#examYear").val();
		var name=$("#name").val();
		var gender=$("#gender").val();
		var status=$("#status").val();
		var ids=[];
		$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
			ids.push($(this).val());
		});
		var url="";
		if(ids.length==0){
			art.dialog.confirm('您没选择任何要打印的学生，确定要打印全部符合当前查询条件的学生吗？',function(){
				url="/student/toPrintPage.action?examYear="+examYear+"&name="+name+"&gender="+gender+"&status="+status;
				window.open(url);
			});
		}else{
			url="/student/toPrintPage.action?ids="+ids.join(',');
			window.open(url);
		}
	};
	//打开导入面试时间/批次界面
	this.showInportInterviewDate=function (){
		excelImport('&workbook=interviewDateAndBatch', '导入面试日期和批次', '');
	};
	//下载面试时间/批次导入模版
	this.downStudentTemp=function(){
		excelExport('interviewDateAndBatch','导入面试日期和批次模版');
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
					<a href="javascript:mngStudent.load()" class="base_btn"><span>搜索</span></a>
				</form>
			</div>
			<div class="clear"></div>
		</div>
		<div class="form_search_item">
			<div class="left">
				<a href="javascript:mngStudent.changeStatus(1);" class="base_btn"><span>审核通过</span></a>
				<a href="javascript:mngStudent.changeStatus(2);" class="base_btn"><span>审核不通过</span></a>
				<a href="javascript:mngStudent.changeStatus(3);" class="base_btn"><span>审核回退</span></a>
				<a href="javascript:mngStudent.initPassword()" class="base_btn" title="点击初始化密码为123456"><span>初始化密码</span></a>
				<a href="javascript:mngStudent.setInterviewDate();" class="base_btn"><span>设置面试时间</span></a>
				<a onclick="mngStudent.printList()"   class="base_btn"><span>打印学生</span></a>
				<a href="javascript:mngStudent.showInportInterviewDate();" class="base_btn"><span>导入面试时间/批次</span></a>
				<a href="javascript:mngStudent.downStudentTemp()">下载导入模版</a>
			</div>
			<div class="clear"></div>
		</div>
		<table  class="table_border">
			<tr class="head">
				<td style="min-width: 30px;" class="thead"> <input type="checkbox" id="chk_ids"/></td>
				<td style="min-width: 70px;" class="thead">照片</td>
				<td style="min-width: 70px;" class="thead">报名状态</td>
				<td style="min-width: 60px;" class="thead">姓名</td>
				<td style="min-width: 60px;" class="thead">登录帐号</td>
				<td style="min-width: 40px;" class="thead">性别</td>
				<td style="min-width: 60px;" class="thead">证件</td>
				<td style="min-width: 60px;" class="thead">毕业学校</td>
				<td style="min-width: 80px;" class="thead">户籍所在地</td>
				<td style="min-width: 80px;" class="thead">报名日期</td>
				<td  class="thead">面试时间</td>
				<td style="min-width: 40px;">操作</td>
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