<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>摇号结果</title>
</head>
<body>
	
	<!-- 头部 -->
	<c:import url="../common/head.jsp" />

	<!--主体main开始-->
    <div class="main">
        <!--主体main的右侧菜单开始-->
        <div class="main_left">
        <div class="ul_li1"><a href="/lottery/student/index.action" >参加学生</a></div>
        <div class="ul_li2"><a href="/lottery/student/index.action">学生管理</a></div>
        <div class="ul_li3"><a href="/lottery/lotterys.action" >摇号选项</a></div>
        <div class="ul_li4"><a href="/lottery/lotterys.action" >摇号管理</a></div>
        <div class="ul_li5"><a href="/lottery/index.action">进入摇号</a></div>
        <div class="ul_li6"><a href="/lottery/student/result1.action">摇号结果</a></div>
        <div class="ul_li7"><a href="/lottery/student/result1.action" ${status == 1 ? 'class="hover"' : ''}>摇中名单</a></div>
        <div class="ul_li8"><a href="/lottery/student/result2.action" ${status == 0 ? 'class="hover"' : ''}>候补名单</a></div>
        <%-- <div class="ul_li8"><a href="/lottery/student/result3.action" ${status == 0 ? 'class="hover"' : ''}>未中名单</a></div> --%>
        
    </div>
        <!--主体main的右侧菜单结束-->

        <!--主体main的左侧可更换内容开始-->
        <div class="main_right">
        <div class="content">
        <div class="main_right_title">
        <div class="left">
        	<%-- <a href="javascript:studentManager.exportPart( )" class="a1">导出选中</a>
        	<c:if test="${status == 1 }">
        	</c:if> --%>
        	<a href="javascript:studentManager.exportAll()" class="a1">导出全部</a>
        </div>
        <div class="right">
     <form class="form"> 
        <select name="lotteryId" id="lotteryId" class="select" style="background: none;width:220px;">
				<c:forEach var="lottery" items="${list }">
					<option value="${lottery.id }">${lottery.title }</option>
				</c:forEach>
		</select>
        <!-- <span class="select">测试</span> -->
        <input class="" name="title" type="text"  id="keyword" onkeydown="if(event.keyCode==13){studentManager.load();}" />
        <input name="Submit2" value="搜索" class="submit" type="button" onclick="javascript:studentManager.load()"/>
        </form>
        </div>
        <div class="clear"></div>
        </div>
        
        <table class="table" width="100%"  cellspacing="0" cellpadding="0" id="main_table">
          <tr class="border">
            <td width="50" height="44"><input type="checkbox" id="chk_ids"/></td>
            <td height="44">姓名</td>
            <td height="44">性别</td>
            <!-- <td height="44">出生年月日</td> -->
            <td height="44">毕业学校</td>
            <!--<td height="44">身份证号码</td>
             <td height="44">小升初报名编码</td>-->
            <td height="44">全国学籍号</td>
            <!-- <td height="44">父亲联系电话</td> 
            <td height="44">母亲联系电话</td>  -->
            <td height="44">状态</td>
            <td height="44">随机号码 <a href="javascript:studentManager.load(1);">↑&nbsp;</a><a href="javascript:studentManager.load(2);">↓&nbsp;</a></td>
            <td height="44">顺序号</td>
          </tr>
          <tbody id="tableBody"></tbody>
        </table>
        <div class="table_under_btn page_list">
        	<div class="flip">
			</div>
		</div>
        <!-- <div class="page_list">
			  <form><div class="digg4"><a href="#">上一页</a>&nbsp;&nbsp; 第&nbsp;<input class="page_input">&nbsp;页 &nbsp;&nbsp;<a href="#">下一页</a>  &nbsp;&nbsp;&nbsp;<input value="确定" class="submit" type="submit"></div></form>
			  </div>
        </div> -->
      </div>
        <!--主体main的左侧可更换内容结束-->
        <div class="clear"></div>
    </div>
    <!--主体main结束-->



