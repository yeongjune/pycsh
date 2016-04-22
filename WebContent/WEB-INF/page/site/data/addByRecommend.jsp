<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>template</title>
<c:import url="/common/taglibs.jsp" />
<script>
	var labelId = '${labelId}';
	$(document).ready(function(){
		$("#submitBtn").click(function(){
			$.post("/data/save.action", $("#form").serialize(), function(data){
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
		<input name="labelId" type="hidden" value="${labelId }"/>
		<div class="form_item">
			<span class="form_span">名称：</span>
			<input name="name" type="text" class="piece" />
		</div>
		<div class="form_item">
			<span class="form_span">推荐位：</span>
			<select name="columnId" class="piece" >
				<option value="0">整站</option>
				<c:forEach items="${recommendList }" var="recommend">
					<option value="${recommend.id }">
						${recommend.name }
					</option>
				</c:forEach>
			</select>
		</div>
		<div class="form_item">
			<span class="form_span">显示数量：</span>
			<input name="size" type="text" class="piece" />
		</div>
		<div class="form_item">
			<span class="form_span">是否显示分页：</span>
			<input name="displayPage" type="radio" checked="checked" value="0"/>否
			<input name="displayPage" type="radio" value="1"/>是
		</div>
		<div class="form_item">
			<span class="form_span">排序：</span>
			<select name="sortType">
				<option selected="selected" value="0">最新</option>
				<option value="1">最旧</option>
				<option value="2">点击数</option>
			</select>
		</div>
		<div class="form_submit">
			<a id="submitBtn" class="base_btn"><span>提交</span></a>
		</div>
	</form>
</body>
</html>