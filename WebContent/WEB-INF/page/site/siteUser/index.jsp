<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<script type="text/javascript">
var siteUserMng;
$(function(){
	siteUserMng=new SiteUserMng();
	siteUserMng.load();
	//绑定全选事件
	$("#chk_ids").toggle(function(){
		$("input[name='chk_siteUser_id']").attr("checked","true");
	},function(){
		$("input[name='chk_siteUser_id']").removeAttr("checked");
	});
});
function SiteUserMng(){
	this.load = function(){
		loadByPage('/siteUser/list.action',{keyword:$("#keyword").val(),startTime:$("#startTime").val(),endTime:$("#endTime").val(),department:$("#department").val()},this.showList);
	};
	this.showList = function(list){
		var tempStr="";
		var status={'-2':'审核不通过','-1':'禁用','0':'待审核','1':'启用'};
		for ( var key in list) {
			var item = list[key];
			if(item){
				tempStr+='<tr id="tr_'+item.id+'">'+
						'	<td><input type="checkbox" name="chk_siteUser_id" value="'+item.id+'" /></td>'+
						'	<td>'+item.acount+'</td>'+
						'	<td>'+(item.identity?item.identity:'')+'</td>'+
						'	<td>'+(item.department?item.department:'')+'</td>'+
						'	<td>'+(item.email?item.email:'')+'</td>'+
						'	<td>'+item.createTime+'</td>'+
						'	<td>'+status[item.status]+'</td>'+
						'	<td>'+
						/* (item.status==0?'		<a href="javascript:siteUserMng.changeStatus('+item.id+',1)">审核通过</a>':'')+
						(item.status==0?'		<a href="javascript:siteUserMng.changeStatus('+item.id+',-1)">审核不通过</a>':'')+ */
						(item.status==1?'		<a href="javascript:siteUserMng.changeStatus('+item.id+',-2)">禁用</a>':'')+
						(item.status!=1?'		<a href="javascript:siteUserMng.changeStatus('+item.id+',1)">启用</a>':'')+
						'   <a href="javascript:siteUserMng.resetPwd('+item.id+')">重置密码</a>'+
			   			'	</td>'+
						'</tr>';
			}
		}
		$('#tableBody').html(tempStr);
	};
	//删除
	this.deleteSiteUser = function(){
		var ids=[];
		$("input[name='chk_siteUser_id']:checked").each(function(){
			ids.push($(this).val());
		});
		if(ids.length>0){
			$.post('/siteUser/delete.action',{ids:ids.join(',')},function(data){
				if(data=="succeed"){
					siteUserMng.load();
				}else{
					art.dialog.tips('操作失败');
				}
			});
		}else{
			art.dialog.tips('您没有选择任何要删除的站点用户');
		}
	};
	//修改状态
	this.changeStatus = function(id,status){
		$.post('/siteUser/changeStatus.action',{id:id,status:status},function(data){
			if(data=="succeed"){
				siteUserMng.load();
			}else{
				art.dialog.tips('操作失败');
			}
		});
	};
	
	this.createSiteUser = function(){
		art.dialog.open("/siteUser/createInSys.action",{
			title:"新增用户",
			width:"480px",
			height:"310px",
			lock:true,
			fixed:true,
			resize:false,
			close:function(){
				siteUserMng.load();
			}
		});
	};
	
	this.resetPwd = function(id){
		if(id != "" && id != null){
			$.post("/siteUser/resetPwd.action", {id:id}, function(data){
				if(data > 0){
					art.dialog("重置成功");
				}else{
					art.dialog("重置失败");
				}
			});
		}
	};
	
	this.changeDepartmentLoad = function(){
		siteUserMng.load();
	};
	
	this.importExcel = function(){
		art.dialog.open("/excel/entryImport.action?workbook=SiteUser&sheet=Sheet1",{
			title:"导入用户",
			width:"520px",
			height:"310px",
			lock:true,
			fixed:true,
			resize:false,
			close:function(){
				siteUserMng.load();
			}
		});
	};
	
	this.exportExcel = function(){
		location.href = "/excel/export.action?workbook=SiteUser&fileName=网站用户表模板";
	};
}
</script>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">站点用户管理</legend>
		<div class="form_search_item" >
			<div class="left">
				<a href="javascript:siteUserMng.createSiteUser()" class="base_btn" ><span>新增用户</span></a>
				<a href="javascript:siteUserMng.importExcel()" class="base_btn" ><span>导入用户</span></a>
				<a href="javascript:siteUserMng.exportExcel()" class="base_btn" ><span>导出模板</span></a>
				<a href="javascript:siteUserMng.deleteSiteUser()" class="base_btn" ><span>删除</span></a>
			</div>
			<div class="right">
				<span>部门</span>
				<select id="department" name="department" class="piece2" onchange="javascript:siteUserMng.changeDepartmentLoad()" style="width:70px;">
					<option value="">-选择-</option>
					<c:forEach items="${typeList }" var="item">
						<option value="${item.department }">${item.department }</option>
					</c:forEach>
				</select>
				<!-- 
				<span>注册时间</span>
				<input id="startTime" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\')}'})" style="line-height: 23px;">
				<span>至</span>
				<input id="endTime" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTime\')}'})" style="line-height: 23px;">
				 -->
				<span>用户名</span>
				<input type="text" class="piece" id="keyword" onkeydown="if(event.keyCode==13){siteUserMng.load();}"/>
					<a href="javascript:siteUserMng.load()" class="base_btn"><span>搜索</span></a>
			</div>
		</div>
		<table  class="table_border">
			<tr class="head">
				<td style="width: 40px"><input type="checkbox" id="chk_ids"/></td>
				<td >用户名</td>
				<td >身份</td>
				<td >部门</td>
				<td >邮箱</td>
				<td style="width:110px">注册时间</td>
				<td style="width:80px">状态</td>
				<td style="width:200px">操作 </td>
			</tr>
			<tbody id="tableBody"></tbody>
		</table>
		<!--start table_under_btn-->
		<div class="table_under_btn" >
			<div class="flip"></div>
		</div>
		<!--end table_under_btn-->
</fieldset>
</body>
</html>