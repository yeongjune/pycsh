<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>flowplayer播放视频(单个/列表)-使用js+标签id控制</title>
<!-- 引入皮肤 -->
<link rel="stylesheet" href="/plugin/flowplayer/skin/minimalist.css" />
<style type="text/css">
#player{
	background: url(/plugin/flowplayer/test/test.jpg) no-repeat;
	background-size:100%; 
	width:500px;height: 300px;margin: 10px;
}
</style>
<!-- 引入jquery库 -->
<script type="text/javascript" src="/plugin/flowplayer/jquery.js"></script>
<!-- 引入flowplayer -->
<script type="text/javascript" src="/plugin/flowplayer/flowplayer.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#player").flowplayer({
		playlist :[
	        [{mp4:"/plugin/flowplayer/test/test.mp4"},{flash:"/plugin/flowplayer/test/test.mp4"}],
	        [{mp4:"/plugin/flowplayer/test/test.mp4"},{flash:"/plugin/flowplayer/test/test.mp4"}]
        ],
        ratio: 3/4,
        swf:"/plugin/flowplayer/flowplayer.swf",
        engine:'flash',
        volume:0.4,tooltip:false
	});
});
</script>
</head>
<body>
<!-- 播发例子三：播放列表，需要指定ID -->
<div id="player"></div>
</body>
</html>