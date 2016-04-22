<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>title</title>
<%@include file="/common/taglibs.jsp" %>
</head>
<body>
	<fieldset class="fieldset_border">
		<form action="" id="myform">
			<div class="form_item">
				<span class="form_span">名称：</span>
				<input type="text" id="name" class="piece" onblur="templateUpdate.checkName()"/><font color="red" id="name_tip"></font>
			</div>
			<div class="form_submit">
				<a href="javascript:templateAdd.save()" class="base_btn" id="submitButton"><span>提交</span></a>
			</div>
			<div class="clear"></div>
		</form>
	</fieldset>

	<script type="text/javascript">
		function TemplateAdd(){
			this.allowSubmit = false;
			this.save = function(){
				var name = $('#name').val();
				this.checkName();
				if(this.allowSubmit && name && name.trim()!=''){
					lockWindow();
					$.post('/templet/save.action', {name: name}, function(data){
						openLock();
						if(data=='succeed'){
							art.dialog.opener.templateManager.load();
							art.dialog.close();
						}else{
							alert('保存失败');
						}
					});
				}else{
					if(name.trim()!=''){
						$('#name_tip').text('');
					}else{
						$('#name_tip').text('名称不能为空');
					}
				}
			};
			this.checkName = function(){
				var name = $('#name').val();
				if(name && name.trim()!=''){
					$.ajax({
						url:'/templet/nameIsExist.action',
						data:{name:name},
						async:false,
						success:function(data, textStatus){
							if(data=='false'){
								templateAdd.allowSubmit = true;
								$('#name_tip').text('');
							}else{
								templateAdd.allowSubmit = false;
								if(data=='true'){
									$('#name_tip').text('名称已经存在');
								}else{
									$('#name_tip').text('');
								}
							}
						}
					});
				}else{
					templateAdd.allowSubmit = false;
					$('#name_tip').text('名称不能为空');
				}
			};
		}
		var templateAdd = new TemplateAdd();
	</script>
</body>
</html>