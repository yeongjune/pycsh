<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
var lottery;
$(function(){
	lottery=new lottery();
	lottery.init();
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

var requestIds=['title','times','number'];

function lottery(){
	
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
		
		var url = '/lottery/save.action';
		if('${lottery.id}' != ''){
			url = '/lottery/update.action';
		}
		
		if(flag==-1){
			lockWindow();
			$.ajax({
				url:url,
				data:$("#lotteryForm").serialize(),
				dataType:'json',
				type:'post',
				success:function(data){
					openLock();
					if(data.code == 'succeed'){
						art.dialog.opener.lotteryManager.load();
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
<body style="width:540px;height:250px">
<form id="lotteryForm" >
<input name="id" type="hidden" value="${lottery.id }" />
<%-- <input name="siteId" type="hidden" value="${applyInfo.siteId }" /> --%>
    <%-- <div class="view_rank">
		<span class="form_span">编号：</span>
		<input type="text" name="applyNo" id="applyNo" class="piece" value="${applyInfo.applyNo }" maxlength="10" />
		<font color="red" id="applyNo_tip"></font>
	</div> --%>
	<div class="view_rank">
		<span class="form_span">摇号标题：</span>
		<input type="text" name="title" id="title" class="piece" value="${lottery.title }" maxlength="100" />
		<font color="red" id="title_tip"></font>
	</div>
	<%-- <div class="view_rank">
		<span class="form_span">报名日期：</span>
		<input type="text" name="startTime" id="startTime" class="piece" value="<fmt:formatDate value="${applyInfo.startTime }"  type="date" pattern="yyyy-MM-dd"/>" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\',{d:0})}'})" maxlength="10" style="width:85px"  />
		至<input type="text" name="endTime" id="endTime" class="piece" value="<fmt:formatDate value="${applyInfo.startTime }"  type="date" pattern="yyyy-MM-dd"/>" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTime\',{d:0})}'})" maxlength="10"  style="width:85px"  />
		<font color="red" id="title_tip"></font>
	</div> --%>
	<div class="view_rank">
		<span class="form_span">摇号选出人数：</span>
		<input type="number" name="number" id="number" min="1" class="piece" value="${lottery.number}"/>
		<font color="red" id="number_tip"></font>
	</div>
	<%-- <div class="view_rank">
		<span class="form_span">候补人数：</span>
		<input type="number" name="waitNum" id="waitNum" min="1" class="piece" value="${lottery.waitNum}"/>
		<font color="red" id="waitNum_tip"></font>
	</div> --%>
	<div class="view_rank" style="display: none;">
		<span class="form_span">摇号次数：</span>
		<input type="number" name="times" id="times" min="1" class="piece" value="${lottery.times == null ? 1 : lottery.times}"/>
		<font color="red" id="remark_tip"></font>
	</div>
	<div class="view_rank">
		<span class="form_span">摇号说明：</span>
		<textarea  name="remark" id="remark" class="piece" maxlength="200" style="width:350px;height:120px;">${lottery.remark }</textarea>
		<font color="red" id="remark_tip"></font>
	</div>
	<%-- <div class="view_rank">
		<span class="form_span">是否开启：</span>
		<select name="state" class="piece2" id="state"  >
			<option value="1" ${(not empty applyInfo and applyInfo.state==1)? 'selected="selected"':'' } >是</option>
			<option value="0" ${(empty applyInfo or applyInfo.state==0)? 'selected="selected"':'' } >否</option>
		</select>
		<font color="red" id="state_tip"></font>
	</div> --%>
    <div class="clear"></div>
	<div class="form_submit">
			<a href="javascript:lottery.save()" class="base_btn"><span>保存</span></a>
	</div>
	<div class="clear"></div>
</form>
</body>
</html>