<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>${title }</title>
<%@include file="/common/taglibs.jsp" %>
<script type="text/javascript" charset="utf-8" src="/plugin/ueditor_1.4.3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/ueditor_1.4.3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="/plugin/ueditor_1.4.3/lang/zh-cn/zh-cn.js"></script>
<link href="${css }/skins/blue/css/article.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	var projectAdd;
	$(function(){
		projectAdd = new ProjectAdd();
	});
	function ProjectAdd(){
		
		this.save = function(){
			var name = $('#name').val();
			var pId = $('#pId').val();
			var sort = $('#sort').val();
			var category = $('input[name=category]:checked').val();
			if(""==name){
				art.dialog.alert('项目类型名称');
				return;
			}
			
			lockWindow();
			var url = "/projectType/save.action";
			$.post(url, {name: name,pId:pId,category:category,sort:sort}, function(data){
				openLock();
				if(data=='succeed'){
					art.dialog.opener.projectManager.load();
					art.dialog.close();
				}else{
					if(projectId){
						art.dialog.alert('保存失败');
					}else{
						art.dialog.alert('发布失败');
					}
				}
			});
			
		};
	}
	
	
</script>
</head>
<body onunload="removeObject()">
	<form action="">
		<input id="tempId" type="hidden" value="${ (not empty tempId) ?tempId:article.tempId }" />
		<input id="articleId" type="hidden" value="${article.id}" />
		<input id="imageIds" type="hidden" />
	    
		<div class="form_item">
			<span class="form_span">类型的类别：</span>
			<input type="radio" name="category" value="project" checked="checked"/>慈善项目
			<input type="radio" name="category" value="game"/>项目大赛
		</div>
		<div class="form_item div_title_1_2">
			<span class="form_span">项目类型名称(父级)：</span>
			<c:import url="/projectType/projectTypeSelect.action">
				<c:param name="id1" value="pId"></c:param>
				<c:param name="pId" value="0"></c:param>
				<c:param name="category" value="project"></c:param>
			</c:import>
		</div>
		<div class="form_item div_title_1_1">
			<span class="form_span"><font color="red" id="title_tip">*</font>项目类型名称：</span>
			<input type="text" id="name" class="piece" style="width:200px;" value="${project.name }" maxlength="100"/>
		</div>
		<div class="form_item div_title_1_1">
			<span class="form_span">排序：</span>
			<input type="text" id="sort" class="piece" style="width:200px;" value="${project.sort }" maxlength="100" onkeyup ='this.value=this.value.replace(/[^0-9]/gi,"")'/>
		</div>
		<!-- 文章内容结束 -->
		<div class="clear"></div>
		<div class="form_submit">
			<a href="javascript:projectAdd.save()" class="base_btn" id="submitButton"><span>保存</span></a>
		</div>
		<div class="clear"></div>
	</form>
</body>
</html>