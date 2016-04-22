<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>template</title>
<script>
	var labelId = '${labelId}';
	$(document).ready(function(){
		
		$("#addBtn").live("click", function(){
			art.dialog.open("/data/add.action?labelId=" + labelId,{
				title: "添加数据源",
				width: 500,
				height: 300
			});
		});
		
		$(".editBtn").live("click", function(){
			var id = $(this).attr("data-id");
			art.dialog.open("/data/edit.action?id=" + id,{
				title: "修改数据源"
			});
		});
		
		$(".deleteBtn").live("click", function(){
			var id = $(this).attr("data-id");
			var self = $(this);
			art.dialog({
				content:"确定删除？",
				ok: function () {
					$.post("/data/delete.action?id=" + id, function(data){
						if(data == 'succeed'){
							self.parents("tr").remove();
						}else{
							failTip();
						}
					});
				},
			    cancelVal: '关闭',
			    cancel: true //为true等价于function(){}
			});
		});
		
		$(".labelMenu").click(function(){
			var id = $(this).attr("id");
			loadUrlPage("/data/index.action?labelId=" + id);
		});
	});
</script>
</head>
<body>
	<fieldset class="fieldset_border">
		<legend class="legend_title">数据源管理</legend>
		<div class="small_nav">
			<c:forEach items="${labelList }" var="label">
				<a id="${label.id}" class="labelMenu <c:if test="${labelId == label.id }">hover</c:if>" href="javascript:void(0)">${label.name }</a>	
			</c:forEach>
		</div>
		<div class="clear"></div>
		<div class="form_search_item">
			<div class="left">
				<a id="addBtn" class="base_btn" href="javascript:void(0)"><span>新增</span></a>
			</div>
			<div class="right">
			</div>
		</div>
		<table id="" class="table_border">
			<tr class="head">
				<td>ID</td>
				<td>名称</td>
				<td>数量</td>
				<td>栏目名称</td>
				<td>是否显示分页</td>
				<td>排序规则</td>
				<td>操作</td>
			</tr>
			<c:forEach items="${list }" var="data">
				<tr>
					<td>${data.id }</td>
					<td>${data.name }</td>
					<td>${data.size}</td>
					<td>${data.columnName == null ? "整站" : data.columnName}</td>
					<td>${data.displayPage == 0 ? "否" : "是"}</td>
					<td>
						<c:if test="${data.sortType == 0}">最新</c:if>
						<c:if test="${data.sortType == 1}">最旧</c:if>
						<c:if test="${data.sortType == 2}">点击</c:if>
					</td>
					<td>
						<a class="editBtn" data-id="${data.id }" href="javascript:void(0)" >修改</a>
						<a class="deleteBtn" data-id="${data.id }" href="javascript:void(0)">删除</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</fieldset>
</body>
</html>