<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>role</title>
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
	var static_roleId = 0;
	var setting_1 = {
			view: {
				addHoverDom: addHoverDom,
				removeHoverDom: removeHoverDom,
				selectedMulti: false
			},
			edit: {
				enable: true,
				renameTitle:'重命名',
				removeTitle:'删除',
				editNameSelectAll: true
			},
			data: {
				key:{
					name: 'name',
					url: ''
				},
				simpleData: {
					enable: true,
					idKey:"id",
					pIdKey:"pid",
					rootPid:0
				}
			},
			callback: {
				beforeRemove: beforeRemove,
				onRemove: zTreeOnRemove,
				beforeRename: beforeRename,
				onRename: zTreeOnRename,
				beforeDrop: zTreeBeforeDrop,
				onDrop: zTreeOnDrop,
				onClick: roleTreeOnClick
			}
		};
	function addHoverDom(treeId, treeNode) {
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.id).length>0) return;
		var addStr = "<span class='button add' id='addBtn_" + treeNode.id
			+ "' title='添加子角色' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		var btn = $("#addBtn_"+treeNode.id);
		if (btn) btn.bind("click", function(){
			add(treeNode);
			return false;
		});
	}
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.id).unbind().remove();
	}
	var setting_2 = {
			data: {
				key:{
					name: 'name',
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
				onCheck: menuTreeOnCheck,
				onClick: cancelSelected
			}
		};
	var siteId = "${siteId}";
	function reloadRole(){
		$.post('/role/load.action',{siteId: siteId},function(data){
			static_roleId = 0;
			var mapList = $.parseJSON(data);
			$.fn.zTree.init($("#roleTree"), setting_1, mapList);
		});
	}
	function add(parentNode){
		var pid = parentNode?parentNode.id:0;
		$.post('/role/save.action',{siteId: siteId, name:'新角色', pid:pid, sort:0},function(data){
			if(data!='fail'){
				var zTree = $.fn.zTree.getZTreeObj("roleTree");
				var newNode = zTree.addNodes(parentNode, {
					id:data,
					pId:0,
					title:'',
					name:"新角色"
					});
				if (newNode) {
					zTree.editName(newNode[0]);
				} else {
					reloadRole();
				}
			}
		});
	}
	function beforeRename(treeId, treeNode, newName) {
		
	}
	function zTreeOnRename(event, treeId, treeNode) {
		reloadMenu(treeNode.id);
		var treeObj = $.fn.zTree.getZTreeObj("roleTree");
		var index = treeObj.getNodeIndex(treeNode);
		updateRole(treeNode.id,treeNode.pid, treeNode.name, index);
	}
	function updateRole(id,pid,name,index){
		pid = pid?pid:0;
		$.post('/role/update.action',{id:id,name:name,pid:pid,sort:index},function(data){
			if(data=='succeed'){
				
			}else{
				reloadRole();
				alert("修改失败");
			}
		});
	}
	function beforeRemove(treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("roleTree");
		zTree.selectNode(treeNode);
		return confirm("确认删除角色“" + treeNode.name + "”吗？");
	}
	function zTreeOnRemove(event, treeId, treeNode) {
		deleteRole(treeNode);
	}
	function deleteRole(targetNode){
		var role_id = targetNode.id;
		$.post('/role/delete.action',{id:role_id},function(data){
			if(data!='succeed'){
				reloadRole();
				alert('删除失败');
			}else{
				if(role_id==static_roleId){
					static_roleId=false;
					var zTreeObj = $.fn.zTree.getZTreeObj("menuTree");
					zTreeObj.destroy();
				}
				updateParentChildren(targetNode);
			}
		});
	}
	function updateParentChildren(targetNode){
		var children = null;
		var pid = 0;
		var parentNode = targetNode.getParentNode();
		if(parentNode==null){
			children = $.fn.zTree.getZTreeObj("roleTree").getNodes(0);
		}else{
			pid = parentNode.id;
			children = parentNode.children;
		}
		for ( var item in children) {
			var treeNode = children[item];
			var treeObj = $.fn.zTree.getZTreeObj("roleTree");
			var index = treeObj.getNodeIndex(treeNode);
			pid = pid&&pid!=null&&pid!='null'?pid:0;
			updateRole(treeNode.id,pid,treeNode.name,index);
		}
	}
	function zTreeBeforeDrop(treeId, treeNodes, targetNode, moveType) {
		
		return true;
	}
	function zTreeOnDrop(event, treeId, treeNodes, targetNode, moveType) {
		if(targetNode==null)return;
		var parentNode = null;
		var children = null;
		var pid = 0;
		if(moveType=='inner'){
			parentNode = targetNode;
			pid = parentNode.id;
			children = parentNode.children;
		}else{
			parentNode = targetNode.getParentNode();
			if(parentNode==null){
				children = $.fn.zTree.getZTreeObj("roleTree").getNodes(0);
			}else{
				pid = parentNode.id;
				children = parentNode.children;
			}
		}
		for ( var item in children) {
			var treeNode = children[item];
			var treeObj = $.fn.zTree.getZTreeObj("roleTree");
			var index = treeObj.getNodeIndex(treeNode);
			pid = pid&&pid!=null&&pid!='null'?pid:0;
			updateRole(treeNode.id,pid,treeNode.name,index);
		}
	}
	
		function menuTreeOnCheck(event, treeId, treeNode) {
			if(static_roleId){
			    $.post('/roleMenu/update.action',{roleId:static_roleId,menuId:treeNode.id,checked:treeNode.checked?1:0},function(data){
			    	if(data=='succeed'){
			    		
			    	}else{
			    		reloadMenu(static_roleId);
			    	}
			    });
			}
		}
		function cancelSelected(){
			var menuTreeObject = $.fn.zTree.getZTreeObj("menuTree");
			menuTreeObject.cancelSelectedNode();
		}
		
		function reloadMenu(roleId){
			if(roleId>0){
				$.post('/roleMenu/load.action',{siteId: siteId, roleId:roleId},function(data){
					static_roleId = roleId;
					var mapList = $.parseJSON(data);
					$.fn.zTree.init($("#menuTree"), setting_2, mapList);
				});
			}else{
				static_roleId = roleId;
				var menuTree = $.fn.zTree.getZTreeObj("menuTree");
				menuTree.destroy();
			}
		}
		
		function roleTreeOnClick(event, treeId, treeNode, clickFlag){
			if(clickFlag){
				reloadMenu(treeNode.id);
			}else{
				reloadMenu(0);
			}
		}

		function initTree(){
			reloadRole();
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
		<legend class="legend_title">角色管理</legend>
		<div style="margin: 10px;">
			<div class="form_search_item" >
				<div class="left">
					<a id="addParent" href="javascript:add()" class="base_btn"><span>添加一级角色</span></a>
					操作说明：左边是所有角色，右边是选中角色的可选菜单，复选框勾选的表示该角色拥有的菜单
				</div>
			</div>
			<div class="content_wrap">
				<div class="zTreeDemoBackground left">
					<ul id="roleTree" class="ztree"></ul>
				</div>
				<div class="right">
					<ul id="menuTree" class="ztree"></ul>
				</div>
			</div>
		</div>
	</fieldset>
</body>
</html>