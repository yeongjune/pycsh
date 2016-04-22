<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>结果查询</title>
<%
    //（1）做开发时，可去掉下面注释！以便清理缓存！
    //（2）项目完成时，必须把下面内容注释起来！(否则ie6下出现网页过期)
    request.getSession().getServletContext().setAttribute("css", "");
	//request.getSession().getServletContext().setAttribute("css", "");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	response.flushBuffer();
	request.setAttribute("ctx", request.getContextPath());
%>

<!-- css import -->
<link href="${css }/skins/lottery/css/base.css" rel="stylesheet" type="text/css" />
<link href="${css }/skins/lottery/css/layout.css" rel="stylesheet" type="text/css" />

<!-- jquery 支持-->
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>

<!-- png透明 -->
<script type="text/javascript" src="/plugin/iepngfix_tilebg.js"></script>

<!-- cookie 操作 -->
<script type="text/javascript" src="/plugin/jquery.cookie.js"></script>
<script type="text/javascript" src="/js/base/md5.min.js"></script>
<!-- 弹出框引入 -->
<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>

<script type="text/javascript" src="/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript" src="/js/base/util.js"></script>
<script type="text/javascript" src="/js/base/PagedQuery.js"></script>

<script type="text/javascript" src="/plugin/ztree3.5.14/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="/plugin/ztree3.5.14/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript" src="/plugin/ztree3.5.14/jquery.ztree.exedit-3.5.min.js"></script>

</head>
<body >
<!--头部header开始-->
    <div class="header">
	    <div class="header_left left">
	    	<p style="padding-bottom:5px;">今天是 <span id="date">2015年1月1日</span></p>
	    	<p id="time"> 星期日  0:00:00</p>
	    </div>
	    <div class="header_right"><img src="/skins/lottery/images/logo_logo.png" /><!-- <a href="javascript:logout()" class="out">退出</a> --></div>
	    <div class="clear"></div>
    </div>

	<div class="main">
		<div class="main_right" style="margin-left: 20px !important;margin-right: 20px;">
			<div class="content">
				<div class="main_right_title">
		        <div class="left">
		        	<form class="form" style="margin-left: 10px;"> 
				        <select name="lotteryId" id="lotteryId" class="select" style="background: none;">
								<c:forEach var="lottery" items="${list }">
									<option value="${lottery.id }">${lottery.title }</option>
								</c:forEach>
						</select>
				        <!-- <span class="select">测试</span> -->
				        <input class="" name="title" type="text" value="请输入身份证号码" id="keyword" />
				        <input value="查询" id="check" class="submit" type="button" />
				    </form>
		        </div>
		        <div class="right">
				     <a href="/lottery/login/index.action" class="a1">返回</a>
		        </div>
		        <div class="clear"></div>
		        </div>
		        
		        <table class="table" width="100%"  cellspacing="0" cellpadding="0" >
		          <tr class="border">
		            <td height="44">姓名</td>
		            <td height="44">性别</td>
		            <td height="44">出生年月日</td>
		            <td height="44">毕业小学</td>
		            <td height="44">身份证号码</td>
		            <td height="44">小升初报名编码</td>
		            <td height="44">广州市学籍号</td>
		            <td height="44">联系电话</td>
		            <td height="44">状态</td>
		          </tr>
		          <tbody id="tableBody">
		          </tbody>
		        </table>
		        
			</div>
		</div>
	</div>

<script type="text/javascript">
		
		$('#check').click(function(){
			var IDCard = $('#keyword').val();
			if(IDCard == '请输入身份证号码'){
				alert("请先输入身份证号码查询");
				return;
			}
			var lotteryId = $('#lotteryId').val();
			$.post('/lottery/student/check.action',{IDCard:IDCard,lotteryId:lotteryId},function(data){
				var json = JSON.parse(data);
				if('succeed' == json.code){
					var student = json.student;
					if(student){
						var html = '';
						html = '<tr >'+
						'	<td height="44">'+ student.name + '</td>'+
						'	<td height="44">'+student.gender+'</td>'+
						'	<td height="44">'+student.birthday+'</td>'+
						'	<td height="44">'+student.school+'</td>'+
						'	<td height="44">'+student.IDCard+'</td>'+
						'	<td height="44">'+student.stuNo+'</td>'+
						'	<td height="44">'+student.stuCode+'</td>'+
						'	<td height="44">'+student.phone+'</td>'+
						'	<td class="status" value="' + (student.status?1:0) + '" height="44" style="color: red;">'+(student.status==1?"已选中":"未选中")+'</td>';
						$('#tableBody').html(html); 
					}else{
						$('#tableBody').html(''); 
						alert("该身份证号码暂未添加到本次摇号中");
					}
				}
			});
		});
		
		$('.input_d_t').click(function(){
			$(this).prev('input').focus();
		});
		
		$('input').each(function(i){
			if($(this).attr('type') == 'text'){
				$(this).focus(function(){
					if($(this).val() == '请输入身份证号码'){
						$(this).val('');
					}
				});
				$(this).blur(function(){
					if($(this).val().trim() == ''){
						$(this).val('请输入身份证号码');
					}
				});
			}
		});
		
		var weeks = ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'];
		
		function task(){
			var time = new Date();
			var year = time.getFullYear();
			var month = time.getMonth() + 1;
			var date = time.getDate();
			
			var weekDay = time.getDay();
			var hour = time.getHours();
			var minute = time.getMinutes();
			var second = time.getSeconds();
			
			if(minute < 10){
				minute = "0" + minute;
			}
			if(second < 10){
				second = "0" + second;
			}
			
			var dateStr = year + '年' + month + '月' + date + '日';
			var timeStr = weeks[weekDay] + ' ' + hour + ':' + minute + ':' + second;
			
			$('#date').html(dateStr);
			$('#time').html(timeStr);
		}
		window.setInterval("task()", 1000); 
		
	</script>
</body>
</html>