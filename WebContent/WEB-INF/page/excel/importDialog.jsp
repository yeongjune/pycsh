<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>excel file import</title>
<%@include file="/common/taglibs.jsp" %>
<script type="text/javascript">
var parameters = "${parameters}";
function showMessage(message){
	$('#txt').text(message);
}
$(document).ready(function() {
	
});
function checkImport(){
	$.post('/excel/checkProgress.action',{},function(data){
		if(data==null || data=='null' || data=='导入结束'){
			
		}else{
			window.frames['progressIFrame'].document.getElementById('importButton').style.display = 'none';
			loadProgress(data);
		}
	});
}
function loadProgress(message){
	$.post('/excel/updateProgress.action',{message:message},function(data){
		if(data=='导入结束'){
		//	$('#txt').text(data);
			$('#bg').attr("style",'width: 100%;');
		}else{
			var result = new String(data);
			var s = result.substring(result.indexOf('：')+1);
			$('#bg').attr("style",'width: '+s+';');
			$('#txt').text(data==null||data=='null'?'进度':data);
			loadProgress(data);
		}
	});
}
</script>
</head>
<body>
	<div class="form_rowelem" style="height: 220px;">
	<iframe id="progressIFrame" name="progressIFrame" src="/excel/fileForm.action?${parameters}" width="100%" height="220px" frameborder="0" scrolling="no"></iframe>
	</div>
	<div class="form_rowelem">
		<div class="form_rowelem">
			<div class="work_progressbar">
				<div class="work_progressbar_bg" style="width: 0%;" id="bg"></div>
   				<strong class="work_progressbar_text" id="txt">进度</strong>
   			</div>
		</div>
	</div>
	<input type="hidden" id="flag" value="0"/>
</body>
</html>