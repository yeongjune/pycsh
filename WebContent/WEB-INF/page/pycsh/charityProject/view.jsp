<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>${title }</title>
<%@include file="/common/taglibs.jsp" %>
</head>
<body>
	
		<div class="form_item div_title_1_1">
			<span class="form_span"><font color="red" id="title_tip">*</font>项目名称：</span>
			<input type="text" id="name" readonly="readonly" class="piece" style="width:500px;" value="${project.name }" maxlength="100" />
		</div>
		<div class="form_item div_title_1_2">
			<span class="form_span"><font color="red" id="title_tip">*</font>项目类型：</span>
			<input type="text" class="piece" readonly="readonly" style="width:500px;" value="${project.type }" maxlength="100" />
		</div>
		
		<div class="form_item">
			<span class="form_span"><font color="red" id="title_tip" >*</font>项目预算(元)：</span>
			<input type="text" id="targer" readonly="readonly" class="piece" style="width:500px;" value="<fmt:formatNumber value="${project.targer }" pattern="#.00"></fmt:formatNumber>"  onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"/>
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

						    	
						</div>
					</td>

				</tr>
			</table>
		</div>
		<!-- 缩略图 结束-->
		
		<div class="form_item div_introduce">
			<span class="form_span">简介：</span>
			<textarea name="introduce" id="introduce" readonly="readonly" class="piece"  style="width: 480px;max-width: 480px;height: 50px;max-height:100px;" >${project.introduce }</textarea>  
		</div>
		
		<div class="form_item div_content_1_1">
			 <div style="width:140px;text-align: right;float:left;">内容：</div>
			 <span>
			 	${project.contents }
			 </span>
		</div>
		<div class="clear"></div>
		<div class="form_item div_title_1_1" style="margin-top: 10px;">
			<span class="form_span"><font color="red" id="title_tip">*</font>申报书：</span>
			<input type="hidden" name="application" id="application" value="${project.application }" />
			<input type="hidden" name="originalName" id="originalName" value="${project.originalName }" />
			<span id="applicationSpan"><a href="${project.application }">${project.originalName }</a></span>
		</div>
		<!-- 文章内容结束 -->
		<div class="clear"></div>

</body>
</html>