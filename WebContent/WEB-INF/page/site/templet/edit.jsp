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
			<div class="view_rank">
				<span class="view_rank_span">ID：</span>${id }
			</div>
			<div class="form_item">
				<span class="form_span">名称：</span>
				<input type="text" id="name" class="piece" onblur="templateUpdate.checkName()"/><font color="red" id="name_tip"></font>
			</div>
			<div class="form_submit">
				<a href="javascript:templateUpdate.update()" class="base_btn"><span>提交</span></a>
			</div>
			<div class="clear"></div>
		</form>
	</fieldset>

	<script type="text/javascript">
		function TemplateUpdate(id){
			this.id = id;
			this.allowSubmit = false;
			this.load = function(){
				$.post('/templet/load.action',{id:this.id},function(data){
					var template = $.parseJSON(data);
					$('#name').val(template.name);
				});
			};
			this.update = function(){
				var name = $('#name').val();
				this.checkName();
				if(this.allowSubmit && name && name.trim()!=''){
					lockWindow();
					$.post('/templet/update.action', {id: this.id, name: name}, function(data){
						openLock();
						if(data=='succeed'){
							art.dialog.opener.templateManager.load();
							art.dialog.close();
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
						url:'/templet/nameIsExistWithSelf.action',
						data:{id: this.id, name: name},
						async:false,
						success:function(data, textStatus){
							if(data=='false'){
								templateUpdate.allowSubmit = true;
								$('#name_tip').text('');
								$('#submitButton').show();
							}else{
								templateUpdate.allowSubmit = false;
								$('#submitButton').hide();
								if(data=='true'){
									$('#name_tip').text('名称已经存在');
								}else{
									$('#name_tip').text('');
								}
							}
						}
					});
				}else{
					templateUpdate.allowSubmit = false;
					$('#name_tip').text('名称不能为空');
					$('#submitButton').hide();
				}
			};
		}
		var templateUpdate = new TemplateUpdate('${id}');
		templateUpdate.load();
	</script>
</body>
</html>