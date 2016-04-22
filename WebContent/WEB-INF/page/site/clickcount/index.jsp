<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="/plugin/datepicker/WdatePicker.js"></script>
<title>${title}</title>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">投票管理</legend>
		<div class="zTreeDemoBackground left" style="padding-bottom:30px;">
			<ul id="columnTree" class="ztree"></ul>
		</div>
		<div style="margin-left: 252px;">
			<div class="form_search_item" >
				<div class="left">
					<a href="javascript:articleManager.createArticle()" class="base_btn"><span>新建投票</span></a>
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
					<td width="40px">编号</td>
					<td>标题</td>
					<!-- <td >内容</td> -->
					<td width="60px">票数</td>
					<td width="110px">发布时间</td>
					<td width="110px">截止时间</td>
					<td width="110px">发布人</td>
					<td width="110px">操作 </td>
				</tr>
				<tbody id="tableBody"></tbody>
			</table>
			 
			<div class="table_under_btn" >
				<a href="javascript:articleManager.deleteMutilArticle()" class="base_btn" style="float: left;" id="deleteMutil"><span>删除</span></a>
				<a href="javascript:articleManager.loadByClickCount()" class="base_btn" style="float: left;" id="moveMutil"><span>降序(票数)</span></a>
				<div class="flip">
				</div>
			</div><!--table_under_btn-->
			<fieldset class="fieldset_border">
				<legend class="legend_title">投票统计设置</legend>
				<div class="view_rank" style="width:100px;height: 20px;line-height: 20px;">
					<span class="view_rank_span" style=" width: 60px; ">总投票数：</span>
					<span id="num">0</span>
				</div>
				<div class="right" style="margin-left: 10px;">
					<input id="date" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="line-height: 23px;"/>
					<a class="base_btn" href="javascript:articleManager.settingLastTime()"><span>期限设定</span></a>
				</div>
				<div class="right" style="margin-left: 10px;">
					<input id="voteNum" type="text" style="line-height: 23px;"/>
					<a class="base_btn" href="javascript:articleManager.settingVoteNum()"><span>可投票数设定</span></a>
				</div>
			</fieldset>
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
	articleManager.checkTotalCount();
});

function ArticleManager(siteId){
	this.siteId = siteId;
	this.load = function(){
		loadByPage('/article/list.action',{siteId: this.siteId, columnId:columnId,keyword:$('#keyword').val()},this.showList);
	};
	this.showList = function(list){
		$('#tableBody').html('');
		var num = 1;
		for ( var item in list) {
			var article = list[item];
			if(article){
				 $('#tableBody').append(
						'<tr id="tr_'+article.id+'">'+
						'	<td><input type="checkbox" name="chk_article_id" value="'+article.id+'" /><input name="columnType" type="hidden" value="'+article.columnType+'" /></td>'+
						'   <td class="ranking">' + num + '</td>'+
						'	<td style="text-align: left;padding-left:10px;">'
								+'<a href="javascript:articleManager.toViewArticle('+article.id+');" style="text-decoration:none;">'+article.title+'</a></td>'+
					    '   <td>' + article.clickCount + '</td>'+
						'	<td>'+(article.createTime?article.createTime:'')+'</td>'+
						'	<td>'+(article.lastTime?article.lastTime:'')+'</td>'+
						'	<td>'+(article.name?article.name:'')+'</td>'+
						'	<td>'+
						'		<a href="javascript:articleManager.editArticle('+article.id+');">修改</a>'+
						'		<a href="javascript:articleManager.deleteArticle('+article.id+');">删除</a>'+
						'		<a href="javascript:articleManager.toViewArticle('+article.id+');">查看</a>'+
						'	</td>'+
						'</tr>'
				);
				num++;
			}else{
				
			}
		}
		if (list&&list.length>0) {
			$("#deleteMutil").show();
			$("#moveMutil").show();
		}else{
			$("#deleteMutil").hide();
			$("#moveMutil").hide();
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
	//按票数降序显示文章
	this.loadByClickCount = function(){
		loadByPage('/article/list.action',{siteId: this.siteId, columnId:columnId,keyword:$('#keyword').val(),sortType:2},this.showList);
	};
	//显示指定栏目总票数
	this.checkTotalCount = function(){
		$.post("/articleClickCount/checkTotalCount.action",{columnId:columnId},function(data){
			$("#num").html(data);
		});
	};
	//统计排名
	this.rankingSetting = function(){
		var pageNow = Number($(".flip > span").first().html());
		console.log(pageNow);
		$(".ranking").each(function(i, e){
			var element = $(e);
			var temp = Number(element.html()) + (pageNow - 1) * 10;
			element.html(temp);
		});
	};
	//设定所选文章的截止日期
	this.settingLastTime = function(){
		var date = $("#date").val();
		
		var ids=[];
		$("input[type='checkbox'][name='chk_article_id']:checked").each(function(){
			ids.push($(this).val());
		});
		
		if (!ids||ids.length==0) {
			art.dialog.alert("您尚未选中任何要设置期限的投票项！");
			return;
		} else if (date == "") {
			art.dialog.alert("您尚未设定截止时间！");
			return;
		}
		
		art.dialog.confirm("您确定要批量所选项日期为"+date+"？", function(){
			$.post('/articleClickCount/updateLastTime.action',{ids:ids.join(','),lastTime:date},function(data){
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
	
	//获取可投票项目数
	this.getVoteNum = function(){
		if (!columnId||columnId==0) {
			art.dialog.alert('请先选择栏目');
			return;
		}
		
		$.post("/articleClickCount/getVoteNum.action",{columnId:columnId},function(data){
			$("#voteNum").val(data);
		});
	};
	
	//更改可投票项目数
	this.settingVoteNum = function(){
		if (!columnId||columnId==0) {
			art.dialog.alert('请先选择栏目');
			return;
		}
		var voteNum = Number($("#voteNum").val());
		if(!(voteNum >= 0)){
			art.dialog.alert('请输入正确类型');
			return;
		}
		
		$.post("/articleClickCount/updateVoteNum.action",{columnId : columnId, voteNum : voteNum},function(data){
			if(data){
				art.dialog.alert('修改成功');
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
			if (columnId != treeNode.id) {
				columnId = treeNode.id;
				columnType = treeNode.type;
				articleManager.load();
				articleManager.checkTotalCount(); //显示对应栏目作品投票次数
				articleManager.getVoteNum(); //显示目标栏目可投票项数
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