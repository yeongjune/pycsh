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
		<form action="">
			<div class="form_item">
				<span class="form_span">名称：</span>
				<input type="text" id="name" class="piece"/><font color="red" id="name_tip"></font>
			</div>
			<div class="form_item">
				<span class="form_span">域名：</span>
				<input type="text" id="domain" value="http://" class="piece" onblur="siteAdd.checkDomain()"/><font color="red" id="domain_tip"></font>
			</div>
			<div class="form_item">
				<span class="form_span">页面文件目录：</span>
				<input type="text" id="directory" class="piece" onblur="siteAdd.checkDirectory()"/><font color="red" id="directory_tip"></font>
			</div>
			<div class="form_submit">
				<a href="javascript:siteAdd.save()" class="base_btn" id="submitButton"><span>提交</span></a>
			</div>
			<div class="clear"></div>
		</form>
	</fieldset>

	<script type="text/javascript">
		function SiteAdd(){
			this.save = function(){
				var name = $('#name').val();
				if(this.checkDomain() && this.checkDirectory() && name && name.trim()!=''){
					var domain = $('#domain').val();
					var directory = $('#directory').val();
					lockWindow();
					$.post('/site/save.action', {name: name, domain: domain, directory: directory}, function(data){
						openLock();
						if(data=='succeed'){
							art.dialog.opener.siteManager.load();
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
			this.checkDomain = function(){
				var bool = false;
				var domain = $('#domain').val();
				if(domain && domain.trim()!='http://'){
					$.ajax({
						url:'/site/domainIsExist.action',
						data:{domain: domain},
						async:false,
						success:function(data, textStatus){
							if(data=='false'){
								bool = true;
								$('#domain_tip').text('');
							}else{
								bool = false;
								if(data=='true'){
									$('#domain_tip').text('域名已经存在');
								}else{
									$('#domain_tip').text('');
								}
							}
						}
					});
				}else{
					bool = false;
					$('#domain_tip').text('域名不能为空');
				}
				return bool;
			};
			this.checkDirectory = function(){
				var bool = false;
				var directory = $('#directory').val();
				if(directory && directory.trim()!=''){
					$.ajax({
						url:'/site/directoryIsExist.action',
						data:{directory: directory},
						async:false,
						success:function(data, textStatus){
							if(data=='false'){
								bool = true;
								$('#directory_tip').text('');
							}else{
								bool = false;
								if(data=='true'){
									$('#directory_tip').text('页面文件目录已经存在');
								}else{
									$('#directory_tip').text('');
								}
							}
						}
					});
				}else{
					bool = false;
					$('#directory_tip').text('页面文件目录不能为空');
				}
				return bool;
			};
		}
		var siteAdd = new SiteAdd();
	</script>
</body>
</html>