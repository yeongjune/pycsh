<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${title}</title>
<style type="text/css">
	.contentDiv{
		width:99%;
		overflow: hidden; white-space: nowrap; text-overflow: ellipsis;
	}
</style>

<script type="text/javascript">

$(function(){

	loadMsg();

});
function loadMsg(){
	loadByPage('/sendMsg/loadList.action',{content:$('#content').val()},showList);
};

function showList(list){
	$('#tableBody').html('');
	var index = 0;
	for ( var item in list) {
		var msg = list[item];
		if(msg){
			var html = '';
			var typeStr ="";
			if(msg.type==1){
				typeStr="验证码";
			}
			if(msg.type==2){
				typeStr="捐款分配通知";
			}
			if(msg.type==3){
				typeStr="自定义短信";
			}
			html += '<tr>';
			
			html += '<td>'+msg.phone+'</td>';
			html += '<td>'+typeStr+'</td>';
			html += '<td>'+msg.createTime+'</td>';
			html += '<td width="30%"><div class="contentDiv"><a href="javascript:void(0);" onclick="viewContent(\''+msg.content+'\')">'+msg.content+'</a></div></td>';
			html += '</tr>';
			 $('#tableBody').append(html); 
		}else{
			
		}
		index++;
	}

};

function viewContent(str){
	art.dialog({
		title:"查看内容",
		content:str,
		ok:function(){
			
		}
		
	});
}


function sendMsg(){
	var str = '<textarea rows="5" cols="50" id="phoneStr"></textarea>';
	art.dialog({
		width : 400,
		height : 250,
		title : '接收号码(多个号码用英文下的 "," 隔开)',
		content : str,
		ok : function(){
			var html = '<textarea rows="5" cols="50" id="text"></textarea>';
			var phoneStr = $("#phoneStr").val();
			art.dialog({
				width : 400,
				height : 250,
				title : '短信内容',
				content : html,
				ok : function(){
					$.post('/sendMsg/sendMsgByPhone.action',{"phoneStr":phoneStr,"text":$("#text").val()},function(e){
						if(e=="ok"){
							art.dialog.alert("发送成功!");
						}
						if(e=="sendError"){
							art.dialog.alert("发送失败!");
						}
						if(e=="noSendPhone"){
							art.dialog.alert("没有需要发送的号码!");
						}
						if(e=="countOut"){
							art.dialog.alert("已超出短信剩余条数!");
						}
					},"text");
				}
			});
			}
		});


}


</script>
</head>
<body>
<fieldset class="fieldset_border">
	<legend class="legend_title">短信记录</legend>
			<div class="form_search_item" >
				<div class="left">
					<a href="javascript:void(0);" onclick="sendMsg();" class="base_btn"><span>发送自定义短信</span></a>
				</div>
			</div>
			<table  class="table_border" style="width: 99.7%;">
				<tr class="head">
					<td >接收号码</td>
					<td >类型</td>
					<td >时间</td>
					<td >内容</td>
				</tr>
				<tbody id="tableBody"></tbody>
			</table>
			<div class="table_under_btn" >
				<div class="flip">
				</div>
			</div><!--table_under_btn-->
		<div class="clear"></div>
</fieldset>
</body>
</html>