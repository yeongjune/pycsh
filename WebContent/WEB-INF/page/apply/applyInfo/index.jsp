<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title }</title>
<script type="text/javascript">
var mngApplyInfo;
$(function(){
	$("#chk_ids").click(function(){
		if($(this).attr("checked")){
			$("input[name='chk_apply_id']").attr('checked',true);
		}else{
			$("input[name='chk_apply_id']").attr('checked',false);
		}
	});
	mngApplyInfo=new ManagerApplyInfo();
	mngApplyInfo.load();
});

function ManagerApplyInfo(){
	this.load = function () {
		lockWindow();
		$.ajax({
			url:'/applyInfo/list.action',
			dataType:'json',
			type:'post',
			success:function(data){
				openLock();
				mngApplyInfo.showList(data);
			},
			error:function(){
				openLock();
				art.dialog.tips('获取报名列表失败，请重试');
			}
		});
	};
	this.showList= function(list){
		var tempStr="";
		var index=0;
		for ( var key in list) {
			index++;
			var item = list[key];
			tempStr +='<tr id="tr_'+item.id+'">'+
					'	<td>'
							+'<input type="checkbox" name="chk_apply_id" value="'+item.id+'" />'+
					'	</td>'+
					'	<td>'+index+'</td>'+
					'	<td>'+item.applyNo+'</td>'+
					'	<td>'+item.title+'</td>'+
					'	<td>'+item.startTime+ '</td>'+
					'	<td>'+item.endTime+'</td>' +
					'	<td>'+(item.state==0?'未开启':'已开启') + '	</td>'+
					'	<td> '+
						' <a href="javascript:mngApplyInfo.edit('+item.id+');">修改</a> '+
						' <a href="javascript:mngApplyInfo.updateState('+item.id+','+(item.state==0?1:0)+');">'+(item.state==0?'开启':'停止')+'</a> '+
						'</td>'+
					'</tr>';
		}
		$('#tableBody').html(tempStr);
	};
	//删除
	this.delMulti =function (){
		var ids=[];
		var names=[];
		$("input[type='checkbox'][name='chk_apply_id']:checked").each(function(){
			ids.push($(this).val());
			names.push($(this).parent().next().next().text());
		});
		if(!ids || ids.length==0){
			art.dialog.tips("您尚未选择任何要删除项");
			return;
		}
		art.dialog.confirm("您确定要删除 [ "+names.join(",")+" ] 的报名吗？", function(){
			lockWindow();
			$.ajax({
				url:'/applyInfo/delete.action',
				data:{ids:ids.join(',')},
				dataType:'json',
				type:'post',
				success:function(data){
					openLock();
					if(data.code=='succeed'){
						for (var index in ids) {
							$('#tr_'+ids[index]).remove();
						}
					}else{
						art.dialog.tips(data.msg);
					}
				},
				error:function(){
					openLock();
					art.dialog.tips('获取报名列表失败，请重试');
				}
			});
		});
	};
	//编辑报名
	this.edit = function (id){
		art.dialog.open('/applyInfo/toEdit.action'+(id?'?id='+id:''),{
			title : id?'修改报名':'新增报名',
			width: '600px',
			height: '400px'
		});
	};
	//更新报名状态：id 报名id,state: 更新后的报名状态标识
	this.updateState = function(id,state){
		art.dialog.confirm('请确定'+(state==0?'停止':'开启')+'报名',function(){
			lockWindow();
			$.ajax({
				url:'/applyInfo/updateState.action',
				data:{id:id,state:state},
				dataType:'json',
				type:'post',
				success:function(data){
					openLock();
					if(data.code=='succeed'){
						mngApplyInfo.load();
					}
					art.dialog.tips(data.msg);
				},
				error:function(){
					openLock();
					art.dialog.tips('获取报名列表失败，请重试');
				}
			});
		});
	};
}

</script>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">报名管理</legend>
		<div class="form_search_item" >
			<div class="left">
				<a href="javascript:mngApplyInfo.edit();" class="base_btn"><span>新增报名</span></a>
				<a href="javascript:mngApplyInfo.delMulti()" class="base_btn"><span>删除</span></a>
			</div>
		</div>
		<table  class="table_border">
			<tr class="head">
				<td style="width: 30px;" class="thead"> 
					<input type="checkbox" id="chk_ids"/>
				</td>
				<td width="40px">行号</td>
				<td width="90px">编号</td>
				<td >报名标题</td>
				<td width="90px">报名开始日期</td>
				<td width="90px">报名结束日期</td>
				<td width="90px">报名状态</td>
				<td style="width: 90px">操作 </td>
			</tr>
			<tbody id="tableBody"></tbody>
		</table>
		<div class="clear"></div>
</fieldset>
</body>
</html>