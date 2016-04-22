<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
var editFriendlyLink;
$(function(){
	editFriendlyLink=new EditFriendlyLink("${friendlyLink.id}");
});

function EditFriendlyLink(id){
	this.id=id;
	this.save = function (){
		var name=$("#name").val();
		var linkUrl=$("#linkUrl").val();
		if(!name){
			$("#name_tip").text('名称不能不为空');
			return;
		}else{
			$("#name_tip").text('');
		}
		if(!linkUrl){
			$("#linkUrl_tip").text('链接地址不能为空');
			return;
		}else{
			$("#linkUrl_tip").text('');
		}
		$.post('/friendlylink/save.action',{id : editFriendlyLink.id, name : name, linkUrl : linkUrl} ,function (data){
			if(data == 'succeed'){
				art.dialog.opener.mngFriendyLink.load();
				art.dialog.close();
				/* art.dialog({
					title: "提示",
					content: "保存成功"
				}).time(3); */
			}else{
				if(editFriendlyLink.id){
					art.dialog.tips("修改失败");    
				}else{
					art.dialog.tips("新增失败");    
				}
			}
		});
	};
}
</script>
</head>
<body>
<fieldset class="fieldset_border" style="margin:0px;padding:10px 20px;">
		<form action="">
		    <div style="float:left;">
			    <div class="form_item">
					<span class="form_span">名称：</span>
					<input type="text" id="name" name="name" class="piece" value="${friendlyLink.name }" maxlength="50" /><font color="red" id="name_tip"></font>
				</div>
				<div class="form_item"	id="div_content">
					<span class="form_span">链接地址：</span>
					<input type="text" id="linkUrl" name="linkUrl" class="piece" value="${friendlyLink.linkUrl }" maxlength="50" /><font color="red" id="linkUrl_tip"></font>  
				</div>
		    </div>
		    <div class="clear"></div>
			<div class="form_submit">
					<a href="javascript:editFriendlyLink.save()" class="base_btn" id="submitButton"><span>保存</span></a>
			</div>
			<div class="clear"></div>
		</form>
	</fieldset>
</body>
</html>