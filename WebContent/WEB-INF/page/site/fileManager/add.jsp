<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>${title }</title>
<%@include file="/common/taglibs.jsp" %>
<script type="text/javascript">
function saveDirectory(){
	if(!$("#name").val()){
		art.dialog.tips('文件夹名不能为空');
		return;
	}
	$.post('/fileManager/add.action',$("#directoryForm").serialize(),function(data){
		if(data=='succeed'){
			art.dialog.opener.fileManager.loadDirectoryList();
			art.dialog.close();
		}else if(data=='false'){
			art.dialog.tips("文件夹已存在");
			art.dialog.close();
		}else{
			art.dialog.tips("保存失败");
		}
	});
}
</script>
</head>
<body>
<form action="" id="directoryForm">
   <input  type="hidden" name="id" value="${id }" />
   <div style="float:left;padding-top: 20px;">
	    <div class="form_item">
			<span class="form_span">文件夹名：</span><input name="name" id="name" class="piece"/>
			<a href="javascript:saveDirectory()" class="base_btn" ><span>确定</span></a>
		</div>
    </div>
	<!-- <div class="form_submit">
			
	</div> -->
	<div class="clear"></div>
</form>
</body>
</html>