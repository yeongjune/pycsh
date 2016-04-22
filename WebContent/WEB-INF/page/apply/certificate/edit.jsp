<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
var editCertificate;
$(function(){
	editCertificate=new EditCertificate("${certificate.id}");
});

function EditCertificate(id){
	this.id=id;
	this.checkName = function (){
		if(!$("#name").val())
			return;
		$.post('/certificate/checkName.action',{id : this.id,name : $("#name").val()} ,function (data){
			if(data=='fail'){
				$("#name_tip").text('已存在');
			}else if(data=='false'){
				$("#name_tip").text('未进入站点管理');
			}else{
				$("#name_tip").text('');
			}
		});
	};
	this.save = function (){
		var name=$("#name").val();
		var remark=$("#remark").val();
		if(!name){
			$("#name_tip").text('证件名不能不为空');
			return;
		}else{
			$("#name_tip").text('');
		}
		$.post('/certificate/checkName.action',{id : this.id,name : $("#name").val()} ,function (data){
			if(data=='fail'){
				$("#name_tip").text('已存在');
			}else if(data=='false'){
				$("#name_tip").text('未进入站点管理');
			}else{
				$("#name_tip").text('');
				$.post('/certificate/doSave.action',{id : editCertificate.id, name : name, remark : remark} ,function (data){
					if(data == 'succeed'){
						art.dialog.opener.mngCertificate.load();
						art.dialog.close();
					}else{
						if(editCertificate.id){
							art.dialog.tips("修改失败");    
						}else{
							art.dialog.tips("新增失败");    
						}
					}
				});
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
			    <div class="view_rank">
					<span class="form_span">证件名：</span>
					<input type="text" id="name" class="piece" value="${certificate.name }" maxlength="50" onblur="editCertificate.checkName()" /><font color="red" id="name_tip"></font>
				</div>
				<div class="form_item"	id="div_content">
					<span class="form_span">备注：</span>
					<textarea name="remark" id="remark" class="maxlength_1000"  style="width:280px;height:60px;" maxLength="200">${certificate.remark }</textarea>  
				</div>
		    </div>
		    <div class="clear"></div>
			<div class="form_submit">
					<a href="javascript:editCertificate.save()" class="base_btn" id="submitButton"><span>保存</span></a>
			</div>
			<div class="clear"></div>
		</form>
	</fieldset>
</body>
</html>