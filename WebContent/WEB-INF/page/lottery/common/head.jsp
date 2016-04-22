<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>头部</title>
<link rel="stylesheet" type="text/css" href="/skins/lottery/css/base.css" />
<link rel="stylesheet" type="text/css" href="/skins/lottery/css/layout.css" />

<!-- jquery 支持-->
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>

<script type="text/javascript" src="/plugin/jquery.cookie.js"></script>
<script type="text/javascript" src="/js/base/md5.min.js"></script>
<!-- 弹出框引入 -->
<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>

<script type="text/javascript" src="/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript" src="/js/base/util.js"></script>
<script type="text/javascript" src="/js/base/PagedQuery.js"></script>
</head>
<body>
 <!--头部header开始-->
    <div class="header">
    <div class="header_left left">
    	<p style="padding-bottom:5px;">今天是 <span id="date">2015年1月1日</span></p>
    	<p id="time"> 星期日 0:00:00</p>
    </div>
    <div class="header_right"><img src="/skins/lottery/images/logo_logo.png"  style="width: 75%;"/><a href="javascript:logout()" class="out">退出</a></div>
    <div class="clear"></div>
    </div>
	<script type="text/javascript">
		
		function logout(){
			$.post('/login/logout.action',function(data){
				if('succeed' == data){
					window.location.href = '/lottery/login/index.action';
				}
			});
		}
		
		
		
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
		
		/* var timmerID = null; 
		function time() { 
		var time = document.getElementById("now"); 
		var left = document.getElementById("left"); 
		var t = time.value.split(":"); 
		var hour = parseInt(t[0]); 
		var min = parseInt(t[1]); 
		min=min+1; 
		if(min==60){ 
		hour=hour+1; 
		min=0; 
		if(hour==24){ 
		hour=0; 
		} 
		} 
		time.value=hour+":"+min; 
		left.value = left.value-1; 
		if(left.value==0){ 
		mystop(); 
		alert("时间已到！"); 
		} 

		} 
		function mystart() { 
		var left = document.getElementById("left"); 
		left.value="40"; 
		timmerID = window.setInterval("time()", 1000*60); 
		} 
		function mystop() { 
		window.clearInterval(timmerID); 
		}  */
		
	</script>
</body>
</html>