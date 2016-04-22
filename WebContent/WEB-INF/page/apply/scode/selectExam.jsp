<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title}</title>

</head>
<body>
<span style="font-size:12px;color:gray;">请选择要导出的考试的学生，不选择则导出所有</span><br/>
<select id="exam" name="exam"  multiple="multiple" style="width:250px;height:130px;border:1px solid gray;">
<c:if test="${not empty examList }">
	<c:forEach var="exam" items="${ examList}">
		<option value="${exam.id }">${exam.examName }</option>
	</c:forEach>
</c:if>
</select><br/>
<span style="font-size:12px;color:gray;">(点击拖动多选或按住Ctrl单击多选)</span>
</body>
</html>