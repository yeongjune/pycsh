<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>${title }</title>
<%@include file="/common/taglibs.jsp" %>
<%-- include file="/common/kindeditor.jsp" --%> 
<script type="text/javascript" charset="utf-8" src="/plugin/ueditor_1.4.3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/plugin/ueditor_1.4.3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="/plugin/ueditor_1.4.3/lang/zh-cn/zh-cn.js"></script>
<link href="${css }/skins/blue/css/article.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	var articleAdd;
    var ue;//ueditor编辑器实例变量
	$(function(){
		articleAdd = new ArticleAdd('${article.id}','${column.id}','${column.type}');
		if(articleAdd.articleId){
			$("#submitButton span").text("保存");
		}else{
			//根据栏目控制显示值
			if("单网页"==articleAdd.type){
				$('#title').val('${column.name}');
			}
		}
		
		//根据栏目类型名控制显示
		if("新闻栏目"==articleAdd.type||"外部连接"==articleAdd.type){
			$(".div_img_1_1").hide();
		}else if("单网页"==articleAdd.type){
			$(".div_title_1_1").hide();
			$(".div_title_1_2").hide();
			$(".div_img_1_1").hide();
			$(".div_recommend_1_1").hide();
			$(".div_file_1_1").hide();
		}else if("图片栏目"==articleAdd.type){
			$(".div_title_1_2").hide();
			$(".div_content_1_1").hide();
			$(".div_smallPic_1_1").hide();
			$(".div_recommend_1_1").hide();
			$(".div_file_1_1").hide();
		}
		//实例化编辑器
		ue = UE.getEditor('myEditor');
		UE.getEditor('myEditor').ready(function(){
			this.execCommand('serverparam',{
				'tempId':'${empty article ? tempId : article.tempId}',
				'articleId':'${article.id}'
			});
		});
	});
	
	function ArticleAdd(articleId,columnId,type){
		this.articleId=articleId;//新闻id
		this.columnId= columnId; //新闻栏目id
		this.type=type;			 //新闻栏目类型：
		
		this.save = function(){
			var title = $('#title').val();
			var content =UE.getEditor('myEditor').getContent(); //editor.html();
			var smallPicUrl=$("#smallPicUrl").val();
			var imageIds=$("#imageIds").val();
			
			var recommend='';
			$("input[name='recommend']:checked").each(function(){
				recommend+=$(this).val()+",";
			});
			if (recommend) {
				recommend=recommend.substring(0, recommend.length-1);
			}
			
			if("新闻栏目"==articleAdd.type||"外部连接"==articleAdd.type||"单网页"==articleAdd.type){
				if(!title){
					art.dialog.alert('标题不能为空');
					return;
				}
				if(!content){
					art.dialog.alert('内容不能为空');
					return;
				}
			}else if("图片栏目"==articleAdd.type){
				var countImage=$("#div_item_imgList img").length;
				if(!title){
					art.dialog.alert('标题不能为空');
					return;
				}
				if(countImage<1){
					art.dialog.alert('请上传至少一张图片');
					return;
				}
			}
			
			lockWindow();
			var url=articleId?"/article/update.action":"/article/save.action";
			$.post(url, {tempId:$("#tempId").val(),id:articleId,columnId: this.columnId,type: this.type,recommendIds: recommend,title: title,title2:$("#title2").val(), content: content,smallPicUrl:smallPicUrl,imageIds:imageIds }, function(data){
				openLock();
				if(data=='succeed'){
					art.dialog.opener.articleManager.load();
					art.dialog.close();
				}else{
					if(articleId){
						art.dialog.alert('保存失败');
					}else{
						art.dialog.alert('发布失败');
					}
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
	<fieldset class="fieldset_border" style="margin:0px;padding:10px 20px;">
		<form action="">
			<input id="tempId" type="hidden" value="${ (not empty tempId) ?tempId:article.tempId }" />
			<input id="articleId" type="hidden" value="${article.id}" />
			<input id="imageIds" type="hidden" />
		    
		    <div class="view_rank">
				<span class="form_span">栏目：</span>
				<span class="form_span" style="text-align: left;" id="columnName">${column.name}</span>
			</div>
			
			<div class="form_item div_title_1_1">
				<span class="form_span">标题：</span>
				<input type="text" id="title" class="piece" style="width:500px;" value="${article.title }" /><font color="red" id="title_tip">必填项</font>
			</div>
			<div class="form_item div_title_1_2">
				<span class="form_span">副标题：</span>
				<input type="text" id="title2" class="piece" style="width:500px;" value="${article.title2 }" /><font id="title2_tip">可以不填</font>
			</div>
			
			<!-- 缩略图 -->
			<div class="form_item div_smallPic_1_1">
				<span class="form_span">缩略图：</span>
				<table>
					<tr>
						<td>
							<input  type="hidden" id="smallPicUrl" value="${article.smallPicUrl }"/>
							<div id="div_item_smallPic">
							    	<img class="smallPic" alt="缩略图"  src="${not empty article.smallPicUrl ? article.smallPicUrl : '/skins/blue/images/default.jpg' }"  />
							    	<c:if test="${not empty article.smallPicUrl}">
							    		<a onclick="deleteFileByPath('${article.smallPicUrl }')">删除</a>
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
			
			<!-- 文章内容开始 -->
			<%--
			<div class="form_item div_content_1_1">
				<span class="form_span">内容：</span>
				<textarea name="content" id="myEditor"  style="min-width: 795px;min-height: 314px;" maxlength="60000">${article.content }</textarea>  
				<font color="red" id="content_tip"></font>
			</div>
			--%>
			<div class="form_item div_content_1_1">
				 <div style="width:140px;text-align: right;float:left;">内容：</div>
				 <script id="myEditor" type="text/plain" style="width:1000px;min-height:320px;float:left;">${article.content }</script>
			</div>
			<!-- 文章内容结束 -->
			
			<!-- 图片列表 -->
			<div class="form_item div_img_1_1">
					<span class="form_span">上传图片：</span>
					<div>
						<c:import url="/common/swfUpload1.jsp">
							<c:param name="types">*.jpg;*.gif;*.png;*.bmp;*.jpeg</c:param>
							<c:param name="upload_size">1000</c:param>
							<c:param name="type">1</c:param>
							<c:param name="limit">0</c:param>
							<c:param name="index">2</c:param>
						</c:import>	
					</div>
					
			</div>
			<div class="form_item div_img_1_1" >
				<div id="div_item_imgList"><!-- 该div用于显示已上传的图片 ，请不要修改Id-->
					<c:forEach var="image" items="${imageList }">
					 	<div id="div_img_list_${image.id }">
					 		<img src="${image.path }" alt="${image.fileName }" />
					 		<a href="javascript:;" onclick="deleteImg(${image.id})">删除</a>
					 		<a href="javascript:;" onclick="editImg(${image.id})">编辑</a>
					 	</div>
					</c:forEach>
				</div>
			</div>
			<!-- 图片列表结束 -->
			
			<!-- 附件开始 -->
			<div class="form_item div_file_1_1">	
				<span class="form_span">附件：</span>
				<div class="right_introduction">
					<c:import url="/common/swfUpload2.jsp">
					    <c:param name="limit">0</c:param>
						<c:param name="types">*.*</c:param>
						<c:param name="upload_size">1000</c:param>
						<c:param name="type">3</c:param>
						<c:param name="index">3</c:param>
					</c:import>	
					
					<c:forEach var="file" items="${fileList }">
						<div class="flash" id="div_file_${file.id }">
							<div class="progressContainer blue" >
								<a class="progressCancel" href="javascript:void(0);" onclick="deleteFile(${file.id})"> </a>
								<div class="progressName">${file.fileName}</div>
							</div>
						</div>
					</c:forEach>
				</div>
				
			</div>
			<!-- 附件结束 -->
			
			<!-- 推荐位置开始 -->
			<div class="form_item div_recommend_1_1">
				<span class="form_span" style="float: left;">推荐位置：</span>
				<div class="right_introduction">
					<ul class="listCommand">
						<c:forEach var="recommend" items="${recommendList}">
							<c:if test="${recommend.checked eq 'checked'}">
								<li><label><input name="recommend" type="checkbox" value="${recommend.id}" checked="checked" /> ${recommend.name}</label></li>
							</c:if>
							<c:if test="${empty  recommend.checked}">
								<li><label><input name="recommend" type="checkbox" value="${recommend.id}" /> ${recommend.name}</label></li>
							</c:if> 
						</c:forEach>
					</ul>
				</div>
			</div>
			<!-- 推荐位置结束 -->
			<div class="clear"></div>
			<div class="form_submit">
				<a href="javascript:articleAdd.save()" class="base_btn" id="submitButton"><span>发布</span></a>
			</div>
		
			<div class="clear"></div>
		</form>
	</fieldset>
<%--
<style type="text/css">
/* kindeditor多文件上传布局问题样式控制  */
.ke-dialog-content .swfupload{
		height: 23px;
		position :static;
}
</style>
 --%>
</body>
</html>