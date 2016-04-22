<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<style type="text/css">
.form_item span{
line-height: 22px;
}
.head_Img_Div{
 position:absolute;
 z-index: 2px;
 top:80px;
 left: 400px;
}
.headImg{
margin:5px;
width: 128px;
height: 160px;
cursor:pointer;
vertical-align: middle;
border:1px solid #DEDEDE;
border-radius:3px;
-webkit-border-radius:3px;
-moz-border-radius:3px;
}
</style>
<script type="text/javascript">
$(function(){
	$("#headPicUrl").click(function(){
		art.dialog({
		    padding: 0,
		    title: '照片',
		    content: '<img src="'+$(this).attr("src")+'" width="379" height="500" />',
		    lock: true
		});
	});
});

//打印
function print(){
	var ids='${student.id}';
	var name = '${student.name}';
	if(ids.length > 0){
		art.dialog.confirm('您确认要打印 [ '+name+' ]的信息(点击确认将进入打印预览)?',function(){
			window.open( '/zd_student/toPrint.action?ids='+ids);
		});
	}
};

</script>
</head>
<body>
<fieldset class="fieldset_border">
<div id="printPage">
		<div class="form_item" >
			<span class="form_span" >姓　　名：</span>
			<span id="name">${student.name}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >性　　别：</span>
			<span id="gender">${student.gender}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >出生年月日：</span>
			<span id="birthday"><fmt:formatDate value="${student.birthday}" pattern="yyyy-MM-dd" /></span>
		</div>
		<div class="form_item" >
			<span class="form_span" >身份证：</span>
			<span id="IDCard">${student.IDCard}</span>　
		</div>
		<div class="form_item" >
			<span class="form_span" >小升初编号：</span>
			<span id="stuNo">${student.stuNo}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >学籍号：</span>
			<span id="stuCode">${student.stuCode}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >联系电话：</span>
			<span id="phone">${student.phone}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >参加摇号：</span>
			<span id="phone">${lottery.title}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >摇号状态：</span>
			<span id="phone">${student.status == 1 ? '已选中' : '未选中'}</span>
		</div>
		<div style="clear: both;"></div>
</div>
<div style="clear: both;"></div>
</fieldset>
</body>
</html>