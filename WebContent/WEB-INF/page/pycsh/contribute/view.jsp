<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>${title }</title>
<%@include file="/common/taglibs.jsp" %>
<script type="text/javascript" charset="utf-8" src="/plugin/ueditor_1.4.3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/ueditor_1.4.3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="/plugin/ueditor_1.4.3/lang/zh-cn/zh-cn.js"></script>
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
					<span class="form_span">标题：</span>
					<span class="form_span" style="text-align: left;width:73%;overflow: visible;min-width: 400px;" id="title">${con.title }</span>
				</div>
				
				
				<div class="form_item">
					<span class="form_span">作者：</span>
					<span class="form_span" style="text-align: left;width:73%;overflow: visible;min-width: 400px;" id="title">${con.author }</span>
				</div>
				
				<div class="form_item">
					<span class="form_span">电话：</span>
					<span class="form_span" style="text-align: left;width:73%;overflow: visible;min-width: 400px;" id="title">${con.phone }</span>
				</div>
				
				<div class="form_item">
					<span class="form_span">合作单位：</span>
					<span class="form_span" style="text-align: left;width:73%;overflow: visible;min-width: 400px;" id="title">${con.partners }</span>
				</div>
			
				
				<div class="form_item">
					<span class="form_span">联系地址：</span>
					<span class="form_span" style="text-align: left;width:73%;overflow: visible;min-width: 400px;" id="title">${con.address }</span>
				</div>
			
				<div class="form_item">
					<span class="form_span">内容：</span>
					<div class="form_span content">${con.content }</div>
				</div>
				
		<div class="form_item div_introduce" style="margin-top: 30px;">
			<span class="form_span">附件：</span>
			<c:import url="/common/swfUpload.jsp">

				<c:param name="types">*</c:param>
				<c:param name="upload_size">5000</c:param>
				<c:param name="type">3</c:param>
				<c:param name="index">5</c:param>
			</c:import>		
		</div>
				
<div class="clear"></div>	
<div class="flash" id="fsUploadProgressList">  
	 <c:if test="${fileList != null}">
		<c:forEach items="${fileList}" var="list" varStatus="status"> 
			<div class="progressWrapper" id="SWFUpload_List_${status.index+1}"
				style="opacity: 1;">
				<div class="progressContainer green">
					<a class="progressCancel" href="#" style="visibility: visible;"
						onclick="delAttchment('/image/deleteById.action?id=${list.id}','SWFUpload_List_${status.index+1}')">
					</a>

					<div class="progressName"><a href="${list.path }">${list.fileName}</a></div>
				</div>
				<input type="hidden" name="attachmentIds" value="${list.id}"/>
			</div>
		</c:forEach>
	</c:if>  
</div>
		    </div>
			<div class="clear"></div>
		</form>
	<!-- </fieldset> -->
</body>
<script>
$("#btnUpload_5").remove();

</script>
</html>