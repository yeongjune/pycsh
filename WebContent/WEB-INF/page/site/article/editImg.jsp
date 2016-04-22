<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
function saveImage(){
	$.post('/image/update.action',$("#imgForm").serialize(),function(data){
		if(data=="fail"){
			art.dialog.tips("保存失败");
		}else{
			art.dialog.close();
		}
	});
}
</script>

</head>
<body>
<form action="" id="imgForm">
<input  type="hidden" id="id" name="id" value="${image.id }"/>
<div class="form_item">
	<span class="form_span">链接：</span>
	<input type="text" id="href" name="href" class="piece"  value="${image.href }"   maxlength="256"/>
</div>
<div class="form_item">
	<span class="form_span">描述：</span>
	<textarea id="description" name="description"   maxlength="1000"  class="textarea_piece" rows="10" cols="68"  style="width:600px;height:250px;">${image.description }</textarea>
</div>
<div class="form_submit">
		<a href="javascript:saveImage()" class="base_btn" id="submitButton"><span>确定</span></a>
</div>
</form>
</body>
</html>