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
<script type="text/javascript">
    var ue;//ueditor编辑器实例变量
	$(function(){

		//实例化编辑器
		ue = UE.getEditor('myEditor',{'enterTag':''});//enterTag为指定不增加p标签
		UE.getEditor('myEditor').ready(function(){
			
		});
	});
	
	
	//清空object对象
	function removeObject(){
		 $('div').empty(); 
	}

	

</script>
</head>
<body onunload="removeObject()">
	<form action="">

	   
		
		<div class="form_item div_title_1_1">
			<span class="form_span"><font color="red" id="title_tip">*</font>进展标题：</span>
			<input type="text" id="title" class="piece" style="width:500px;" value="${cr.title }" maxlength="100" />
		</div>
		
		<div class="form_item div_title_1_1">
			<span class="form_span"><font color="red" id="title_tip">*</font>时间：</span>
			<input type="text" name="recordTime" id="recordTime" class="piece" value="<fmt:formatDate value="${cr.recordTime }"  type="date" pattern="yyyy-MM-dd"/>" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" maxlength="10"  style="width:85px"  />
		</div>
		
		<div class="form_item div_content_1_1">
			 <div style="width:140px;text-align: right;float:left;">内容：</div>
			 <script id="myEditor" type="text/plain" style="width:550px;min-height:320px;float:left;">${cr.contents }</script>

		</div>

		<div class="clear"></div>
	</form>
</body>
</html>