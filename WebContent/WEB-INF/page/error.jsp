<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>错误消息</title>
<style>
/**清除内外边距**/
*{margin: 0; padding: 0;}
body { text-align: center; font-family: "宋体"; margin: 0;  padding: 0; background: #e1e1e1; font-size: 12px; color: #666;}
div, form, img, ul, ol, li, dl, dt, dd, th, td, p, img, button,   { margin: 0; padding: 0; border: 0; }

.box{ width: 1002px; height: 633px; text-align: left; margin: 0 auto; position: absolute; left: 50%; top: 50%;
	 margin: -316px 0 0 -501px;background: url(/skins/blue/images/404.jpg) no-repeat;   }

.a_div{ padding:346px 0 0 400px; text-align: left}
.a_div a{ font-size: 14px; color: #1373b0; text-decoration: none}
.a_div a:hover{ text-decoration: underline;}
.e_div{
margin-top: 150px;
}

</style>
</head>

<body>
<div class="box">
	<div class="a_div"><a href="/">返回首页</a></div>
	<div class="e_div">
		<p>${error }</p>
		<p>${statck }
		</p>
	</div>
	
</div>

</body>
</html>
