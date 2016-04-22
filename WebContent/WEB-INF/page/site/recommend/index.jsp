<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>template</title>
<script>
	$(document).ready(function(){
		
		$("#addBtn").live("click", function(){
			art.dialog.open("/recommend/add.action",{
				width:350,
				title: "添加推荐位"
			});
		});
		
		$(".editBtn").live("click", function(){
			var id = $(this).attr("data-id");
			art.dialog.open("/recommend/edit.action?id=" + id,{
				width:350,
				title: "修改推荐位"
			});
		});
		
		$(".deleteBtn").live("click", function(){
			var id = $(this).attr("data-id");
			var self = $(this);
			art.dialog({
				content:"确定删除？",
				ok: function () {
					$.post("/recommend/delete.action?id=" + id, function(data){
						if(data){
							self.parents("tr").remove();
						}
					});
				},
			    cancelVal: '关闭',
			    cancel: true //为true等价于function(){}
			});
		});
	});
</script>
</head>
<body>
	<fieldset class="fieldset_border">
		<legend class="legend_title">推荐类型管理</legend>
			<div class="form_search_item">
				<div class="left">
					<a id="addBtn" class="base_btn" href="javascript:void(0)"><span>添加</span></a>
				</div>
				<div class="right">
				</div>
			</div>
			<table id="" class="table_border">
					<tr class="head">
						<td>ID</td>
						<td>推荐类型名称</td>
						<!-- <td>所属栏目</td> -->
						<td>操作</td>
					</tr>
					<c:forEach items="${recommendList }" var="recommend">
						<tr>
							<td>${recommend.id }</td>
							<td>${recommend.name }</td>
							<!-- <td>${recommend.columnName == null ? "整站" : recommend.columnName}</td> -->
							<td>
								<a class="editBtn" data-id="${recommend.id }" href="javascript:void(0)" >修改</a>
								<a class="deleteBtn" data-id="${recommend.id }" href="javascript:void(0)">删除</a>
							</td>
						</tr>
					</c:forEach>
						
			</table>
	</fieldset>
</body>
</html>