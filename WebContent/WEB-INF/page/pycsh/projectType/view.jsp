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
			
			if(""==name){
				art.dialog.alert('项目类型名称不能为空');
				return;
			}
			
			lockWindow();
			var url = "/projectType/update.action";
			$.post(url, {name: name,pId:pId,id:"${project.id}"}, function(data){
				openLock();
				if(data=='succeed'){
					art.dialog.opener.projectManager.load();
					art.dialog.close();
				}else{
					art.dialog.alert('保存失败');
				}
			});
			
		};
	}
	//清空object对象
	function removeObject(){
		 $('div').empty(); 
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
			<input type="radio" name="category" value="project" disabled="disabled" <c:if test="${project.category=='project' }">checked="checked"</c:if>/>慈善项目
			<input type="radio" name="category" value="game" disabled="disabled" <c:if test="${project.category=='game' }">checked="checked"</c:if>/>项目大赛
		</div>
		<div class="form_item div_title_1_2">
			<span class="form_span">项目类型名称(父级)：</span>
			<input type="text" class="piece" style="width:200px;" value="${project.pName }" readonly="readonly" />
			<input type="hidden" id="pId" class="piece" style="width:200px;" value="${project.pId}" />
		</div>	
		<div class="form_item div_title_1_1">
			<span class="form_span"><font color="red" id="title_tip">*</font>项目类型名称：</span>
			<input type="text" id="name" class="piece" style="width:200px;" value="${project.name }" readonly="readonly" maxlength="200" />
		</div>
		<div class="form_item div_title_1_1">
			<span class="form_span">排序：</span>
			<input type="text" id="sort" class="piece" style="width:200px;" value="${project.sort }" maxlength="100" onkeyup ='this.value=this.value.replace(/[^0-9]/gi,"")'/>
		</div>
		<div class="clear"></div>
	</form>
</body>
</html>