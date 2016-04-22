<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>flowplayer播放单个视频-使用标签控制</title>

<!-- 引入皮肤 -->
<link rel="stylesheet" href="/plugin/flowplayer/skin/minimalist.css" />
<style type="text/css">
.flowplayer{width:500px;height: 300px;float: left;margin: 10px;}
</style>
<!-- 引入jquery库 -->
<script type="text/javascript" src="/plugin/flowplayer/jquery.js"></script>
<!-- 引入flowplayer -->
<script type="text/javascript" src="/plugin/flowplayer/flowplayer.min.js"></script>
</head>
<body>
<!-- 播放例子1:需要使用flowplayer样式，通过data-swf指定swf -->
<div class="flowplayer" data-swf="/plugin/flowplayer/flowplayer.swf" data-ratio="0.4167" data-engine="flash">
	<video poster="/plugin/flowplayer/test/test.jpg" autoplay="autoplay" loop="loop" >
		<source type="video/mp4" src="/plugin/flowplayer/test/test.mp4"></source>
	</video>
</div>
</body>
</html>