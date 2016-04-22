<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${site.name }</title>
<link href="/skins/blue/css/table_form.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.view_rank_span{width: 130px;}
.right_introduction{width: 75%;}
</style>
<script type="text/javascript"	src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=idialog"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="/js/base/PagedQuery.js"></script>
<script type="text/javascript" src="/js/base/util.js"></script>
<script type="text/javascript">
$(function(){
	var id = art.dialog.data("id");
	//加载留言
	detailMessage.load(id);
	//绑定留言提交按钮事件
	$("#replyBtn").on("click", function(){
		detailMessage.reply();
		
	});
});

var detailMessage = {
	
	load : function(id){
		//loadByPage('/message/getChildrenMsgByPid.action',{pid:pid},this.showList);
		$.post('/message/getMsgById.action',{id:id},function(data){
			
			var dataObj = $.parseJSON(data);
			var replyList = $('#replyList');
			appStr = '<legend class="legend_title">问题框</legend>';
			appStr += '<div class="view_rank">' 
				+ '<input type="hidden" id="id" value="' + dataObj.id + '" />'
				+ '<span class="view_rank_span">' + dataObj.name + '：</span>'
				+ '<div class="right_introduction">' + dataObj.content + '</div>'
				+ '</div>';
			appStr += '<div class="view_rank">' 
				+ '<span class="view_rank_span">管理员：</span>'
				+ '<div class="right_introduction" id="reContent">' + (dataObj.reply?dataObj.reply:"") + '</div>'
				+ '</div>';
			replyList.html(appStr);
		});
	},
	/*
	showList : function(list){
		var replyList = $('#replyList');
		var appStr='';
		appStr = '<legend class="legend_title">问题框</legend>';
		for ( var key in list) {
			var item=list[key];
			var type;
			if(item.name){type = item.name}else{type = item.type;}
			appStr += '<div class="view_rank">' //还有很多隐藏字段
					+ '<input type="hidden" class="pid" value="' + item.pid + '" />'
					+ '<input type="hidden" class="siteId" value="' + item.siteId + '" />'
					+ '<span class="view_rank_span">' + type + '：</span>'
					+ '<div class="right_introduction">' + item.content + '</div>'
					+ '</div>';	
		}
		replyList.html(appStr);
	},	
	*/
	reply : function(){
		var replyContent = $("#replyContent");
		var id = $("#id").val();
		var reContent = $("#reContent");
		$.post("/message/updateReply.action", {content:replyContent.val(), id:id}, function(data){
			if(data == "false"){
				art.dialog({content : "回复失败,请联系管理员"});
			}else if(data == "true"){
				reContent.text(replyContent.val());
				replyContent.val("");
			}
		});
	}
};
</script>
</head>
<body>
<fieldset class="fieldset_border" id="replyList">
	<!-- <legend class="legend_title">问题框</legend> -->
</fieldset>

<fieldset class="fieldset_border">
	<legend class="legend_title">回复框</legend>
	<div class="form_item">
		<form action="">
			<textarea rows="5" cols="80" class="textarea_piece" style="overflow: hidden; width:660px;" id="replyContent"></textarea>
			<br /><input type="button" class="base_btn" id="replyBtn" value="提交回复" style="float: right;" />
		</form>
	</div>
	<div class="view_rank">
		<span class="view_rank_span" style="width: 50px;">提示：</span>
		再次回复，则为修改原来已经回复的内容!
	</div>
</fieldset>
</body>
</html>