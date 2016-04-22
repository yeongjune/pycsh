<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>menu</title>
	<style type="text/css">
		html,body{ margin:0px; height:100%; }
		.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
		div.content_wrap {width: 700px;height:410px;}
		div.content_wrap div.left{float: left;width: 300px;}
		div.content_wrap div.right{float: right;width: 300px;}
		div.zTreeDemoBackground {width:350px;height:392px;text-align:left;}
		ul.ztree {margin-top: 10px;border: 1px solid #617775;background: #f0f6e4;width:320px;height:390px;overflow-y:auto;overflow-x:auto;}
	</style>
	<script type="text/javascript">
	var setting = {
			data: {
				key:{
					name: 'url',
					url: ''
				},
				simpleData: {
					enable: true,
					idKey:"id",
					pIdKey:"pid",
					rootPid:0
				}
			},
			check:{
				enable: true,
				chkstyle: "checkbox",
				autoCheckTrigger: true,
				chkboxtype: { "Y" : "ps", "N" : "ps" }
			},
			callback: {
				onCheck: urlTreeOnCheck,
				onClick: cancelSelectedNode
			}
		};
	
		function urlTreeOnCheck(event, treeId, treeNode) {
		    $.post('/authority/update.action',{id:treeNode.id,checked:treeNode.checked?1:0},function(data){
	    		
		    });
		}
		function cancelSelectedNode(){
			var urlTreeObject = $.fn.zTree.getZTreeObj("urlTree");
			urlTreeObject.cancelSelectedNode();
		}
		
		function reloadUrl(){
			$.post('/authority/load.action',{},function(data){
				var mapList = $.parseJSON(data);
				$.fn.zTree.init($("#urlTree"), setting, mapList);
			});
		}

		function initTree(){
			reloadUrl();
		}
		initTree();
	</script>
	<script type="text/javascript">
		$(document).ready(function(){
		//	initTree();
		});
	</script>
</head>
<body>
	<fieldset class="fieldset_border">
		<legend class="legend_title">公共权限设置</legend>
		<div style="margin: 10px;">
			<div class="form_search_item" >
				<div class="left">
					操作说明：复选框勾选的表示系统所有登录用户共有的权限地址
				</div>
			</div>
			<div class="content_wrap">
				<div class="zTreeDemoBackground left">
					<ul id="urlTree" class="ztree"></ul>
				</div>
				<div class="right">
				</div>
			</div>
		</div>
	</fieldset>
</body>
</html>