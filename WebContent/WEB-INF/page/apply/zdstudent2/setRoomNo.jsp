<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
var interViewMng;
$(function(){
	interViewMng=new InterViewMng();
});

function InterViewMng(){
	this.save = function (){
		var roomNo=$("#roomNo");
		if(roomNo.val() && roomNo.val().trim() != ''){
			$("#roomNo_tip").text('');
			$.post('/zd_student2/saveRoomNo.action',$("#roomNoForm").serialize() ,function (data){
				if(data == 'succeed'){
					art.dialog({
						title: "操作结果",
						content: '已成功设置学生的【'+$("#names").text()+'】的面试考室为:'+roomNo.val(),
						time : 5,
						close : function(){
							art.dialog.opener.mngStudent.load();
							art.dialog.close();
						}
					});
				}else if (data=='fail'){
					art.dialog.tips("设置面试考室失败");
				}else{
					art.dialog.tips("设置面试考室失败");
				}
			});
		}else{
			$("#roomNo_tip").text('请先填写考室');
		}
	};
}
</script>
</head>
<body style="min-width:500px;min-height:200px">
<form action="" id="roomNoForm" >
<input name="ids" type="hidden" value="${ids }" />
<input name="interviewDate" type="hidden" />
	<div class="form_item">
		<span class="form_span">面试学生：</span><span style="line-height:22px" id="names">${names }</span>
	</div>
	<div class="form_item">
		<span class="form_span">面试考室：</span>
		<input type="text" id="roomNo" class="piece" name="roomNo" value="${student.roomNo }"  maxlength="24" style="width:130px"/>
		<font color="red" id="roomNo_tip"></font>
	</div>
	<div class="form_submit">
			<a href="javascript:interViewMng.save()" class="base_btn"><span>保存</span></a>
	</div>
	<div class="clear"></div>
</form>
</body>
</html>