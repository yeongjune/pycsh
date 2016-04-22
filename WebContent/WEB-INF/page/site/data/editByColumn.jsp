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
			$.post("/data/update.action", $("#form").serialize(), function(data){
				if(data && data == 'succeed'){
					art.dialog.opener.loadUrlPage("/data/index.action?labelId=" + labelId);
					art.dialog.close();
				}else{
					alert("缺少必填字段，请重试！");
				}
			});
		});
	});
</script>
</head>
<body>
	<form id="form">
		<input name="labelId" type="hidden" value="${data.labelId }"/>
		<div class="form_item">
			<span class="form_span">名称：</span>
			<input name="name" type="text" class="piece" value="${data.name }"/>
		</div>
		<div class="form_item">
			<span class="form_span">所属栏目：</span>
			<select name="columnId" class="piece" >
				<option value="-1" <c:if test="${data.columnIds == '-1' }">selected="selected"</c:if> >传参</option>
				<option value="0" <c:if test="${data.columnIds == '0' }">selected="selected"</c:if> >整站</option>
				<c:forEach items="${columnList }" var="column">
					<option value="${column.id }" <c:if test="${data.columnIds == column.id }">selected="selected"</c:if> >
						<c:forEach begin="1" end="${column.level }">
							&nbsp;&nbsp;
						</c:forEach>${column.name }
					</option>
				</c:forEach>
			</select>
		</div>
		<div class="form_submit">
			<a id="submitBtn" class="base_btn"><span>提交</span></a>
		</div>
	</form>
</body>
</html>