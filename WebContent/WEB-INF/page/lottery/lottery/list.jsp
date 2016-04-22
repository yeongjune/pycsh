<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>摇号管理</title>
</head>
<body>
	<!-- 头部 -->
	<c:import url="../common/head.jsp" />

    <!--主体main开始-->
    <div class="main">
        <!--主体main的右侧菜单开始-->
        <div class="main_left">
        <div class="ul_li1"><a href="/lottery/student/index.action" >参加学生</a></div>
        <div class="ul_li2"><a href="/lottery/student/index.action">学生管理</a></div>
        <div class="ul_li3"><a href="/lottery/lotterys.action" >摇号选项</a></div>
        <div class="ul_li4"><a href="/lottery/lotterys.action"  class="hover">摇号管理</a></div>
        <div class="ul_li5"><a href="/lottery/index.action">进入摇号</a></div>
        <div class="ul_li6"><a href="/lottery/student/result1.action">摇号结果</a></div>
        <div class="ul_li7"><a href="/lottery/student/result1.action">摇中名单</a></div>
        <div class="ul_li8"><a href="/lottery/student/result2.action">候补名单</a></div>
        <!-- <div class="ul_li8"><a href="/lottery/student/result3.action">未中名单</a></div> -->
        </div>
        <!--主体main的右侧菜单结束-->

        <!--主体main的左侧可更换内容开始-->
        <div class="main_right">
        <div class="content">
        <div class="main_right_title">
        <div class="left">
        	<a href="javascript:lotteryManager.createLottery()" class="a1">新建</a>
        </div>
     <div class="right">
     <!-- <form class="form"> 
        <span class="select">测试</span>
        <input class="" name="title" type="text" />
        <input name="Submit2" value="搜索" class="submit" type="submit" />
        </form> -->
        </div>
        <div class="clear"></div>
        </div>
        
        <table class="table" width="100%"  cellspacing="0" cellpadding="0" id="main_table">
          <tr class="border">
            <td width="50" height="44"><input type="checkbox" id="chk_ids"/></td>
            <td height="44">标题</td>
            <td height="44">摇号人数</td>
            <!-- <td height="44">候补人数</td>
            <td height="44">摇号次数</td> -->
            <td height="44">创建时间</td>
            <td height="44">操作</td>
          </tr>
          <tbody id="tableBody"></tbody>
        </table>
        <div class="page_list">
        	<!-- <a href="javascript:lotteryManager.deleteMutilLottery()" class="base_btn" style="float: left;" id="deleteMutil"><span>删除</span></a> -->
			  <!-- <form><div class="digg4"><a href="#">上一页</a>&nbsp;&nbsp; 第&nbsp;<input class="page_input">&nbsp;页 &nbsp;&nbsp;<a href="#">下一页</a>  &nbsp;&nbsp;&nbsp;<input value="确定" class="submit" type="submit"></div></form> -->
			  </div>
        </div>
      </div>
        <!--主体main的左侧可更换内容结束-->
        <div class="clear"></div>
    </div>
    <!--主体main结束-->


<!-- <fieldset class="fieldset_border">
	<legend class="legend_title">摇号列表</legend>
		<div style="margin-left: 252px;">
		<div >
			<div class="form_search_item" >
				<div class="left">
					<a href="javascript:lotteryManager.createLottery()" class="base_btn"><span>新建</span></a>
					<a href="javascript:studentManager.importStudent()" class="base_btn"><span>批量导入</span></a>
					<a href="javascript:studentManager.downloadTemplate()" class="base_btn"><span>下载模板</span></a>
					<span>操作说明：在左边树单击选择栏目</span>
				</div>
				<div class="right">
					<input type="text" class="piece" id="keyword" onkeydown="if(event.keyCode==13){lotteryManager.load();}"/>
					<a href="javascript:lotteryManager.load()" class="base_btn"><span>搜索</span></a>
				</div>
			</div>
			<table  class="table_border" style="width: 99.7%;">
				<tr class="head">
					<td width="40px"><input type="checkbox" id="chk_ids"/></td>
					<td >标题</td>
					<td >摇号人数</td>
					<td >摇号次数</td>
					<td >创建时间</td>
					<td width="110px">操作 </td>
				</tr>
				<tbody id="tableBody"></tbody>
			</table>
			<div class="table_under_btn" >
				<a href="javascript:lotteryManager.deleteMutilLottery()" class="base_btn" style="float: left;" id="deleteMutil"><span>删除</span></a>
				<a href="javascript:studentManager.moveMutilStudent()" class="base_btn" style="float: left;" id="moveMutil"><span>移动栏目</span></a>
				<a href="javascript:studentManager.settingStatus()" class="base_btn" style="float: left;" id="changeStatus"><span>切换状态</span></a>
				<div class="flip">
				</div>
			</div>table_under_btn
		</div>
		<div class="clear"></div>
