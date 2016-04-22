<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
    <link rel="shortcut icon" type="image/x-icon" href="/template/${site.directory }/images/title.ico"/>
<link rel="stylesheet" type="text/css" href="/skins/wap/css/base.css" />
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/base/util.js"></script>
<script type="text/javascript">
$(function(){
	if("${id}"=="13200"){
		$("title").html("联系我们");
	}
	if("${id}"=="13216"){
		$("title").html("番禺慈善会公益用户协议");
		$("#title").remove();
	}
	
	
	$.post("/wxUser/loadNews.action",{"id":"${id}"},function(e){
		
		$("#title").html(e.title);
		
		$("#time").html(e.createTime);
		$("#content").html(e.content);
		$("#img").attr("src",e.smallPicOriginalUrl);
		$(".m_o_text").find("span").css("font-size","14px");
		$(".m_o_text").find("img").css("max-width","100%");
		
	},"json");
	
	
});


</script>
<title>资讯中心</title>
</head>

<body class="bj">
	<div class="box ">
		
        <div class="m_one">
        	<div class="m_o_t" id="title"></div>
             <div class="x_o_text">番禺区慈善会　<span id="time"></span></div>
        	<%-- <div class="m_o_img"><img src="/skins/wap/images/m_img.jpg" ></div> --%>
            <div class="m_o_text" id="content" style="font-size: 12px;">
            	
            </div>
            <div class="m_o_img"><img src="" id="img" width="100%"></div>
        </div>
        
    </div><!--box-->

</body>
</html>
