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
	$("#submitButton").live("click",function(){
		var id = '${actId}';
		var progress = $("#progress").val();
		lockWindow();
		$.post('/activity/upateActivityStatus.action', {id:id,progress:progress}, function(data){
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
	});
</script>
</head>
<body>
	<form action="">
		<div class="form_item">
			<span class="form_span">进展：</span>
			<select id="progress" class="piece">
				<option value="1">发起</option>
				<option value="2">审核</option>
				<option value="3">募款</option>
				<option value="4">执行</option>
				<option value="5">结束</option>
			</select>
		</div>

		<div class="form_submit">
			<a href="javascript:(0)" class="base_btn" id="submitButton"><span>保存</span></a>
		</div>
		<div class="clear"></div>
	</form>
</body>
</html>