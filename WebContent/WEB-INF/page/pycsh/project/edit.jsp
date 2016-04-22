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
	var projectAdd;
    var ue;//ueditor编辑器实例变量
	$(function(){
		projectAdd = new ProjectAdd();
		
		//实例化编辑器
		ue = UE.getEditor('myEditor',{'enterTag':''});//enterTag为指定不增加p标签
		UE.getEditor('myEditor').ready(function(){
			
		});
	});
	
	function ProjectAdd(){
		
		this.save = function(){
			var name = $('#name').val();
			var targer = $('#targer').val();
			var type1 = $('#type1').val();
			var type2 = $('#type2').val();
			var startTime = $('#startTime').val();
			var endTime = $('#endTime').val();
			var introduce=$("#introduce").val();
			var content =UE.getEditor('myEditor').getContent(); //editor.html();
			var smallPicUrl=$("#smallPicUrl").val();
			var imageIds=$("#imageIds").val();
			
			var originalPath = $('#smallPicUrl').attr('data-original-path');
			if( !originalPath || originalPath.trim() == '' ){
				originalPath = smallPicUrl;
			}
			
			if(""==name){
				art.dialog.alert('项目名称不能为空');
				return;
			}else if(""==type1){
				art.dialog.alert('类型不能为空');
				return;
			}else if(""==targer){
				art.dialog.alert('募款目标不能为空');
				return;
			}else if(""==startTime || ""==endTime){
				art.dialog.alert('募款周期不能为空');
				return;
			}else if(""==introduce){
				art.dialog.alert('简介不能为空');
				return;
			}else if(""==content){
				art.dialog.alert('内容不能为空');
				return;
			}
			
			lockWindow();
			var url = "/project/update.action";
			$.post(url, {tempId:$("#tempId").val(),
							name: name,
							type1: type1,
							type2: type2,
							targer: targer,
							startTime: startTime,
							endTime: endTime,
							introduce:introduce, 
							content: content,
							smallPicUrl:smallPicUrl,
							imageIds:imageIds,
							smallPicOriginalUrl : originalPath,
							id:"${project.id}"}, function(data){
				openLock();
				if(data=='succeed'){
					art.dialog.opener.projectManager.load();
					art.dialog.close();
				}else{
					art.dialog.alert('保存失败');
				}
			});
			
		};
	}
	//清空object对象
	function removeObject(){
		 $('div').empty(); 
	}
	//根据文件id删除 附件
	function deleteFile(imgId){
		delAttchment("/image/deleteById.action?id="+imgId, null, imgId,3);
	}
	//根据文件路径 删除 缩略图
	function deleteFileByPath(path){
		if(path){
			delAttchment("/image/deleteSmallPath.action?path="+path+"&articleId=${article.id}", null,null,2);
		}
	}
	//删除图片列表图片
	function deleteImg(imgId){
		var url="/image/deleteById.action?id="+imgId;
		delAttchment(url, null, imgId,1);
	}
	//编辑图片列表图片信息
	function editImg(imgId){
		art.dialog.open("/image/toEdit.action?id="+imgId,{
			title:'编辑图片信息',
			width:'800px',
			height:'400px',
			resize:true
		});
	}
	
</script>
</head>
<body onunload="removeObject()">
	<form action="">
		<input id="tempId" type="hidden" value="${ (not empty tempId) ?tempId:article.tempId }" />
		<input id="articleId" type="hidden" value="${article.id}" />
		<input id="imageIds" type="hidden" />
		
		<div class="form_item div_title_1_1">
			<span class="form_span"><font color="red" id="title_tip">*</font>项目名称：</span>
			<input type="text" id="name" class="piece" style="width:500px;" value="${project.name }" maxlength="200" />
		</div>
		<div class="form_item div_title_1_2">
			<span class="form_span"><font color="red" id="title_tip">*</font>项目类型：</span>
			<c:import url="/projectType/projectTypeSelect.action">
				<c:param name="id1" value="type1"></c:param>
				<c:param name="defaultValue1" value="${project.type1 }"></c:param>
				<c:param name="id2" value="type2"></c:param>
				<c:param name="defaultValue2" value="${project.type2 }"></c:param>
				<c:param name="pId" value=""></c:param>
				<c:param name="category" value="project"></c:param>
			</c:import>
		</div>		
		
		<div class="form_item">
			<span class="form_span"><font color="red" id="title_tip">*</font>募款目标(元)：</span>
			<input type="text" id="targer" class="piece" style="width:500px;" value="<fmt:formatNumber value="${project.targer }" type="number" pattern="#.00"></fmt:formatNumber>" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"/>
		</div>
		<div class="form_item">
			<span class="form_span"><font color="red" id="title_tip">*</font>周期：</span>
			<input type="text" name="startTime" id="startTime" class="piece" value="<fmt:formatDate value="${project.startTime }"  type="date" pattern="yyyy-MM-dd"/>" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\',{d:0})}'})" maxlength="10" style="width:85px"  />
			至
			<input type="text" name="endTime" id="endTime" class="piece" value="<fmt:formatDate value="${project.startTime }"  type="date" pattern="yyyy-MM-dd"/>" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTime\',{d:0})}'})" maxlength="10"  style="width:85px"  />
		</div>
		
		<!-- 缩略图 -->
		<div class="form_item div_smallPic_1_1">
			<span class="form_span">缩略图：</span>
			<table>
				<tr>
					<td>
						<input  type="hidden" id="smallPicUrl" value="${project.smallPicUrl }" data-original-path="${project.smallPicOriginalUrl }"/>
						<div id="div_item_smallPic">
						    	<img class="smallPic" alt="缩略图"  src="${not empty project.smallPicUrl ? project.smallPicUrl : '/skins/blue/images/default.jpg' }"  />
						    	<c:if test="${not empty project.smallPicUrl}">
						    		<a onclick="deleteFileByPath('${project.smallPicUrl }')">删除</a>
						    	</c:if>
						    	
						</div>
					</td>
					<td style="vertical-align: bottom;">
						<c:import url="/common/swfUpload.jsp">
						    <c:param name="limit">1</c:param>
							<c:param name="types">*.jpg;*.gif;*.png;*.bmp;*.jpeg</c:param>
							<c:param name="upload_size">1000</c:param>
							<c:param name="type">2</c:param>
							<c:param name="index">1</c:param>
						</c:import>								
					</td>
				</tr>
			</table>
		</div>
		<!-- 缩略图 结束-->
		
		<div class="form_item div_introduce">
			<span class="form_span">简介：</span>
			<textarea name="introduce" id="introduce" class="piece"  style="width: 980px;max-width: 980px;height: 50px;max-height:100px;" >${project.introduce }</textarea>  
		</div>
		
		<div class="form_item div_content_1_1">
			 <div style="width:140px;text-align: right;float:left;">内容：</div>
			 <script id="myEditor" type="text/plain" style="width:986px;min-height:320px;float:left;">${project.contents }</script>
		</div>
		<!-- 文章内容结束 -->
		<div class="clear"></div>
		<div class="form_submit">
			<a href="javascript:projectAdd.save()" class="base_btn" id="submitButton"><span>保存</span></a>
		</div>
		<div class="clear"></div>
	</form>
</body>
</html>