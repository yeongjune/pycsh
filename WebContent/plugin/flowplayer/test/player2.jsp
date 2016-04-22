<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>flowplayer播放单个视频-使用js+标签样式控制</title>

<!-- 引入皮肤 -->
<link rel="stylesheet" href="/plugin/flowplayer/skin/minimalist.css" />
<style type="text/css">
.player{width:500px;height: 300px;float: left;margin: 10px;}
</style>
<!-- 引入jquery库 -->
<script type="text/javascript" src="/plugin/flowplayer/jquery.js"></script>
<!-- 引入flowplayer -->
<script type="text/javascript" src="/plugin/flowplayer/flowplayer.min.js"></script>
<script type="text/javascript">
$(function(){
	$(".player").flowplayer({swf:"/plugin/flowplayer/flowplayer.swf",poster:'/plugin/flowplayer/test/test.jpg',volume:0.3,ratio:3/4,engine:'flash'});
});
</script>
</head>
<body>
<!-- 播放例子2：需要使用player样式，通过js制定swf -->
<div class="player"  data-ratio="0.4167">
	<video preload="auto">
		<source type="video/mp4" src="/plugin/flowplayer/test/test.mp4"></source>
	</video>
</div>
</body>
</html>