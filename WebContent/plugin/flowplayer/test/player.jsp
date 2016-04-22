<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>简单播放器1-播放单个</title>

<!-- 引入皮肤 -->
<link rel="stylesheet" href="/plugin/flowplayer/skin/minimalist.css" />
<style type="text/css">
.flowplayer ,.player,#player,.myplaer{
	width:500px;
	height: 300px;
	float: left;
	margin: 10px;
}
#player{
	background: url(/plugin/flowplayer/test/test.jpg) no-repeat;
	background-size:100%; 
}
</style>
<!-- 引入jquery库 -->
<script type="text/javascript" src="/plugin/flowplayer/jquery.js"></script>
<!-- 引入flowplayer -->
<script type="text/javascript" src="/plugin/flowplayer/flowplayer.min.js"></script>
<script type="text/javascript">
//全局配置
flowplayer.conf = {
		ratio:3/4,
		swf:"/plugin/flowplayer/flowplayer.swf",
		volume:0.5,
		engine:"flash"
}
//单个配置
flowplayer.conf.ratio=3/4;

$(function(){
	$(".player").flowplayer({swf:"/plugin/flowplayer/flowplayer.swf",poster:'/plugin/flowplayer/test/test.jpg',volume:0.3,engine:'flash'});
	
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
<!-- 播放例子1:需要使用flowplayer样式，通过data-swf指定swf -->
<div class="flowplayer" data-swf="/plugin/flowplayer/flowplayer.swf" data-ratio="0.4167" data-engine="flash">
	<video poster="/plugin/flowplayer/test/test.jpg" autoplay="autoplay" loop="loop" >
		<source type="video/mp4" src="/plugin/flowplayer/test/test.mp4"></source>
	</video>
</div>
<!-- 播放例子2：需要使用player样式，通过js制定swf -->
<div class="player"  data-ratio="0.4167">
	<video preload="auto">
		<source type="video/mp4" src="/plugin/flowplayer/test/test.mp4"></source>
	</video>
</div>
<!-- 播发例子三：播放列表，需要指定ID -->
<div id="player"></div>
</body>
</html>