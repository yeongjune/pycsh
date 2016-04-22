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
			<div class="view_rank">
				<span class="view_rank_span">ID：</span>${id }
			</div>
			<div class="form_item">
				<span class="form_span">名称：</span>
				<input type="text" id="name" class="piece"/><font color="red" id="name_tip"></font>
			</div>
			<div class="form_item">
				<span class="form_span">域名：</span>
				<input type="text" id="domain" class="piece" onblur="siteUpdate.checkDomain()"/><font color="red" id="domain_tip"></font>
			</div>
			<div class="form_item">
				<span class="form_span">页面文件目录：</span>
				<input type="text" id="directory" class="piece" onblur="siteAdd.checkDirectory()"/><font color="red" id="directory_tip"></font>
			</div>
			<div class="form_item">
				<span class="form_span">文章发布是否审核：</span>
				<input type="radio"  name="isUseCheck" value="1" /> 是
				<input type="radio"  name="isUseCheck" value="0" /> 否
			</div>
			<div class="form_submit">
				<a href="javascript:siteUpdate.update()" class="base_btn"><span>提交</span></a>
			</div>
			<div class="clear"></div>
		</form>
	</fieldset>

	<script type="text/javascript">
		function SiteUpdate(id){
			this.id = id;
			this.load = function(){
				$.post('/site/load.action',{id:this.id},function(data){
					var site = $.parseJSON(data);
					$('#name').val(site.name);
					$('#domain').val('http://'+site.domain);
					$('#directory').val(site.directory);
					$('input[name="isUseCheck"] ').each(function(i){
						if($(this).val() == site.isUseCheck){$(this).attr('checked',true)}
					}); 
				});
			};
			this.update = function(){
				var name = $('#name').val();
				if(this.checkDomain() && this.checkDirectory() && name && name.trim()!=''){
					var domain = $('#domain').val();
					var directory = $('#directory').val();
					var isUseCheck = $('input[name="isUseCheck"]:checked').val();
					lockWindow();
					$.post('/site/update.action', {id: this.id, name: name, domain: domain, directory: directory, isUseCheck:isUseCheck}, function(data){
						openLock();
						if(data=='succeed'){
							art.dialog.opener.siteManager.load();
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
			this.checkDomain = function(){
				var bool = false;
				var domain = $('#domain').val();
				if(domain && domain.trim()!='http://'){
					$.ajax({
						url:'/site/domainIsExistWithSelf.action',
						data:{id: this.id, domain: domain},
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
						url:'/site/directoryIsExistWithSelf.action',
						data:{id: this.id, directory: directory},
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
		var siteUpdate = new SiteUpdate('${id}');
		siteUpdate.load();
	</script>
</body>
</html>