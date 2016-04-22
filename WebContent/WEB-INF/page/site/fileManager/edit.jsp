<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>${title }</title>
<%@include file="/common/taglibs.jsp" %>
<%-- <%@ include file="/common/kindeditor.jsp" %>  --%>
<script type="text/javascript">
function saveFileMng(){
	$.post('/fileManager/save.action',$("#fileForm").serialize(),function(data){
		if(data=='succeed'){
			art.dialog.close();
		}else{
			art.dialog.tips("保存失败");
		}
	});
}
</script>
</head>
<body>
	<fieldset class="fieldset_border" style="margin:0px;padding:10px 20px;">
		<form action="" id="fileForm">
			<input  type="hidden" name="id" value="${id }" />
		    <div style="float:left;">
			    <div class="view_rank">
					<span class="form_span">文件名：</span>${name }
				</div>
				<div class="view_rank">
					<span class="form_span">相对路径：</span>${id }
				</div>
				<div class="form_item"	id="div_content">
					<span class="form_span">文件内容：</span>
					<textarea name="content" class="ke-edit-textarea"  style="min-width: 780px;min-height: 500px;">${content }</textarea>  
				</div>
		    </div>
		    <div class="clear"></div>
			<div class="form_submit">
					<a href="javascript:saveFileMng()" class="base_btn" ><span>保存</span></a>
			</div>
			<div class="clear"></div>
		</form>
	</fieldset>
</body>
</html>