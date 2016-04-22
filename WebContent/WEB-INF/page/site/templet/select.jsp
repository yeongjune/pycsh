<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>template</title>
<c:import url="/common/taglibs.jsp" />
<script>
	$(document).ready(function(){
		$("#submitBtn").click(function(){
			var siteId = $("#siteId", art.dialog.opener.document.body).attr("value");
			var siteName = $("#siteName", art.dialog.opener.document.body).attr("value");
			$.post("/templateData/save.action?siteId=" + siteId + "&templateId=${templateId}", $("#dataId").serialize(), function(data){
				if(data == 'succeed'){
					art.dialog.opener.loadUrlPage("/templet/index.action?siteId=" + siteId + "&siteName=" + siteName);					
					art.dialog.close();
				}else{
					failTip();
				}
			});
		});
	});
</script>
</head>
<body>
	<div class="form_item">
		<span class="form_span">数据源：</span>
		<select id="dataId" name="dataId" multiple="multiple" style="width: 150px; height: 150px;">
			<c:forEach items="${dataList }" var="data">
				<option <c:if test="${data.check }">selected="selected"</c:if> value="${data.id }">${data.name }</option>
			</c:forEach>
		</select>
	</div>
	<div class="form_submit">
		<a id="submitBtn" class="base_btn" href="#"><span>保存</span></a>
	</div>
</body>
</html>