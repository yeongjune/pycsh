<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<script type="text/javascript">
var editApplyInfo;
$(function(){
	editApplyInfo=new EditApplyInfo();
	editApplyInfo.init();
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

var requestIds=['applyNo','title','startTime','endTime','state'];

function EditApplyInfo(){
	
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
		
		if(flag==-1){
			lockWindow();
			$.ajax({
				url:'/applyInfo/save.action',
				data:$("#applyInfoForm").serialize(),
				dataType:'json',
				type:'post',
				success:function(data){
					openLock();
					if(data.code == 'succeed'){
						if(data.id){
							$('#id').val(data.id);
							$('#siteId').val(data.siteId);
						}
						art.dialog.tips(data.msg); 
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
<body >
<fieldset class="fieldset_border">
	<legend class="legend_title">${empty menu_name ? '报名设置' : menu_name }</legend>
	<form id="applyInfoForm" >
		<input name="id" id="id" type="hidden" value="${applyInfo.id }" />
		<input name="siteId" id="siteId" type="hidden" value="${applyInfo.siteId }" />
	    <div class="view_rank">
			<span class="form_span">报名编号：</span>
			<span class="form_span" style="text-align: left;">${empty applyInfo ? applyNo :applyInfo.applyNo }</span>
			<input type="hidden" name="applyNo" id="applyNo" class="piece" value="${empty applyInfo ? applyNo :applyInfo.applyNo }" maxlength="10" />
			<font color="red" id="applyNo_tip"></font>
		</div>
		<div class="view_rank">
			<span class="form_span">报名标题：</span>
			<input type="text" name="title" id="title" class="piece" value="${applyInfo.title }" maxlength="100" style="width:436px;" />
			<font color="red" id="title_tip"></font>
		</div>
		<div class="view_rank">
			<span class="form_span">报名日期：</span>
			<input type="text" name="startTime" id="startTime" class="piece" value="<fmt:formatDate value="${applyInfo.startTime }"  type="date" pattern="yyyy-MM-dd"/>" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\',{d:0})}'})" maxlength="10"  />
			至 <input type="text" name="endTime" id="endTime" class="piece" value="<fmt:formatDate value="${applyInfo.endTime }"  type="date" pattern="yyyy-MM-dd"/>" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTime\',{d:0})}'})" maxlength="10"  />
			<font color="red" id="title_tip"></font>
		</div>
		<div class="view_rank">
			<span class="form_span">报名说明：</span>
			<textarea  name="remark" id="remark" class="piece" maxlength="500" style="width:600px;height:120px;">${applyInfo.remark }</textarea>
			<font color="red" id="remark_tip"></font>
		</div>
		<div class="view_rank">
			<span class="form_span">面试须知：</span>
			<textarea  name="interviewNote" id="interviewNote" class="piece" maxlength="500" style="width:600px;height:120px;">${applyInfo.interviewNote }</textarea>
			<font color="red" id="remark_tip"></font>
		</div>
		<div class="view_rank">
			<span class="form_span">是否开启报名：</span>
			<select name="state" class="piece2" id="state"  >
				<option value="1" ${(not empty applyInfo and applyInfo.state==1)? 'selected="selected"':'' } >是</option>
				<option value="0" ${(empty applyInfo or applyInfo.state==0)? 'selected="selected"':'' } >否</option>
			</select>
			<font color="red" id="state_tip"></font>
		</div>
		<div class="view_rank">
			<span class="form_span">是否开启打印：</span>
			<select name="isPrint" class="piece2" id="state"  >
				<option value="1" ${(not empty applyInfo and applyInfo.isPrint==1)? 'selected="selected"':'' } >是</option>
				<option value="0" ${(empty applyInfo or applyInfo.isPrint==0)? 'selected="selected"':'' } >否</option>
			</select>
			<font color="red" id="state_tip"></font>
		</div>
	    <div class="clear"></div>
		<div class="form_submit">
				<a href="javascript:editApplyInfo.save()" class="base_btn"><span>确定</span></a>
		</div>
		<div class="clear"></div>
	</form>
</fieldset>
</body>
</html>