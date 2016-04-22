<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>column</title>
	<script type="text/javascript">
	var static_selected_node = 0;
	var static_columnId = 0;
	var setting_1 = {
			view: {
				selectedMulti: false
			},
			edit: {
				enable: true,
				removeTitle:'删除',
				showRenameBtn: false
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
				beforeRemove: beforeRemove,
				onRemove: zTreeOnRemove,
				beforeDrop: zTreeBeforeDrop,
				onDrop: zTreeOnDrop,
				onClick: columnTreeOnClick
			}
		};
	
	var siteId = "${siteId}";
	function reloadColumn(){
		$.post('/column/list.action',{siteId: siteId},function(data){
			static_columnId = 0;
			var mapList = $.parseJSON(data);
			$.fn.zTree.init($("#columnTree"), setting_1, mapList);
			static_selected_node = null;
			static_columnId = false;
			$('#column_type_fieldset').html('<div class="left" ><a href="javascript:add()" class="base_btn"><span>添加栏目</span></a></div>');
		});
	}
	var siteId = '${authority_user.siteId}';
	function add(){
		if(siteId>0){
			$.post('/column/add.action', {}, function(data){
				$('#column_type_fieldset').html(data);
				$('#pName').text(static_selected_node?static_selected_node.name:'无');
			});
		}else{
			art.dialog.alert('你不是网站管理员，不能添加栏目');
		}
	}
	function cancel(){
		if(static_selected_node && static_columnId){
			edit();
		}else{
			$('#column_type_fieldset').html('<div class="left" ><a href="javascript:add()" class="base_btn"><span>添加栏目</span></a></div>');
		}
	}
	function saveColumn(id){
		var column = new Object();
		column.name = $('#name').val();
		column.pid = static_columnId;
		column.type = $('#type').val();
		column.alias = $('#alias').val();
		column.type = $('#type').val();
		column.navigation = $('#navigation').val();
		var zTree = $.fn.zTree.getZTreeObj("columnTree");
		var newNode = zTree.addNodes(static_selected_node, {
			id: id,
			pId: column.pid,
			name: column.name
			});
	}
	function updateColumn(id, pid, sort, level){
		pid = pid?pid:0;
		$.post('/column/updateRelation.action',{id: id, pid: pid, sort: sort, level: level},function(data){
			if(data=='succeed'){
				
			}else{
				reloadColumn();
			}
		});
	}
	function beforeRemove(treeId, treeNode) {
		return confirm("确认删除栏目“" + treeNode.name + "”吗？");
	}
	function zTreeOnRemove(event, treeId, treeNode) {
		deleteColumn(treeNode);
	}
	function deleteColumn(targetNode){
		var column_id = targetNode.id;
		$.post('/column/delete.action',{id:column_id},function(data){
			if(data!='succeed'){
				reloadColumn();
				alert('删除失败');
			}else{
				if(column_id==static_columnId){
					static_selected_node = null;
					static_columnId = false;
					$('#column_type_fieldset').html('<div class="left" ><a href="javascript:add()" class="base_btn"><span>添加栏目</span></a></div>');
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
			children = $.fn.zTree.getZTreeObj("columnTree").getNodes(0);
		}else{
			pid = parentNode.id;
			children = parentNode.children;
		}
		for ( var item in children) {
			var treeNode = children[item];
			var treeObj = $.fn.zTree.getZTreeObj("columnTree");
			var index = treeObj.getNodeIndex(treeNode);
			pid = pid&&pid!=null&&pid!='null'?pid:0;
			updateColumn(treeNode.id, pid, index, treeNode.level);
		}
		reloadColumn();
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
		}else{
			parentNode = targetNode.getParentNode();
		}
		updateAllChildren(parentNode);
	}
	function updateAllChildren(node){
		var children;
		if(node){
			children = node.children;
		}else{
			var treeObj = $.fn.zTree.getZTreeObj("columnTree");
			children = treeObj.getNodes();
		}
		if(children && children.length>0){
			for ( var item in children) {
				var child = children[item];
				updateSelfAndChildren(child);
			}
		}
	}
	function updateSelfAndChildren(node){
		var pid = 0;
		var parentNode = node.getParentNode();
		if(parentNode)pid=parentNode.id;
		var treeObj = $.fn.zTree.getZTreeObj("columnTree");
		var index = treeObj.getNodeIndex(node);
		updateColumn(node.id, pid, index, node.level);
		updateAllChildren(node);
	}
	function columnTreeOnClick(event, treeId, treeNode, clickFlag){
		if(clickFlag){
			static_selected_node = treeNode;
			static_columnId = treeNode.id;
			edit();
		}else{
			static_selected_node = null;
			static_columnId = false;
			$('#column_type_fieldset').html('<div class="left" ><a href="javascript:add()" class="base_btn"><span>添加栏目</span></a></div>');
		}
	}
	function edit(){
		if(static_selected_node && static_columnId){
			$.post('/column/edit.action', {id: static_columnId}, function(data){
				$('#column_type_fieldset').html(data);
				$('#pName').text(static_selected_node.getParentNode()?static_selected_node.getParentNode().name:'无');
			});
		}else{
			
		}
	}
	function cancelEdit(){
		if(static_selected_node && static_columnId){
			var treeObj = $.fn.zTree.getZTreeObj("columnTree");
			treeObj.cancelSelectedNode();
			static_selected_node = null;
			static_columnId = false;
			$('#column_type_fieldset').html('<div class="left" ><a href="javascript:add()" class="base_btn"><span>添加栏目</span></a></div>');
		}else{
			
		}
	}
	
		function initTree(){
			reloadColumn();
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
		<legend class="legend_title">栏目管理</legend>
		<div style="margin: 10px;">
			<div class="form_search_item" >
				<div class="left">
			以下为网站栏目结构，可以添加新栏目、删除栏目、选择栏目可以编辑、添加子栏目，可以拖拽栏目改变顺序及所属关系
				</div>
			</div>
			<div class="zTreeDemoBackground left" style="min-height: 400px;">
				<ul id="columnTree" class="ztree"></ul>
			</div>
			<div style="margin-left: 250px;" id="column_type_fieldset">
			</div>
		</div>
	</fieldset>
</body>
</html>