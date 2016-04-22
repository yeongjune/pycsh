<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
var editStudent;
$(function(){
	editStudent=new EditStudent();
	editStudent.init();
});

//判断所需项是否为空，为空返还大于-1的数字
function checkFiled(k,v){
	var f=-1;
	if(!$('#'+v).val()){
		var temp=k;
		if(v=='startTime'||v=='endTime'){
			if(!$('#startTime').val()){
				$("#endTime").next().text('必选');
			}else{
				temp=f;
			}
		}else{
			$("#"+v).next().text('必填');
		}
		f=f==-1?temp:f;
	}else{
		if(v=='startTime'||v=='endTime'){
			$("#endTime").next().text('');
		}else{
			$("#"+v).next().text('');
		}
	}
	return f;
}

var requestIds=['name','school'];

function EditStudent(){
	
	this.init = function (){
		$(requestIds).each(function(i,v){
			$('#'+v).blur(function(){
				checkFiled(i,v);
			});
		});
	};
	this.save = function (){
		var flag=-1;
		$(requestIds).each(function(k,v){
			var f=checkFiled(k,v);
			flag=flag==-1?f:flag;
		});
		
		var url = '/lottery/student/save.action';
		if('${student.id}' != ''){
			url = '/lottery/student/update.action';
		}
		
		if(flag==-1){
			lockWindow();
			$.ajax({
				url:url,
				data:$("#studentForm").serialize(),
				dataType:'json',
				type:'post',
				success:function(data){
					openLock();
					if(data.code == 'succeed'){
						art.dialog.opener.studentManager.load();
						art.dialog.close();
					}else{
						art.dialog.tips(data.msg);  
					}
				},
				error:function(){
					openLock();
					art.dialog.tips('提交失败，请重试');
				}
			});
		}else{
			art.dialog.tips('报名信息不完整');
		}
	};
}
</script>
</head>
<!-- <body style="width:540px;height:250px"> -->
<body >
<form id="studentForm" >
<input name="id" type="hidden" value="${student.id }" />
<input name="siteId" type="hidden" value="${applyInfo.siteId }" />
	<c:if test="${list.size() == 0 }">
		<div style="color:red;margin: 10px;">由于还没创建摇号，所以新建的学生信息将不能保存，请先创建摇号再添加学生信息</div>
	</c:if>
    <div class="view_rank">
		<span class="form_span">姓名：</span>
		<input type="text" name="name" id="name" class="piece" value="${student.name }" maxlength="10" />
		<font color="red" id="name_tip"></font>
	</div>
	<%-- <div class="view_rank">
		<span class="form_span">身份证号：</span>
		<input type="text" name="IDCard" id="IDCard" class="piece" value="${student.IDCard }" maxlength="100" />
		<font color="red" id="IDCard_tip"></font>
	</div> --%>
	<div class="view_rank">
		<span class="form_span">性别：</span>
		<select name="gender">
			<option value="男" ${student.gender == '男' ? 'selected' : ''} >男</option>
			<option value="女" ${student.gender == '女' ? 'selected' : ''} >女</option>
		</select>
		<font color="red" id="gender_tip"></font>
	</div>
	<%-- <div class="view_rank">
		<span class="form_span">出生年月日：</span>
		<input type="text" name="birthday" id="birthday" class="piece" value="<fmt:formatDate value='${student.birthday }' pattern='yyyy-MM-dd' />" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" maxlength="100" />
		<font color="red" id="birthday_tip"></font>
	</div> --%>
	<div class="view_rank">
		<span class="form_span">学校：</span>
		<input type="text" name="school" id="school" class="piece" value="${student.school }" maxlength="100" />
		<font color="red" id="school_tip"></font>
	</div>
	<%-- <div class="view_rank">
		<span class="form_span">小升初报名编号：</span>
		<input type="text" name="stuNo" id="stuNo" class="piece" value="${student.stuNo }" maxlength="100" />
		<font color="red" id="stuNo_tip"></font>
	</div>
	<div class="view_rank">
		<span class="form_span">学籍号：</span>
		<input type="text" name="stuCode" id="stuCode" class="piece" value="${student.stuCode }" maxlength="100" />
		<font color="red" id="stuCode_tip"></font>
	</div> --%>
	<div class="view_rank">
		<span class="form_span">父亲联系电话：</span>
		<input type="text" name="phone" id="phone" class="piece" value="${student.phone }" maxlength="100" />
		<font color="red" id="phone_tip"></font>
	</div>
	<div class="view_rank">
		<span class="form_span">母亲联系电话：</span>
		<input type="text" name="mPhone" id="phone" class="piece" value="${student.mPhone }" maxlength="100" />
		<font color="red" id="phone_tip"></font>
	</div>
	<div class="view_rank">
		<span class="form_span">全国学籍号：</span>
		<input type="text" name="stuCode" id="stuCode" class="piece" value="${student.stuCode }" maxlength="100" />
		<font color="red" id="school_tip"></font>
	</div>
	<div class="view_rank">
		<span class="form_span">参加的摇号：</span>
		<select name="lotteryId" id="lotteryId" class="piece">
			<c:forEach var="lottery" items="${list }">
				<option value="${lottery.id }" ${student.lotteryId == lottery.id ? 'selected' : ''}>${lottery.title }</option>
			</c:forEach>
		</select>
		<font color="red" id="IDCard_tip"></font>
	</div>
    <div class="clear"></div>
	<div class="form_submit">
			<a href="javascript:editStudent.save()" class="base_btn"><span>保存</span></a>
	</div>
	<div class="clear"></div>
</form>
</body>
</html>