<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>site</title>
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
	var static_siteId = 0;
	var setting_1 = {
			view: {
				selectedMulti: false
			},
			data: {
				key:{
					name:"name"
				},
				simpleData: {
					enable: true,
					idKey:"id",
					pIdKey:"pid",
					rootPid:0
				}
			},
			callback: {
				onClick: siteTreeOnClick
			}
		};
	var setting_2 = {
			data: {
				key:{
					name:"name"
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
				autoCheckTrigger: false,
				chkboxtype: { "Y" : "", "N" : "" }
			},
			callback: {
				onCheck: roleTreeOnCheck,
				onClick: cancelSelected
			}
		};
	
	function reloadSite(){
		$.post('/siteRole/siteList.action',{},function(data){
			static_siteId = 0;
			var mapList = $.parseJSON(data);
			$.fn.zTree.init($("#siteTree"), setting_1, mapList);
		});
	}
	
		function roleTreeOnCheck(event, treeId, treeNode) {
			if(static_siteId){
			    $.post('/siteRole/update.action',{siteId:static_siteId,roleId:treeNode.id,checked:treeNode.checked?1:0},function(data){
		    		reloadRole(static_siteId);
			    });
			}
		}
		function cancelSelected(){
			var roleTreeObject = $.fn.zTree.getZTreeObj("roleTree");
			roleTreeObject.cancelSelectedNode();
		}
		
		function reloadRole(siteId){
			$.post('/siteRole/roleList.action',{siteId:siteId},function(data){
				static_siteId = siteId;
				var mapList = $.parseJSON(data);
				$.fn.zTree.init($("#roleTree"), setting_2, mapList);
			});
		}
		
		function siteTreeOnClick(event, treeId, treeNode){
			reloadRole(treeNode.id);
		}

		function initTree(){
			reloadSite();
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
	<div style="margin: 10px;">
		<div class="form_search_item" >
			<div class="left">
			操作说明：左边是所有网站，右边是选中网站的可选角色，复选框勾选的表示该网站拥有的角色
			</div>
		</div>
		<div class="content_wrap">
			<div class="zTreeDemoBackground left">
				<ul id="siteTree" class="ztree"></ul>
			</div>
			<div class="right">
				<ul id="roleTree" class="ztree"></ul>
			</div>
		</div>
	</div>
</body>
</html>