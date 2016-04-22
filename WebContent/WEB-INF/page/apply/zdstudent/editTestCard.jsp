<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="/plugin/kindeditor-4.1.10/themes/default/default.css" />
<script charset="utf-8" src="/plugin/kindeditor-4.1.10/kindeditor-min.js"></script>
<script charset="utf-8" src="/plugin/kindeditor-4.1.10/lang/zh_CN.js"></script>
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
var edtStudentManager;
$(function(){
	edtStudentManager=new EdtStudentManager();
	$(".required").blur(function(){
		if(!$(this).val()){
			$(this).parent().next().text("此项不能为空");
		}else{
			$(this).parent().next().text("");
		}
	});
	
});
function EdtStudentManager(){
	this.save = function (){
		var pass=true;
		$(".required").each(function(){
			if(!$(this).val()){
				$(this).parent().next().text("此项不能为空");
				pass=false;
			}
		});
		if(pass){
			$.post('/zd_student/updateTestCard.action',$("#studentForm").serialize(),function(data){
				if(data.code=='succeed'){
					art.dialog.opener.mngStudent.load();
					art.dialog.close();
				}else{
					art.dialog.alert(data.msg);
				}
			},'json');
		}
	};
}
</script>
<style type="text/css">
tr{
height: 40px;
}
.tdtext{
text-align: right;
width: 140px;
}
.text{
text-align:left;
width:340px;
}
.text span{
text-align: left;
}
</style>
</head>
<body>
<form id="studentForm" action="">
	<input type="hidden" name="id" id="id" value="${student.id }" />
    <table>
    	<tr>
    		<td class="tdtext">准考证号</td>
    		<td class="text">
    			<span>
	    			<input name="testCard" type="text" value="${student.testCard }" class="piece required" maxlength="40"  />
				</span>
				<span class="red">*</span>
    		</td>
    	</tr>
		<tr>
			<td colspan="4" style="text-align: center;">
				<a href="javascript:edtStudentManager.save()" class="base_btn"><span>保存</span></a>
			</td>
		</tr>
    </table>
	<div class="clear"></div>
</form>
</body>
</html>