</fieldset> -->
<script type="text/javascript">
var lotteryManager;
$(function(){
	lotteryManager = new lotteryManager('${siteId}');
	lotteryManager.load();
	
	$("#chk_ids").click(function(){
		if($(this).attr("checked")){
			$("input[name='chk_lottery_id']").attr('checked',true);
		}else{
			$("input[name='chk_lottery_id']").attr('checked',false);
		}
	});
});

function lotteryManager(siteId){
	this.siteId = siteId;
	this.load = function(){
		loadByPage('/lottery/list.action',{name:$('#keyword').val()},this.showList);
	};
	this.showList = function(list){
		$('#tableBody').html('');
		for ( var item in list) {
			var lottery = list[item];
			if(lottery){
				var html = '';
				html = '<tr id="tr_'+lottery.id+'"' + (item%2 == 0 ? '' : 'class="bgg"')  + '>'+
				'	<td height="44"><input type="checkbox" name="chk_lottery_id" value="'+lottery.id+'" /></td>'+
				'	<td height="44">'
						/* +'<a href="javascript:lotteryManager.toViewLottery('+lottery.id+');" style="text-decoration:none;">'+lottery.title+'</a></td>'+ */
						+lottery.title+'</td>'+
				'	<td height="44">'+(lottery.number == null ? '' : lottery.number)+'</td>'+
				/* '	<td height="44">'+(lottery.waitNum == null ? '' : lottery.waitNum)+'</td>'+
				'	<td height="44">'+lottery.times+'</td>' + */
				'	<td height="44">'+lottery.createTime+'</td>';
				html += '<td height="44"><a href="javascript:lotteryManager.editLottery('+lottery.id+');">修改</a>'+
						'		<a href="javascript:lotteryManager.deleteLottery('+lottery.id+');">删除</a>'+
						/* '		<a href="javascript:lotteryManager.toViewLottery('+lottery.id+');">查看</a>'+ */
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
		addHover('#main_table');
	};
	this.createLottery = function(){
		
		art.dialog.open('/lottery/toAdd.action?', {
			width: '50%',
			height: '50%',
			title:'添加'
		});
		
	};
	this.deleteLottery = function(id){
		art.dialog.confirm("确定删除吗？", function(){
			$.post('/lottery/delete.action',{ids:id},function(data){
				if(data=='succeed'){
					lotteryManager.load();
				}else{
					art.dialog.alert('操作失败');
				}
			});
		});
	};
	this.deleteMutilLottery = function(){
		var ids=[];
		$("input[type='checkbox'][name='chk_lottery_id']:checked").each(function(){
			ids.push($(this).val());
		});
		
		if (!ids||ids.length==0) {
			art.dialog.alert("您尚未选中任何要删除的摇号！");
			return;
		}

		art.dialog.confirm("您确定要批量删除已选中的摇号吗？", function(){
			$.post('/lottery/delete.action',{ids:ids.join(',')},function(data){
				if(data=='succeed'){
					lotteryManager.load();
				}else{
					art.dialog.alert('操作失败');
				}
			});
		});
	};
	this.editLottery = function(id){
		art.dialog.open('/lottery/toEdit.action?id='+id, {
			width: '50%',
			height: '50%',
			title:'修改'
		});
	};
	this.toViewLottery = function(id){
		art.dialog.open('/lottery/toView.action?id='+id, {
			width: '100%',
			height: '100%',
			title:'查看'
		});
	};
}

function addHover(table){
	$(table).find('tr').each(function(i){
		if(i == 0){
			return;
		}
		var oldClass = $(this).attr('class') == null ? '' : $(this).attr('class');
		$(this).mousemove(function(){
			$(this).attr('class','tr_hover');
		});
		$(this).mouseout(function(){
			$(this).attr('class',oldClass);
		});
	});
}

</script>
</body>
</html>