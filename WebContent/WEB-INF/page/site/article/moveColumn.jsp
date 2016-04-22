<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
var columType_old="${columType}";//移动前所属栏目的类型名
var columnId;
var columnType;
var mngArticleColumn;
$(function(){
	mngArticleColumn=new MngArticleColumn("${ids}");
	mngArticleColumn.initTree();
});
function MngArticleColumn(ids){
	this.articleIds=ids;
	this.initTree =function(){
		$.post('/article/getTreeData.action',function(data){
			columnId = null;
			columnType=null;
			var mapList = $.parseJSON(data);
			$.fn.zTree.init($("#columnTree"),setting,mapList);
		});
	};
	this.submit = function(){
		if(!columnId){
			art.dialog.tips('请选择您要移动到到的栏目');
			return;
		}
		$.post('/article/updateArticleColumn.action',{ids:this.articleIds ,columnId : columnId},function(data){
			if(data=='succeed'){
				art.dialog.opener.articleManager.load();
				art.dialog.close();
			}else{
				art.dialog.tips('修改失败');
			}
		});
	};
}

var setting = {
		data: {
			key:{
				name:"name",
				title:"id",
				url:"javascript:void();"
			},
			simpleData: {
				enable: true,
				idKey:"id",
				pIdKey:"pid",
				rootPid:0
			}
		},
		callback: {
			onClick: function(event, treeId, treeNode){
				columnId = treeNode.id;
				columnType = treeNode.type;
				
				//不同类的栏目不能相互移动
				if(columType_old != treeNode.type ){
					art.dialog.tips("["+columType_old.replace('栏目','') + ']类型文章不能移动到<br/>['+treeNode.type.replace('栏目','') +']类型栏目');
					columnId = null;
					columnType =null;
					$.fn.zTree.getZTreeObj("columnTree").cancelSelectedNode();
					return;
				}
				
				//不能移动到外部连接
				/* if(treeNode.type=='外部链接'){
					art.dialog.tips('不能移动到外部链接栏目');
					columnId = null;
					columnType =null;
					$.fn.zTree.getZTreeObj("columnTree").cancelSelectedNode();
					return;
				} */
				
				//单网页的只能有一条新闻
				if(treeNode.type=='单网页'){
					//单网页只能加一条新闻
					$.post('/article/getArticleCount.action',{columnId:treeNode.id},function(data){
						if (data>0) {
							art.dialog.tips('该栏目为单网页栏目,<br/>只能包含一条新闻');
							columnId = null;
							columnType =null;
							$.fn.zTree.getZTreeObj("columnTree").cancelSelectedNode();
						}
					});
				}
				
				
			}
		}
	};
</script>
</head>
<body>

<div class="zTreeDemoBackground left" style="margin:0px;padding:0px;padding-bottom:28px;">
		<ul id="columnTree" class="ztree"></ul>
</div>
<a href="javascript:void();" class="base_btn" onClick="mngArticleColumn.submit()"><span>确定</span></a>
</body>
</html>