<%-- <fieldset class="fieldset_border">
	<legend class="legend_title">学生列表</legend>
		<!-- <div style="margin-left: 252px;"> -->
		<div >
			<div class="form_search_item" >
				<div class="left">
					<!-- <a href="javascript:studentManager.createStudent()" class="base_btn"><span>手动录入</span></a>
					<a href="javascript:studentManager.importStudent()" class="base_btn"><span>批量导入</span></a> -->
					<a href="javascript:studentManager.exportPart( )" class="base_btn"><span>导出选中</span></a>
					<a href="javascript:studentManager.exportAll()" class="base_btn"><span>导出全部</span></a>
					<!-- <span>操作说明：在左边树单击选择栏目</span> -->
				</div>
				<div class="right">
					<select name="lotteryId" id="lotteryId" class="piece">
						<c:forEach var="lottery" items="${list }">
							<option value="${lottery.id }">${lottery.title }</option>
						</c:forEach>
					</select>
					<input type="text" class="piece" id="keyword" onkeydown="if(event.keyCode==13){studentManager.load();}"/>
					<a href="javascript:studentManager.load()" class="base_btn"><span>搜索</span></a>
				</div>
			</div>
			<table  class="table_border" style="width: 99.7%;">
				<tr class="head">
					<td width="40px"><input type="checkbox" id="chk_ids"/></td>
					<td >姓名</td>
					<td >性别</td>
					<td >出生年月日</td>
					<td >毕业小学</td>
					<td >身份证号</td>
					<td >小升初报名编号</td>
					<td >广州市学籍号</td>
					<td >联系电话</td>
					<td width="110px">状态</td>
				</tr>
				<tbody id="tableBody"></tbody>
			</table>
			<div class="table_under_btn" >
				<!-- <a href="javascript:studentManager.deleteMutilStudent()" class="base_btn" style="float: left;" id="deleteMutil"><span>删除</span></a> -->
				<!-- <a href="javascript:studentManager.moveMutilStudent()" class="base_btn" style="float: left;" id="moveMutil"><span>移动栏目</span></a>
				<a href="javascript:studentManager.settingStatus()" class="base_btn" style="float: left;" id="changeStatus"><span>切换状态</span></a> -->
				<div class="flip">
				</div>
			</div><!--table_under_btn-->
		</div>
		<div class="clear"></div>
</fieldset> --%>
<script type="text/javascript">
var columnId;
var columnName;
var columnType;
var studentManager;
$(function(){
	studentManager = new studentManager();
	studentManager.load(1);
	
	$('#lotteryId').change(function(){
		studentManager.load();
	});
	
	$("#chk_ids").click(function(){
		if($(this).attr("checked")){
			$("input[name='chk_student_id']").attr('checked',true);
		}else{
			$("input[name='chk_student_id']").attr('checked',false);
		}
	});
});

