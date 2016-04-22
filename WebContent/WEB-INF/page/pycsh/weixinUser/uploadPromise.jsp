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


</script>
</head>
<body>
	<div><img src="${registerImgUrl }" id="codePic" width="130"></img></div>
	<div style="margin-left : 110px;text-align: center;">
	<c:import url="/common/swfUpload7.jsp">
						    <c:param name="limit">1</c:param>
							<c:param name="types">*.doc;*.xls;*.docx;*.xlsx;*.pdf</c:param>
							<c:param name="upload_size">10000</c:param>
							<c:param name="type">6</c:param>
							<c:param name="index">1</c:param>
						</c:import>	
	<input  type="hidden" id="typeValue" />
	<input  type="hidden" id="typeName" />
	</div>
</body>
</html>