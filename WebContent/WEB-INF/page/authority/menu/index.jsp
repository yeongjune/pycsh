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
	var static_menuId = 0;
	var static_url = false;
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
					title: 'url',
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
				onClick:menuTreeOnClick
			}
		};
	function addHoverDom(treeId, treeNode) {
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.id).length>0) return;
		var addStr = "<span class='button add' id='addBtn_" + treeNode.id
			+ "' title='添加子菜单' onfocus='this.blur();'></span>";
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
				onClick: updateMenuUrl
			}
		};
	
	function reloadMenu(){
		$.post('/menu/load.action',{},function(data){
			static_menuId = 0;
			var mapList = $.parseJSON(data);
			$.fn.zTree.init($("#menuTree"), setting_1, mapList);
		});
	}
	function add(parentNode){
		var pid = parentNode?parentNode.id:0;
		$.post('/menu/save.action',{name:'新菜单', pid:pid, sort:0},function(data){
			if(data!='fail'){
				var zTree = $.fn.zTree.getZTreeObj("menuTree");
				var newNode = zTree.addNodes(parentNode, {
					id:data,
					pId:0,
					title:'',
					name:"新菜单"
					});
				if (newNode) {
					zTree.editName(newNode[0]);
				} else {
					reloadMenu();
				}
			}
		});
	}
	function beforeRename(treeId, treeNode, newName) {
		
	}
	function zTreeOnRename(event, treeId, treeNode) {
		reloadUrl(treeNode.id, treeNode.url);
		var treeObj = $.fn.zTree.getZTreeObj("menuTree");
		var index = treeObj.getNodeIndex(treeNode);
		updateMenu(treeNode.id,treeNode.pid, treeNode.name, index);
	}
	function updateMenu(id,pid,name,index){
		pid = pid?pid:0;
		$.post('/menu/update.action',{id:id,name:name,pid:pid,sort:index},function(data){
			if(data=='succeed'){
				
			}else{
				reloadMenu();
				alert("修改失败");
			}
		});
	}
	function beforeRemove(treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("menuTree");
		zTree.selectNode(treeNode);
		return confirm("确认删除菜单“" + treeNode.name + "”吗？");
	}
	function zTreeOnRemove(event, treeId, treeNode) {
		deleteMenu(treeNode);
	}
	function deleteMenu(targetNode){
		var deleteChildren = 0;
		if(confirm('删除所有子菜单吗？')){
			deleteChildren = 1;
		}
		var role_id = targetNode.id;
		$.post('/menu/delete.action',{id:role_id, deleteChildren:deleteChildren},function(data){
			if(data!='succeed'){
				reloadMenu();
				alert('删除失败');
			}else{
				if(role_id==static_menuId){
					static_menuId = false;
					static_url = false;
					var zTreeObj = $.fn.zTree.getZTreeObj("urlTree");
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
			children = $.fn.zTree.getZTreeObj("menuTree").getNodes(0);
		}else{
			pid = parentNode.id;
			children = parentNode.children;
		}
		for ( var item in children) {
			var treeNode = children[item];
			var treeObj = $.fn.zTree.getZTreeObj("menuTree");
			var index = treeObj.getNodeIndex(treeNode);
			pid = pid&&pid!=null&&pid!='null'?pid:0;
			updateMenu(treeNode.id,pid,treeNode.name,index);
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
				children = $.fn.zTree.getZTreeObj("menuTree").getNodes(0);
			}else{
				pid = parentNode.id;
				children = parentNode.children;
			}
		}
		for ( var item in children) {
			var treeNode = children[item];
			var treeObj = $.fn.zTree.getZTreeObj("menuTree");
			var index = treeObj.getNodeIndex(treeNode);
			pid = pid&&pid!=null&&pid!='null'?pid:0;
			updateMenu(treeNode.id,pid,treeNode.name,index);
		}
	}
	
		function urlTreeOnCheck(event, treeId, treeNode) {
			if(static_menuId){
			    $.post('/menuUrl/update.action',{menuId:static_menuId,urlId:treeNode.id,checked:treeNode.checked?1:0},function(data){
			    	if(data=='succeed'){
			    		if(static_url==treeNode.url){
			    			var menuTreeObject = $.fn.zTree.getZTreeObj("menuTree");
				    		var nodes = menuTreeObject.getSelectedNodes();
				    		nodes[0].url = '';
				    		static_url = false;
			    			resetUrlTreeSelectedNode();
			    		}
			    	}else{
			    		reloadUrl(static_menuId, static_url);
			    	}
			    });
			}
		}
		function updateMenuUrl(event, treeId, treeNode){
			if(static_menuId && treeNode.checked && treeNode.pid){
			    $.post('/menu/updateUrl.action',{id:static_menuId,url:treeNode.url},function(data){
			    	if(data=='succeed'){
			    		var menuTreeObject = $.fn.zTree.getZTreeObj("menuTree");
			    		var nodes = menuTreeObject.getSelectedNodes();
			    		nodes[0].url = treeNode.url;
			    		static_url = treeNode.url;
			    	}else{
			    		resetUrlTreeSelectedNode();
			    	}
			    });
			}else{
				resetUrlTreeSelectedNode();
			}
		}
		function resetUrlTreeSelectedNode(){
			var urlTreeObject = $.fn.zTree.getZTreeObj("urlTree");
			var nodes = urlTreeObject.transformToArray(urlTreeObject.getNodes());
			if(static_url && static_url.trim!=''){
				for ( var item in nodes) {
					var node = nodes[item];
					if(static_url && node.url==static_url){
						urlTreeObject.selectNode(node);
					}
				}
			}else{
				urlTreeObject.cancelSelectedNode();
			}
		}
		
		function reloadUrl(menuId, url){
			if(menuId>0){
				$.post('/menuUrl/load.action',{menuId:menuId},function(data){
					static_menuId = menuId;
					static_url = url;
					var mapList = $.parseJSON(data);
					$.fn.zTree.init($("#urlTree"), setting_2, mapList);
					resetUrlTreeSelectedNode();
				});
			}else{
				static_menuId = menuId;
				static_url = url;
				var urlTree = $.fn.zTree.getZTreeObj("urlTree");
				urlTree.destroy();
			}
		}
		
		function menuTreeOnClick(event, treeId, treeNode, clickFlag){
			if(clickFlag){
				reloadUrl(treeNode.id, treeNode.url);
			}else{
				reloadUrl(0, '');
			}
		}

		function initTree(){
			reloadMenu();
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
		<legend class="legend_title">菜单管理</legend>
		<div style="margin: 10px;">
			<div class="form_search_item" >
				<div class="left">
					<a id="addParent" href="javascript:add()" class="base_btn"><span>添加一级菜单</span></a>
					操作说明：左边是所有菜单，右边是选中菜单的可选权限地址，复选框勾选的表示该菜单拥有的权限地址
				</div>
			</div>
			<div class="content_wrap">
				<div class="zTreeDemoBackground left">
					<ul id="menuTree" class="ztree"></ul>
				</div>
				<div class="right">
					<ul id="urlTree" class="ztree"></ul>
				</div>
			</div>
		</div>
	</fieldset>
</body>
</html>