function studentManager(){
	this.load = function(order){
		loadByPage2('/lottery/student/resultList.action',{status: '${status}', lotteryId:$('#lotteryId').val(),name:$('#keyword').val(),order:order},this.showList);
	};
	this.showList = function(list){
		$('#tableBody').html('');
		var index = 0;
		for ( var item in list) {
			var student = list[item];
			index++;
			if(student){
				var html = '';
				html = '<tr id="tr_'+student.id+'"'  + (item%2 == 0 ? '' : 'class="bgg"')  + '>'+
				'	<td height="44"><input type="checkbox" name="chk_student_id" value="'+student.id+'" /><input name="columnType" type="hidden" value="'+student.columnType+'" /></td>'+
				'	<td height="44">'+student.name+'</td>'+
				'	<td height="44">'+student.gender+'</td>'+
				/* '	<td height="44">'+(student.birthday == null ? "" : student.birthday)+'</td>'+ */
				'	<td height="44">'+(student.school == null ? '' : student.school)+'</td>'+
				/* '	<td height="44">'+student.IDCard+'</td>'+
				'	<td height="44">'+(student.stuCode == null ? '' : student.stuCode)+'</td>'+*/
				'	<td height="44">'+(student.stuCode == null ? '' : student.stuCode)+'</td>'+
				/* '	<td height="44">'+(student.phone == null ? '' : student.phone)+'</td>'+ 
				'	<td height="44">'+(student.mPhone == null ? '' : student.mPhone)+'</td>'+  */
				'	<td class="status" value="' + (student.status?1:0) + '" height="44">'+(student.status==1?"已选中":"未选中")+'</td>' +
				'	<td height="44">'+ (student.randomNum == null ? '' : student.randomNum) +'</td>' +
				'	<td height="44">'+(student.serialNum == null ? '' : student.serialNum)+'</td></tr>';
				 $('#tableBody').append(html); 
			}else{
				
			}
		}
		if (list&&list.length>0) {
			$("#deleteMutil").show();
			$("#moveMutil").show();
			$("#changeStatus").show();
		}else{
			$("#deleteMutil").hide();
			$("#moveMutil").hide();
			$("#changeStatus").hide();
		}
		addHover($('#main_table'));
	};
	this.createStudent = function(){
		
		art.dialog.open('/lottery/student/add.action?', {
			width: '50%',
			height: '50%',
			title:'手动录入'
		});
		
	};
	this.deleteStudent = function(id){
		art.dialog.confirm("确定删除吗？", function(){
			$.post('/lottery/student/delete.action',{ids:id},function(data){
				if(data=='succeed'){
					studentManager.load();
				}else{
					art.dialog.alert('操作失败');
				}
			});
		});
	};
	this.deleteMutilStudent = function(){
		var ids=[];
		$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
			ids.push($(this).val());
		});
		
		if (!ids||ids.length==0) {
			art.dialog.alert("您尚未选中任何要删除的学生！");
			return;
		}

		art.dialog.confirm("您确定要批量删除已选中的学生吗？", function(){
			$.post('/lottery/student/delete.action',{ids:ids.join(',')},function(data){
				if(data=='succeed'){
					studentManager.load();
				}else{
					art.dialog.alert('操作失败');
				}
			});
		});
	};
	this.editStudent = function(id){
		art.dialog.open('/lottery/student/toEdit.action?id='+id, {
			width: '50%',
			height: '50%',
			title:'修改'
		});
	};
	this.toViewStudent = function(id){
		art.dialog.open('/lottery/student/toView.action?id='+id, {
			width: '50%',
			height: '50%',
			title:'查看'
		});
	};
	this.exportPart = function(){//导出选中
		var ids=[];
		$("input[type='checkbox'][name='chk_student_id']:checked").each(function(){
			ids.push($(this).val());
		});
		
		if (!ids||ids.length==0) {
			art.dialog.alert("您尚未选中任何要导出的学生！");
			return;
		}
		
		excelExport('lotteryStudent','导入学生模板', "ids=" + ids);
	};
	this.exportAll = function(){//导出全部
		var status = '${status}';
		var title = status > 0 ? ( status > 1? '未中名单一览表' : '摇中名单一览表') : '候补名单一览表';
		excelExport('lotteryStudent',title, "ids=all" + "&lotteryId=" + $('#lotteryId').val() + "&status=" + status + "&title=" + title);
	};
	//打开导入面试时间/批次界面
	this.importStudent=function (){
		excelImport('&workbook=lotteryStudent&lotteryId=' + $('#lotteryId').val(), '导入学生', '');
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
	   					studentManager.load();
	   				}
				}
			});
}

function addHover(table){
	$(table).find('tr').each(function(i){
		if(i == 0){
			return;
		}
		var oldClass = $(this).attr('class') == null ? '' : $(this).attr('class');
		$(this).mousemove(function(){
			$(this).attr('class','tr_hover');
		});
		$(this).mouseout(function(){
			$(this).attr('class',oldClass);
		});
	});
}

/**
 * 分页查询
 * @param url 请求地址，如：'/user/load.action'
 * @param params 请求参数，如：{name:value, name:value}
 * @param func 列表展示函数，参数pageList.list
 */
function loadByPage2(url, params, func, container){
	var t = typeof container!='undefined'?container:$('#tableBody')[0];
	var e = $('#page_d')[0]?$('#page_d')[0]:$('.table_under_btn .flip')[0];
	var settings = {
			params: params,
			container: t,
			pagingContainer: e,
			pageSizeSelectValues: [500,100,50,30, 20,10]
	};
	var pagedQuery = new PagedQuery(url, settings, func);
	pagedQuery.post();
}

</script>
</body>
</html>