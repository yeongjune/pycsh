<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<title>user</title>
	<c:import url="/common/taglibs.jsp" />
	<style type="text/css">
		html,body{ margin:0px; }
		.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
		div.content_wrap {width: 350px;height:410px;}
		div.content_wrap div.left{float: left;width: 300px;}
		div.content_wrap div.right{float: right;width: 300px;}
		div.zTreeDemoBackground {width:350px;height:392px;text-align:left;}
		ul.ztree {margin-top: 10px;border: 1px solid #617775;background: #f0f6e4;width:320px;height:390px;overflow-y:auto;overflow-x:auto;}
	</style>
	<script type="text/javascript">
	var static_userId = '${userId}';
	var setting = {
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
	
		function roleTreeOnCheck(event, treeId, treeNode) {
			if(static_userId){
			    $.post('/userRole/update.action',{userId:static_userId,roleId:treeNode.id,checked:treeNode.checked?1:0},function(data){
			    	initTree();
			    });
			}
		}
		function cancelSelected(){
			var roleTreeObject = $.fn.zTree.getZTreeObj("roleTree");
			roleTreeObject.cancelSelectedNode();
		}
		
		function userTreeOnClick(event, treeId, treeNode){
			reloadRole(treeNode.id);
		}

		function reloadRole(){
			$.post('/userRole/roleList.action',{userId: static_userId},function(data){
				var mapList = $.parseJSON(data);
				$.fn.zTree.init($("#roleTree"), setting, mapList);
			});
		}
		function initTree(){
			reloadRole();
		}
		
		$(document).ready(function(){
			initTree();
		});
	</script>
</head>
<body>
	<div style="margin: 10px;">
		<div class="content_wrap">
			<div class="zTreeDemoBackground">
				<ul id="roleTree" class="ztree"></ul>
			</div>
		</div>
	</div>
</body>
</html>