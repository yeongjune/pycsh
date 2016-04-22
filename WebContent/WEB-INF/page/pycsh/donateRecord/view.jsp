<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<link href="${css }/skins/blue/css/article.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" charset="utf-8" src="/plugin/ueditor_1.4.3/ueditor.parse.min.js"></script>
<style type="text/css">
.content {
text-align: left;
overflow: visible;
min-height:25px;
min-width: 845px;
border:1px solid #eee;
border-radius:5px;
-moz-border-radius:5px;
-webkit-border-radius:5px;
padding: 3px;
margin-bottom: 10px;
overflow-x:hidden;
word-wrap: break-word;
word-break: normal;
}
</style>
</head>
<body>
	<!-- <fieldset class="fieldset_border" style="margin:0px;padding:10px 20px;"> -->
		<form action="">
		    <div style="float:left;">
				<div class="form_item">
					<span class="form_span">用户名：</span>
					${donate.loginName }
				</div>
				<div class="form_item">
					<span class="form_span">姓名：</span>
					${donate.wName }
				</div>
				<div class="form_item">
					<span class="form_span">捐款途径：</span>
					<c:choose>
						<c:when test="${donate.type==1 }">支付宝</c:when>
						<c:otherwise>微信</c:otherwise>
					</c:choose>					
				</div>
				<div class="form_item">
					<span class="form_span">捐款日期：</span>
					${donate.createTime}
				</div>
				<div class="form_item">
					<span class="form_span">捐款金额(元)：</span>
					<fmt:formatNumber value="${donate.money}"  type="number" pattern="#.00"/>
				</div>
				<div class="form_item">
					<span class="form_span">项目名称：</span>
					${donate.pName }
				</div>
				
		    </div>
			<div class="clear"></div>
		</form>
	<!-- </fieldset> -->
</body>
</html>