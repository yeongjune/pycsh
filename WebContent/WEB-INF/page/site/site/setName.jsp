<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>${title }</title>
<script type="text/javascript">
function saveSiteName(){
	var name=$("#name").val();
	if (!name) {
		$("#name_tip").text('站点名不能为空');
	}else{
		$("#name_tip").text('');
		$.post('/site/updateSiteName.action',{name:name},function(data){
			if(data=="succeed"){
				art.dialog.tips('<br/>成功保存站点名设置，需要关闭浏览器后<br/>再进入网站方能看到修改后的站点名<br/>');
			}else{
				art.dialog.alert('保存站点名设置失败');
			}
		});
	}
}
</script>
</head>
<body>
	<fieldset class="fieldset_border">
		<legend  class="legend_title">设置站点名</legend>
		<form action="">
			<div class="form_item">
				<span class="form_span">站点名：</span>
				<input type="text" id="name" class="piece" value="${name }"  onkeydown="if(event.keyCode==13){saveSiteName();}" maxlength="200" /><font color="red" id="name_tip">*</font>
			</div>
			<div class="form_submit">
				<a href="javascript:saveSiteName();" class="base_btn"><span>保存</span></a>
			</div>
			<div class="clear"></div>
		</form>
	</fieldset>
</body>
</html>