<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">新闻管理</legend>
		<div class="zTreeDemoBackground left" style="padding-bottom:30px;">
			<ul id="columnTree" class="ztree"></ul>
		</div>
		<div style="margin-left: 252px;">
			<div class="form_search_item" >
				<div class="left">
					<a href="javascript:articleManager.createArticle()" class="base_btn"><span>新建新闻</span></a>
					<span>操作说明：在左边树单击选择栏目</span>
				</div>
				<div class="right">
					<input type="text" class="piece" id="keyword" onkeydown="if(event.keyCode==13){articleManager.load();}"/>
					<a href="javascript:articleManager.load()" class="base_btn"><span>搜索</span></a>
				</div>
			</div>
			<table  class="table_border" style="width: 99.7%;">
				<tr class="head">
					<td width="40px"><input type="checkbox" id="chk_ids"/></td>
					<td >标题</td>
					<!-- <td >内容</td> -->
					<td width="110px">排序</td>
					<td width="110px">发布时间</td>
					<td width="50px">状态</td>
					<td width="90px">发布人</td>
					<td>审核状态</td>
					<td width="110px">操作 </td>
				</tr>
				<tbody id="tableBody"></tbody>
			</table>
			<div class="table_under_btn" >
				<a href="javascript:articleManager.deleteMutilArticle()" class="base_btn" style="float: left;" id="deleteMutil"><span>删除</span></a>
				<a href="javascript:articleManager.moveMutilArticle()" class="base_btn" style="float: left;" id="moveMutil"><span>移动栏目</span></a>
				<a href="javascript:articleManager.settingStatus()" class="base_btn" style="float: left;" id="changeStatus"><span>切换状态</span></a>
				<div class="flip">
				</div>
			</div><!--table_under_btn-->
		</div>
		<div class="clear"></div>
</fieldset>
<script type="text/javascript">
var columnId;
var columnName;
var columnType;
var articleManager;
$(function(){
	articleManager = new ArticleManager('${siteId}');
	articleManager.initTree();
	articleManager.load();
	
	$("#chk_ids").click(function(){
		if($(this).attr("checked")){
			$("input[name='chk_article_id']").attr('checked',true);
		}else{
			$("input[name='chk_article_id']").attr('checked',false);
		}
	});
});

