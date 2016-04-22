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
<script type="text/javascript">
	function openImg(emt){
		window.open($(emt).attr("src"),"_blank");
	}

</script>
</head>
<body>
	<!-- <fieldset class="fieldset_border" style="margin:0px;padding:10px 20px;"> -->
		<form action="">
		    <div style="float:left;">
				<div class="form_item">
					<span class="form_span">单位名称：</span>
					<input type="text" disabled="disabled" class="piece" readonly="readonly" value="${user.company }" style="width: 404px;"/>
				</div>
				<div class="form_item">
					<span class="form_span">法人代表：</span>
					<input type="text" class="piece" readonly="readonly" value="${user.corporation }" />
				</div>
				<div class="form_item">
					<span class="form_span">联系人：</span>
					<input type="text" class="piece" readonly="readonly" value="${user.contact }" />
				</div>
				<div class="form_item">
					<span class="form_span">联系电话：</span>
					<input type="text" class="piece" readonly="readonly" value="${user.contactPhone}" />
				</div>
				<div class="form_item">
					<span class="form_span">电子邮箱：</span>
					<input type="text" class="piece" readonly="readonly" value="${user.email}" />
				</div>
				<div class="form_item">
					<span class="form_span">申请时间：</span>
					
					<input type="text" class="piece" readonly="readonly" value="<fmt:formatDate value="${user.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				</div>
				<div class="form_item">
					<span class="form_span">社会组织登记证书：</span>
					<img style="cursor:pointer" width="200" onclick="openImg(this);" src="${user.registerImgUrl }" alt="社会组织登记证书（社团法人，民非企法人）" />
				</div>
				<div class="form_item">
					<span class="form_span">社会等级评估证书：</span>
				</div>
				<div class="form_item" style="margin-left: 140px;">
					<span class="form_span"></span>
					<c:forEach items="${imgList }" var="img">
						<div style="float: left;margin-right: 5px;margin-bottom: 5px;">
							<img style="cursor:pointer" onclick="openImg(this);" src="${img.imgUrl }" width="200" />
						</div>
					</c:forEach>
				</div>
				<div class="clear"></div>
				

				
		    </div>
			<div class="clear"></div>
		</form>
	<!-- </fieldset> -->
</body>
</html>