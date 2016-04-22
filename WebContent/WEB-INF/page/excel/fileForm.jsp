<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%@include file="/common/taglibs.jsp" %>
<script type="text/javascript">
var message = "${message}";
var parameters = "${parameters}";
$(document).ready(function() {
	if(message){
		window.parent.showMessage(message);
	}
	if(parameters.search('workbook')<0){
		$('#importDiv').hide();
	}else{
		$('#importDiv').show();
	}
	window.parent.checkImport();
});
function loadProgress(){
	var v = $('#file_input').val();
	if(v){
		$('#importButton').hide();
		window.parent.document.getElementById("flag").value = 1;
		window.parent.loadProgress();
		return true;
	}else{
		return false;
	}
}
</script>
</head>
<body>
	<div id="importDiv" style="display: none;">
		<div class="import_tip">${tip}</div>
		<form action="/excel/import.action?1=1${parameters}" enctype="multipart/form-data" method="post" name="formName" id="formId" onsubmit="return loadProgress()">
			<div class="form_rowelem" style="width:300px;margin:0 auto;">
				<div class="file-box">
			        <input type='text' id='textfield' class='file-txt' />  
			        <input type='button' class='file-btn' value='浏览...' />
			        <input type="file" id="file_input" name="file" size="18" class="file-file" reg="\S+" id="fileField" onchange="document.getElementById('textfield').value=this.value" />
			        <input type="submit" id="importButton" class="file-btn" value="上传" />     
				</div>
			</div>
		</form>
	</div>
</body>
</html>