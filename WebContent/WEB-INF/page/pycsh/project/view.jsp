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
				<div class="form_item" id="div_title">
					<span class="form_span">项目名称：</span>
					<span class="form_span" style="text-align: left;width:73%;overflow: visible;min-width: 400px;" id="title">${project.name }</span>
				</div>
				<div class="form_item" id="div_title">
					<span class="form_span">项目类型：</span>
					<span class="form_span" style="text-align: left;width:73%;overflow: visible;min-width: 400px;" id="title">${project.typeName }<c:if test="${project.type2Name!=null && project.type2Name!='' }">_${project.type2Name }</c:if></span>
				</div>
				<div class="form_item" id="div_title2">
					<span class="form_span">筹款目标(元)：</span>
					<span class="form_span" style="text-align: left;width:73%;overflow: visible;min-width: 400px;" id="title"><fmt:formatNumber value="${project.targer }" pattern="#.00"></fmt:formatNumber></span>
				</div>
				<div class="form_item" id="div_title2">
					<span class="form_span">筹款周期：</span>
					<span class="form_span" style="text-align: left;width:73%;overflow: visible;min-width: 400px;" id="title">
					<fmt:formatDate value="${project.startTime }"  type="date" pattern="yyyy-MM-dd"/>至<fmt:formatDate value="${project.endTime }"  type="date" pattern="yyyy-MM-dd"/>
					</span>
				</div>
				
				<div class="form_item" id="div_smallPIc">
					<span class="form_span">缩略图：</span>
					<c:if test="${not  empty project.smallPicUrl }">
						<img id="samllPic" alt="缩略图"  class="smallPic" src="${not empty project.smallPicUrl ? project.smallPicUrl : '/skins/blue/images/default.jpg'}" class="samllPic" />
					</c:if>
					<c:if test="${empty project.smallPicUrl}">
						<img id="samllPic" alt="缩略图"  width="80px" height="80px" />
					</c:if>
				</div>
				<div class="form_item" id="div_introduce">
					<span class="form_span">简介：</span>
					<div class="form_span content">${project.introduce }</div>
				</div>
				<div class="form_item" id="div_content">
					<span class="form_span">内容：</span>
					<div class="form_span content">${project.contents }</div>
				</div>
				<c:if test="${fn:length(imageList)>0 }">
				<div class="form_item"  id="div_imageList">
					<div id="div_item_imgList">
						<!-- 该div用于显示已上传的图片 ，请不要修改Id-->
						<c:forEach var="image" items="${imageList }">
							<img  src="${image.path }" alt="${image.fileName }" title="点击查看原图" />
						</c:forEach>
					</div>
				</div>
				</c:if>
				
				<c:if test="${fn:length(fileList)>0 }">
				<div class="form_item"  id="div_fileList">
						<!-- 该div用于显示已上传的文件 ，请不要修改Id-->
						<span class="form_span">附件：</span>
						<div class="right_introduction">
							<c:forEach var="file" items="${fileList }" varStatus="i">
								<div class="progressContainer blue" >
									<div class="progressName">${i.index+1 }.<a href="${file.path }" target="_blank">${file.fileName}</a></div>
									<div class="progressBarComplete"></div>
								</div>
							</c:forEach>
						</div>
				</div>
				</c:if>
				
				<c:if test="${fn:length(recommendList)>0 }">
				<div class="form_item" id="div_recommend">
					<span class="form_span" style="float: left;">推荐位置：</span>
					<div class="right_introduction">
						<ul class="listCommand">
							<c:forEach var="recommend" items="${recommendList}">
								<c:if test="${recommend.checked eq 'checked'}">
									<li><label><input name="recommend" type="checkbox" value="${recommend.id}" checked="checked" disabled="disabled" /> ${recommend.name}</label></li>
								</c:if>
								<c:if test="${empty  recommend.checked}">
									<li><label><input name="recommend" type="checkbox" value="${recommend.id}" disabled="disabled" /> ${recommend.name}</label></li>
								</c:if> 
							</c:forEach>
						</ul>
					</div>
				</div>
				</c:if>
		    </div>
			<div class="clear"></div>
		</form>
	<!-- </fieldset> -->
</body>
</html>