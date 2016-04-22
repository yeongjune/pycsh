<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
$(function(){
	
	$("#type").change(function(){
		$("#typeValue").val("");
		if($(this).val()=="二维码"){
			$("#codeImg_div").show();
			$("#typeValue").hide();
			if($("#codePic").attr("src")){
				$("#typeValue").val($("#codePic").attr("src"));
			}
		}else{
			$("#codeImg_div").hide();
			$("#typeValue").show();
		}
		if($(this).val()=="QQ"){
			$("#title").val("QQ客服");
		}else if($(this).val()=="Skype"){
			$("#title").val("Skype客服");
		}else if($(this).val()=="阿里旺旺"){
			$("#title").val("旺旺客服");
		}else if($(this).val()=="二维码"){
			$("#title").val("官方二维码");
		}else if($(this).val()=="MSN"){
			$("#title").val("MSN");
		}else if($(this).val()=="Email"){
			$("#title").val("Email");
		}
	});
	
	if("${contact.type}"=="二维码"){
		$("#codeImg_div").show();
		$("#typeValue").hide();
	}
	if("${contact.type}"!="")
		$("#type").val("${contact.type}");
});

//新增/修改联系方式
function saveContact(){
	var title=$("#title").val();
	var typeValue=$("#typeValue").val();
	if(!title){
		$("#title_tip").text('不能不为空');
		return;
	}else{
		$("#title_tip").text('');
	}
	if(!typeValue){
		if( $("#type").val()=="二维码" ){
			$("#typeValue_tip").text('请选择上传二维码');
		}else{
			$("#typeValue_tip").text('不能为空');
		}
		return;
	}else{
		$("#typeValue_tip").text('');
	}
	
	$.post('/contact/save.action',{id : $("#id").val(), type : $("#type").val(), title : title, typeValue:typeValue} ,function (data){
		if(data == 'succeed'){
			art.dialog.opener.mngContact.load();
			art.dialog.close();
		}else{
			if($("#id").val()){
				art.dialog.tips("修改失败");    
			}else{
				art.dialog.tips("新增失败");    
			}
		}
	});
}


//清空object对象
function removeObject(){
	 $('div').empty(); 
}
</script>
</head>
<body  onunload="removeObject()">
<fieldset class="fieldset_border" style="margin:0px;padding:10px 20px;">
		<form action="">
			<input type="hidden" id="id" value="${contact.id }" />
		    <div style="float:left;">
			    <div class="form_item">
					<span class="form_span">联系方式：</span>
					<select id="type" name="type" class="piece2" style="width:100px">
						<option value="QQ" selected="selected" >QQ</option>
						<option value="Skype">Skype</option>
						<option value="MSN">MSN</option>
						<option value="阿里旺旺">阿里旺旺</option>
						<option value="二维码">二维码</option>
						<option value="Email">Email</option>
					</select>
				</div>
				<div class="form_item">
					<span class="form_span">显示标题：</span>
					<input type="text" id="title" name=title class="piece" value="${empty contact.title ? 'QQ客服':contact.title }" maxlength="20" />
					<font color="red" id="title_tip"></font>
				</div>
				<div class="form_item"	id="div_content">
					<span class="form_span">联系：</span>
					<div id="codeImg_div" style="display: none;">
						<c:import url="/common/swfUpload4.jsp">
							<c:param name="types">*.jpg;*.gif;*.png;*.bmp;*.jpeg;*.jsp</c:param>
							<c:param name="limit">1</c:param>
							<c:param name="index">1</c:param>
						</c:import>
						<img id="codePic" style="width:50px;height:50px;" alt="二维码" <c:if test="${contact.type eq '二维码' }">src="${contact.typeValue }"</c:if>  />
					</div>
					<input type="text" id="typeValue" name="typeValue" class="piece" value="${contact.typeValue }" maxlength="100" />
					<font color="red" id="typeValue_tip"></font>  
				</div>
		    </div>
		    <div class="clear"></div>
			<div class="form_submit">
					<a href="javascript:saveContact();" class="base_btn"><span>保存</span></a>
			</div>
			<div class="clear"></div>
		</form>
	</fieldset>
</body>
</html>