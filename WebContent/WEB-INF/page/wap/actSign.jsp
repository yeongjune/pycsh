<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"
	name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<title>广州市番禺区慈善会</title>
<link href="/skins/wap/css/cishan.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/base/util.js"></script>
<script type="text/javascript">

function saveSign(){

	var name = $("#name").val();
	if(name!=""){
		$.post('/activityFront/saveActivitySign.action',{"actId":"${actId}","name":name},function(e){
			
			if(e=="notOpenId"){
				alert("微信授权失败!");
			}else if(e=="notName"){
				alert("请填写您的姓名!");
			}else{
				window.location.href="/activityFront/toViewSign.action?id="+e;
			}

		},"text");
	}else{
		alert("请填写您的姓名!");
	}
				
			
}
</script>
</head>


<body >
<div class="box">
<img src="/skins/wap/images/dj.jpg" width="100%" >
<div class="dj_po">
	<div class="x_ti">为保护未成年人项目募集善款</div>
    <div class="x_gx">
    	<span>恭喜您!</span><br>完成慈善健康行
    </div>
  
    <div class="x_name">请输入您的名字</div>
    <div class="x_input">
   	  <img src="/skins/wap/images/dj_03.png" width="90%" >
    <input type="text" value="" size="22" maxlength="10" id="name"></div>
    <div class="x_btn"><a href="javascript:void(0);" onclick="saveSign();">确定</a></div>
</div>


</div>

</body>


</html>