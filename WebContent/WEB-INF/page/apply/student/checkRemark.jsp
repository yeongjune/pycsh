<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
function checkNotPass(){
	var remarkContent=$("#remarkContent").val();
	var checkRemark=$("#remarkType").val()+(remarkContent?","+$("#remarkContent").val():'');
	if(!$("#admit").val()){//修改报名状态
		var temp=$("#status").val()==2?"审核不通过":"审核回退";
		$.post('/student/doChangeStatus.action',{ids:$("#ids").val(),status:$("#status").val(),checkRemark:checkRemark},function(data){
		    if(data.code=='succeed'){
		    	art.dialog.opener.mngStudent.load();
				art.dialog({icon:'succeed',title:'操作结果',  content: temp+ '操作成功',time:3,close:function(){
					art.dialog.close();
				}});
			}else{
				art.dialog({icon:'error',title:'操作结果',  content: temp+  '操作失败',time:3});
			} 
		},'json');
	}else{//修改录取状态
		$.post('/scode/saveAdmit.action',{ids:$("#ids").val(),admit:$("#admit").val(),checkRemark:checkRemark},function(data){
		    if(data.code=='succeed'){
		    	art.dialog.opener.mngScode.load();
				art.dialog({icon:'succeed',title:'操作结果',  content: '不录取操作成功',time:3,close:function(){
					art.dialog.close();
				}});
			}else{
				art.dialog({icon:'error',title:'操作结果',  content: '不录取操作失败',time:3});
			} 
		},'json');
	}
	
}
</script>
</head>
<body>
<form action="#">
    <input type="hidden" id="ids" value="${ids }" />
	<input type="hidden" id="status" value="${status }" />
	<input type="hidden" id="admit" value="${admit }" />
	<div class="form_item">
			<span class="form_span">
				<c:choose>
					<c:when test="${not empty status }">${status==2 ? '审核不通过':'审核回退' }</c:when>
					<c:otherwise>不录取</c:otherwise>
				</c:choose>
				原因：
			</span>
			<select id="remarkType">
				<c:choose>
					<c:when test="${not empty status }">
						<option value="资料不完整" selected="selected">资料不完整</option>
						<option value="照片不合格">照片不合格</option>
						<option value="不符合报名条件">不符合报名条件</option>
					</c:when>
					<c:otherwise>
						<option value="面试不通过">面试不通过</option>
						<option value="已报读它校">已报读它校</option>
					</c:otherwise>
				</c:choose>
				<option value="其它">其它</option>
			</select>
	</div>
	<div class="form_item">
			<span class="form_span">备注说明：</span>
			<textarea id="remarkContent" rows="3" cols="40"></textarea>
	</div>
	<div class="form_submit">
			<a href="javascript:checkNotPass()" class="base_btn" id="submitButton"><span>确定</span></a>
	</div>
	<div class="clear"></div>
</form>
</body>
</html>