<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${site.name }</title>
<link href="/skins/blue/css/table_form.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.view_rank_span{width: 120px; font-size: 15px; padding-top: 3px;}
.right_introduction{font-size: 14px; width: 80%;}
.textarea_piece{overflow: hidden; width:705px;}
.color_606060{color: #606060;}
.center{text-align: center;}
</style>
<script type="text/javascript"	src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=idialog"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<script type="text/javascript" src="/js/base/PagedQuery.js"></script>
<script type="text/javascript" src="/js/base/util.js"></script>
</head>
<body>
<fieldset class="fieldset_border" id="replyList">
	<!-- <legend class="legend_title">问题框</legend> -->
</fieldset>
<div class="table_under_btn">
	<div class="flip"></div>
</div>
<fieldset class="fieldset_border" id="replyList" style="display: none;">
	<legend class="legend_title">回复框</legend>
	<div class="form_item">
		<form action="" class="center">
			<textarea rows="5" cols="100" class="textarea_piece" id="replyContent"></textarea>
			<br /><input type="button" class="base_btn" id="replyBtn" value="提交回复" style="float: right;" />
		</form>
	</div>
	<div class="view_rank">
		<span class="view_rank_span" style="width: 50px;">提示：</span>
		再次回复，则为修改原来已经回复的内容!最多可回复128个汉字！
	</div>
</fieldset>

<script type="text/javascript">

$(function(){
	//获取用户数据
	var name = art.dialog.data("name");
	var createTime = art.dialog.data("createTime");
	var siteId = art.dialog.data("siteId");
	var id = art.dialog.data("id");
	//初始化列表
	detailMessage.load(name, createTime, siteId);
	//绑定留言提交按钮事件
	$("#replyBtn").on("click", function(){
		detailMessage.reply(id);
		setTimeout(function(){
			detailMessage.load(name, createTime, siteId);
		},50);
		
	});
});

var detailMessage = {
		
		load : function(name, createTime, siteId){
			loadByPage('/message/getHistory.action',{name:name, createTime:createTime, siteId:siteId, pageSize : 5},this.showList);
		},
		
		showList : function(list){
			var replyList = $('#replyList');
			var appStr='';
			for ( var key in list) {
				var item=list[key];
				appStr += '<div class="view_rank">' //还有很多隐藏字段
						+ '<span class="view_rank_span">' + (item.type==0?item.name:'匿名') + '：</span>'
						+ '<div class="right_introduction">' + item.content + '</div>'
						+ '<span class="view_rank_span color_606060">管理员：</span>'
						+ '<div class="right_introduction color_606060">' + (item.reply?item.reply:"") + '</div>'
						+ '</div>';	
			}
			replyList.html(appStr);
		},
		
		reply : function(id){
			var replyContent = $("#replyContent");
			$.post("/message/updateReply.action", {content:replyContent.val(), id:id}, function(data){
				if(data == "false"){
					art.dialog({content : "回复失败,请联系管理员"});
				}else if(data == "true"){
					replyContent.val("");
				}
			});
		}
};
</script>
</body>
</html>