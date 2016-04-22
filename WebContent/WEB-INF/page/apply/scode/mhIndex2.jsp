<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>${title }</title>

<script type="text/javascript">
var mngScode;
$(function(){
	mngScode=new MngScode();
	mngScode.load();

	$("#chk_ids").click(function(){
		if($(this).attr("checked")){
			$("input[name='chk_student_id']").attr('checked',true);
		}else{
			$("input[name='chk_student_id']").attr('checked',false);
		}
	});
	
});

function MngScode(){
	this.load = function () {
		if ($("#minTotal").val()) {
			var t=$("#minTotal").val();
			if(!t.onlyDigit()){
				art.dialog.tips("最小总分输入有误");
				$("#minTotal").val("");
			};
		}
		if ($("#maxTotal").val()) {
			var t=$("#maxTotal").val();
			if(!t.onlyDigit()){
				art.dialog.tips("最大总分输入有误");
				$("#maxTotal").val("");
			};
		}
		loadByPage('/zd_student2/list.action',{examYear:$("#examYear").val(),name:$("#name").val(),interview:$("#interview").val(),admit:$("#admit").val(),canInterviewDateNull:false},this.showList);
	};
	this.showList= function(list){
		$('#tableBody').html('');
		for ( var key in list) {
			var item = list[key];

			$('#tableBody').append(
					'<tr id="tr_'+item.id+'">'+
					'	<td><input type="checkbox" name="chk_student_id" value="'+item.id+'" /></td>'+
					'	<td title="'+item.graduate +'" >'+item.graduate + '</td>'+
					'	<td title="'+item.name +'" >'+item.name+'</td>'+
					'	<td>'+item.gender+ '</td>'+
					'	<td title="'+item.homePhone +'" >'+item.homePhone + '</td>'+
					'	<td>'+(item.interviewDate?item.interviewDate:'')+ '</td>'+
					'	<td>'+(item.interview==1?'是':'否') + '</td>'+
					'	<td>'+(item.admit==1?'是':(item.admit==-1?'待公布':'否')) + '</td>'+
					'	<td>'+(item.interviewScore?item.interviewScore:'')+ '</td>'+
					'	<td> '+
					'		<a href="javascript:mngScode.edit('+item.id+');">修改成绩</a>'+
					'		<a href="javascript:mngScode.view('+item.id+');">查看</a>'+
					'  </td>'+
					'</tr>'
			);  
		}
	};
	//查看
	this.view = function (id){
		art.dialog.open('/zd_student2/view.action?id='+id,{
			title : '报名明细',
			width: '75%',
			height: '95%'
		});
	};
	
	//修改分数
	this.edit = function (id){
		art.dialog.open('/mh_scode/toEdit.action?examType=0&id='+id,{
			title : '个人成绩',
			width:'400px',
			height:'350px'
		});
	};
	//录取/不录取/待公布  操作
    this.changeAdmit = function (admit){
    	var ids=[];
		var names=[];
		var temp="";
		if(admit==1){
			temp="录取";
		}else if(admit==0){
			temp="不录取";
		}else if(admit==-1){
			temp="待公布";
		}
		$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
			ids.push($(this).val());
			names.push($(this).parent().next().next().text());
		});
		if(ids.length==0){
			art.dialog.alert("请选择要"+temp+"的项");
			return;
		}
		
		if(admit==-1){//待公布
			art.dialog.confirm("您确定要把 [ "+names.join(",")+" ]的录取状态设置成" + temp + " 吗？", function(){
				$.post('/mh_scode/saveAdmit.action',{ids:ids.join(','),admit:admit,examType:0},function(data){
				    if(data.code=='succeed'){
						art.dialog({icon:'succeed',title:'操作结果',  content: temp+ '操作成功',time:1});
						mngScode.load();
					}else{
						art.dialog({icon:'error',title:'操作结果',  content: temp+  '操作失败',time:1});
					} 
				},'json');
			});
		}else{//不录取或录取
			
			art.dialog.open('/zd_student2/toCheckRemark.action?examType=0&admit=' + admit + '&ids='+ids.join(',')+'&names='+names.join(','),{
				title:temp+'备注',
				width:'500px',
				height:'200px'
			});
			
		}
	};
	//导入分数
	this.importScode = function (){
		excelImport('&workbook=interviewResult', '面试成绩导入', '');
	};
	//下载模版
    this.downScodeTemp = function (){
    	art.dialog.open('/mh_scode/selectExam.action',{
   			title:'模版数据选项',
   			width:'300px',
   			ok:function(){
   				var iframe=this.iframe.contentWindow;
   				var examId=$(iframe.document.getElementById("exam")).val();
   				examId=examId?'examId='+examId:'';
   		    	excelExport('interviewScoreMH', 'scope_template', examId);
   		    	return true;
   			},
   			cancel:true
   		});
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
	   					mngScode.load();
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
	
	var ids = [];
	$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
		ids.push($(this).val());
	});
	window.location.href='/excel/export.action?workbook='+workbook+'&sheet=Sheet1&ids=' + ids +(fileName?'&fileName='+fileName:'')+(params?'&'+params:'');
}
</script>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">成绩管理</legend>
		<div class="form_search_item">
			<div class="right">
				<form id="searchForm">
					<input type="hidden" name="status" id="status" value="1" /><!-- 只筛选审核通过的的学生 -->
					年份<input type="text" class="piece" style="width: 80px;" name="examYear" id="examYear"  value="${examYear }"  onfocus="WdatePicker({dateFmt:'yyyy'})"  onchange="mngScode.load()" />
					学生姓名：<input type="text" class="piece" style="width:80px;" id="name" name="name" onkeydown="if(event.keyCode==13){mngScode.load();}"/>
					总分：<input name="minTotal" id="minTotal"  class="piece2"  onkeydown="if(event.keyCode==13){mngScode.load();}" style="width:40px;"/> 至 <input name="maxTotal"  id="maxTotal" class="piece2"  onkeydown="if(event.keyCode==13){mngScode.load();}"  style="width:40px;"/>
					是否参加面试：<select  id="interview" name="interview" class="piece2" onchange="mngScode.load()" >
						<option value="">全部</option>
						<option value="1">是</option>
						<option value="0">否</option>
					</select>
					是否录取：<select  id="admit" name="admit" class="piece2" style="width: 80px;"  onchange="mngScode.load()" >
						<option value="">全部</option>
						<option value="1">是</option>
						<option value="0">否</option>
						<option value="-1">待公布</option>
					</select>
					<a href="javascript: mngScode.load()" class="base_btn"><span>搜索</span></a>
				</form>
			</div>
			<div class="clear"></div>
		</div>
		<div class="form_search_item">
			<div class="left">
				<a href="javascript:mngScode.changeAdmit(1);" class="base_btn"><span>录取</span></a>
				<a href="javascript:mngScode.changeAdmit(0);" class="base_btn"><span>不录取</span></a>
				<a href="javascript:mngScode.changeAdmit(-1);" class="base_btn"><span>待公布</span></a>
				<!-- <a href="javascript:mngScode.importScode()" class="base_btn"><span>导入成绩</span></a> -->
				<a href="javascript:excelExport('interviewScoreMH2', 'scope_template');" class="base_btn" ><span>导出</span></a>
			</div>
			<div class="clear"></div>
		</div>
		<div id="scrollDiv">
			<table  class="table_border column_move_table">
				<tr class="head">
					<td style="width:30px;" class="thead" > <input type="checkbox" id="chk_ids"/></td>
					<td style="width:60px;" class="thead" >毕业学校</td>
					<td style="width:60px;" class="thead" >姓名</td>
					<td style="width:40px;" class="thead" >性别</td>
					<td style="width:60px;" class="thead" >联系电话</td>
					 <td style="width:60px;" class="thead" >面试日期</td>
					<td style="width:60px;" class="thead" >是否面试</td>
					<td style="width:60px;" class="thead" >是否录取</td>
					<td style="width:60px;" class="thead" >面试成绩</td>
					<!-- <td style="width:150px;" class="thead" >家长电话</td> -->
					<td style="width:100px">操作 </td>
				</tr>
				<tbody id="tableBody"></tbody>
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