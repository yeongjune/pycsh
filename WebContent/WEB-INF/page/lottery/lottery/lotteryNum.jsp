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
var editLottery;
$(function(){
	editLottery=new EditLottery();
	editLottery.init();
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

var requestIds=['number'];

function EditLottery(){
	
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
		art.dialog.confirm("设定摇中人数后将不能修改，确定保存吗？",function(){
			var url = '/lottery/processLottery3.action';
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
							art.dialog.opener.studentManager.toResult();
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
		});
	};
}
</script>
</head>
<!-- <body style="width:540px;height:250px"> -->
<body >
<form id="lotteryForm" >
<input name="siteId" type="hidden" value="${applyInfo.siteId }" />
<input name="id" type="hidden" value="${id }" />
    <div class="view_rank">
		<span class="form_span">摇中人数：</span>
		<input type="text" name="number" id="number" class="piece" maxlength="10" style="width: 100px;" />
		<font color="red" id="number_tip"></font>
	</div>
    <div class="clear"></div>
	<div class="form_submit">
			<a href="javascript:editLottery.save()" class="base_btn"><span>保存</span></a>
	</div>
	<div class="clear"></div>
</form>
</body>
</html>