function ArticleManager(siteId){
	this.siteId = siteId;
	this.load = function(){
		loadByPage('/article/list.action',{siteId: this.siteId, columnId:columnId,keyword:$('#keyword').val()},this.showList);
	};
	this.showList = function(list){
		$('#tableBody').html('');
		for ( var item in list) {
			var article = list[item];
			if(article){
				var html = '';
				html = '<tr id="tr_'+article.id+'">'+
				'	<td><input type="checkbox" name="chk_article_id" value="'+article.id+'" /><input name="columnType" type="hidden" value="'+article.columnType+'" /></td>'+
				'	<td style="text-align: left;padding-left:10px;">'
						+'<a href="javascript:articleManager.toViewArticle('+article.id+');" style="text-decoration:none;">'+article.title+'</a></td>'+
				'	<td>'+
				'		<a href="javascript:articleManager.changeSort('+article.id+',1);" title="上移">↑</a>'+
				'		<a href="javascript:articleManager.changeSort('+article.id+',2);" title="下移">↓</a>'+
				'		<a href="javascript:articleManager.changeSort('+article.id+',3);" >置顶</a>'+
				'		<a href="javascript:articleManager.changeSort('+article.id+',4);" >置尾</a>'+
				'	</td>'+
				'	<td width="150px">'+(article.createTime?article.createTime:'')+'</td>'+
				'	<td class="status" value="' + (article.status?1:0) + '">'+(article.status==1?"新":"无")+'</td>';
				html += '	<td>'+(article.name?article.name:'')+'</td>';
				html += '	<td>';
				switch (article.checked) {
				case 0:
					html += '无需审核';
					break;
				case 1:
					html += '等待审核';
					break;
				case 10:
					html += '审核不通过';
					break;
				case 11:
					html += '审核通过';
					break;
				default:
					break;
				}
				html += '</td>'+
				'	<td>';
				if( article.checked == 1 && '${isCheck}' > 0){
					if( '${site.isUseCheck}' > 0 ){
						html += '		<a href="javascript:articleManager.checkArticle('+article.id+');">审核</a>';
					}else{
						html += '		<a href="javascript:void(0);" style="color: #85898B;cursor: default;">审核</a>';
					}
				}
				html += '		<a href="javascript:articleManager.editArticle('+article.id+');">修改</a>'+
				'		<a href="javascript:articleManager.deleteArticle('+article.id+');">删除</a>'+
				'		<a href="javascript:articleManager.toViewArticle('+article.id+');">查看</a>'+
				'	</td>'+
				'</tr>';
				 $('#tableBody').append(html); 
			}else{
				
			}
		}
		if (list&&list.length>0) {
			$("#deleteMutil").show();
			$("#moveMutil").show();
			$("#changeStatus").show();
		}else{
			$("#deleteMutil").hide();
			$("#moveMutil").hide();
			$("#changeStatus").hide();
		}
	};
	this.createArticle = function(){
		if (!columnId||columnId==0) {
			art.dialog.alert('请先选择栏目');
			return;
		}
		
		/* if (columnType=="外部链接") {
			art.dialog.alert('外部链接不能新增新闻');
			return;
		} */
		if (columnType=="单网页") {
			//单网页只能加一条新闻
			$.post('/article/getArticleCount.action',{columnId:columnId},function(data){
				if (data==0) {
					art.dialog.open('/article/add.action?siteId='+siteId+'&columnId='+columnId, {
						width: '100%',
						height: '100%',
						title:'添加新闻'
					});
				}else{
					art.dialog.alert('该栏目为单网页栏目，只能有一条新闻');
				}
			});
		}else{
			art.dialog.open('/article/add.action?siteId='+siteId+'&columnId='+columnId, {
				width: '100%',
				height: '100%',
				title:'添加新闻'
			});
		}
		
	};
	this.deleteArticle = function(id){
		art.dialog.confirm("确定删除吗？", function(){
			$.post('/article/delete.action',{ids:id},function(data){
				if(data=='succeed'){
					//$('#tr_'+id).remove();
					articleManager.load();
				}else{
					art.dialog.alert('操作失败');
				}
			});
		});
	};
	this.deleteMutilArticle = function(){
		var ids=[];
		$("input[type='checkbox'][name='chk_article_id']:checked").each(function(){
			ids.push($(this).val());
		});
		
		if (!ids||ids.length==0) {
			art.dialog.alert("您尚未选中任何要删除的新闻！");
			return;
		}

		art.dialog.confirm("您确定要批量删除已选中的新闻吗？", function(){
			$.post('/article/delete.action',{ids:ids.join(',')},function(data){
				if(data=='succeed'){
					/* for (var index in ids) {
						$('#tr_'+ids[index]).remove();
					} */
					articleManager.load();
				}else{
					art.dialog.alert('操作失败');
				}
			});
		});
	};
	this.editArticle = function(id){
		art.dialog.open('/article/edit.action?id='+id, {
			/* width: '1010px',
			height: '95%', */
			width: '100%',
			height: '100%',
			title:'修改新闻'
		});
	};
	this.checkArticle = function(id){
		var html = '<label><input type="radio" name="isCheckedState" value="1"/>审核通过</label><label><input type="radio" name="isCheckedState" value="0"/>审核不通过</label>';
		art.dialog({
			width : 200,
			height : 150,
			title : '审核新闻',
			content : html,
			ok : function(){
				$.post('/article/changeCheckState.action', 'id='+id+'&state='+$('input[name="isCheckedState"]:radio:checked').val(), function(data){
					articleManager.load();
				}, 'json');
			}
		});
	};
	this.toViewArticle = function(id){
		art.dialog.open('/article/toView.action?id='+id, {
			width: '100%',
			height: '100%',
			title:'新闻详情'
		});
	};
	this.initTree =function(){
		$.post('/article/getTreeData.action',function(data){
			columnId = 0;
			var mapList = $.parseJSON(data);
			$.fn.zTree.init($("#columnTree"),setting,mapList);
		});
	};
	this.moveMutilArticle = function(){
		var ids=[];
		var columType='';
		var pass=true;
		$("input[type='checkbox'][name='chk_article_id']:checked").each(function(){
			if(columType==''){
				columType=$(this).next().val();	
			}else if(columType != $(this).next().val()){
				pass=false;
				return false;
			} 
			ids.push($(this).val());
		});
		
		if(!pass){
			art.dialog.alert("您选择了多个类型的新闻，不同类型的新闻不能移动到同一栏目");
			return;
		}
		
		if (!ids||ids.length==0) {
			art.dialog.alert("您尚未选中任何要移动的新闻！");
			return;
		}
		art.dialog.open('/article/toMoveColumn.action?ids='+ids.join(',') + "&columType="+columType, {
			width: '250px',
			height: '435px',
			title:'选择栏目'
		});
	};
	//修改文章相对应最后修改时间的排序
	this.changeSort = function(id,flag){
		$.post('/article/updateArticleSort.action',{id:id,flag:flag},function(data){
			if(data=='succeed'){
				articleManager.load();
			}else{
				art.dialog.tips('操作失败');
			}
		});
	};
	//设定所选文章的新旧状态
	this.settingStatus = function(){
		
		var ids=[];
		var vals=[];
		$("input[type='checkbox'][name='chk_article_id']:checked").each(function(){
			var this_e = $(this);
			ids.push(this_e.val());
			vals.push(this_e.parent("td").siblings(".status").attr("value").toString());
		});
		
		if (!ids||ids.length==0) {
			art.dialog.alert("您尚未选中任何要设置的选项！");
			return;
		} 
		
		art.dialog.confirm("您确定要修改新旧状态?", function(){
			$.post('/article/updateStatus.action',{ids:ids.join(','),status : vals.join(",")},function(data){
				if(data=='true'){
					/* for (var index in ids) {
						$('#tr_'+ids[index]).remove();
					} */
					articleManager.load();
				}else{
					art.dialog.alert('操作失败');
				}
			});
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
			if (columnId != treeNode.id) {
				columnId = treeNode.id;
				columnType = treeNode.type;
				articleManager.load();
			}else{
				 $.fn.zTree.getZTreeObj("columnTree").cancelSelectedNode();
				columnId = null;
				columnType= null;
				articleManager.load();
			}
			
		}
	}
};
</script>
</body>
</html>