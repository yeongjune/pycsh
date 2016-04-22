<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title }</title>
<script type="text/javascript">
var mngStudent;
$(function(){
	$("#chk_ids").click(function(){
		if($(this).attr("checked")){
			$("input[name='chk_student_id']").attr('checked',true);
		}else{
			$("input[name='chk_student_id']").attr('checked',false);
		}
	});
	mngStudent=new ManagerStudent();
	mngStudent.load();
});

function ManagerStudent(){
	this.load = function () {
		loadByPage('/dzStudent2/list.action',{year:$("#year").val(),keyword:$("#keyword").val(),pageSize:10},this.showList);
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
			tempStr +='<tr id="tr_'+item.id+'">'+
					'	<td>'
							+'<input type="checkbox" name="chk_student_id" value="'+item.id+'" />'+
					'	</td>'+
					'	<td>'+index+'</td>'+
					'	<td>'+item.name+'</td>'+
					'	<td>'+item.usedName+'</td>'+
					'	<td>'+item.gender+ '</td>'+
					'	<td>'+item.iDCard+'</td>' +
					'	<td>'+item.graduate + '	</td>'+
					'	<td>'+tempdomicil + '</td>'+
					'	<td> '+
						' <a href="javascript:mngStudent.view('+item.id+');">查看</a> '+
						'</td>'+
					'</tr>';
		}
		$('#tableBody').html(tempStr);
	};
	//删除
	this.delMulti =function (){
		var ids=[];
		var names=[];
		$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
			ids.push($(this).val());
			names.push($(this).parent().next().next().text());
		});
		if(!ids || ids.length==0){
			art.dialog.tips("您尚未选择任何要删除项");
			return;
		}
		art.dialog.confirm("您确定要删除 [ "+names.join(",")+" ] 的报名信息吗？", function(){
			$.post('/dzStudent2/delete.action',{ids:ids.join(',')},function(data){
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
	//显示详情
	this.view = function (id){
		art.dialog.open('/dzStudent2/view.action?id='+id,{
			title : '小学新生报名明细',
			width: '75%',
			height: '95%'
		});
	};
	
	//excel导出
	this.excelExport = function (){
		var ids=[];
		var names=[];
		var year=$('#year').val();
		$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
			ids.push($(this).val());
			names.push($(this).parent().next().next().text());
		});
		if(ids.length > 0){
			art.dialog.confirm('您选中了 [ '+names.join(",")+' ]，是否要导出?',function(){
				excelExport('dzStudent2',(year?year+'年':'')+'民航子弟学校小学新生报名信息',(year?('year='+year+'&'):'')+'ids='+ids.join(','));
			});
		}else{
			if(year){
				art.dialog.confirm('您没有选中任何学生,将导出'+year+'年民航子弟学校小学所有新生报名信息，请确认？',function(){
					excelExport('dzStudent2',year+'年民航子弟学校小学所有新生报名','year='+year);
				});
			}else{
				art.dialog.confirm('您没有选择年份和任何学生，将导出所有包括以往年份的报名记录信息，请确认?',function(){
					excelExport('dzStudent2','民航子弟学校小学所有新生报名(包括往年)');
				});
			}
		}
	};
	//打印
	this.print = function(){
		var ids=[];
		var names=[];
		var year=$('#year').val();
		$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
			ids.push($(this).val());
			names.push($(this).parent().next().next().text());
		});
		if(ids.length > 0){
			art.dialog.confirm('您选中了 [ '+names.join(",")+' ]，请确认是否要打印(点击确认将进入打印预览)?',function(){
				window.open( '/dzStudent2/toPrint.action?'+(year?('year='+year+'&'):'')+'ids='+ids.join(','));
			});
		}else{
			if(year){
				art.dialog.confirm('您没有选中任何学生,将打印'+year+'年民航子弟学校小学所有新生报名信息，请确认(点击确认将进入打印预览)？',function(){
					window.open( '/dzStudent2/toPrint.action?'+'year='+year);
				});
			}else{
				art.dialog.confirm('您没有选择年份和任何学生，将打印所有包括以往年份的报名记录信息，请确认(点击确认将进入打印预览)?',function(){
					window.open( '/dzStudent2/toPrint.action');
				});
			}
		}
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
	<legend class="legend_title">小学新生报名管理</legend>
		<div class="form_search_item">
			<div class="left">
					<a href="javascript:mngStudent.excelExport()" class="base_btn"><span>导出Excel</span></a>
					<a href="javascript:mngStudent.print()" class="base_btn"><span>打印</span></a>
			</div>
			<div class="right">
					年份：<input type="text" class="piece" style="width: 80px;" name="year" id="year"  value="${year }"  onfocus="WdatePicker({dateFmt:'yyyy'})" onchange="mngStudent.load()" />
					关键字：<input type="text" class="piece" style="width:200px" placeholder="姓名/曾用名/身份证" id="keyword"  onkeydown="if(event.keyCode==13){mngStudent.load();}" />
					<a href="javascript:mngStudent.load()" class="base_btn"><span>搜索</span></a>
			</div>
			<div class="clear"></div>
		</div>
		<table  class="table_border">
			<tr class="head">
				<td style="min-width: 30px;" class="thead"> 
					<input type="checkbox" id="chk_ids"/>
				</td>
				<td width="40px">行号</td>
				<td style="min-width: 60px;" class="thead">姓名</td>
				<td style="min-width: 60px;" class="thead">曾用名</td>
				<td style="min-width: 40px;" class="thead">性别</td>
				<td style="min-width: 60px;" class="thead">身份证号</td>
				<td style="min-width: 60px;" class="thead">毕业幼儿园</td>
				<td style="min-width: 80px;" class="thead">户口所在</td>
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