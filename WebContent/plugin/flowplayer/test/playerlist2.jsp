<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>flowplayer播放列表2+通过js控制</title>
<!-- 引入皮肤 -->
<link rel="stylesheet" href="/plugin/flowplayer/skin/minimalist.css" />
<link rel="stylesheet" href="/plugin/flowplayer/skin/list.css" />
<style>
body {
   font-family: "myriad pro", tahoma, verdana, arial, sans-serif;
   font-size: 14px;
   margin: 0;
   padding: 0;
}
#content {
   margin: 50px auto;
   max-width: 982px;
}
</style>
<!-- 引入jquery库 -->
<script type="text/javascript" src="/plugin/flowplayer/jquery.js"></script>
<!-- 引入flowplayer -->
<script type="text/javascript" src="/plugin/flowplayer/flowplayer.min.js"></script>
<script type="text/javascript">
var allVideos = [
   [
      //{webm: "http://stream.flowplayer.org/night7/640x360.webm"},
      //{ogg: "http://stream.flowplayer.org/night7/640x360.ogv"},
      {mp4: "/plugin/flowplayer/test/test.mp4"},
      {flash: "/plugin/flowplayer/test/test.mp4"}
   ],
   [
    {mp4: "/plugin/flowplayer/test/test.mp4"},
    {flash: "/plugin/flowplayer/test/test.mp4"}
   ],
   [
    {mp4: "/plugin/flowplayer/test/test.mp4"},
    {flash: "/plugin/flowplayer/test/test.mp4"}
   ],
   [
    {mp4: "/plugin/flowplayer/test/test.mp4"},
    {flash: "/plugin/flowplayer/test/test.mp4"}
   ]
];
$(function(){
	$("#jsplaylist").flowplayer({
		   //rtmp: "rtmp://s3b78u0kbtx79q.cloudfront.net/cfx/st",
		   playlist: allVideos,
		   swf:"/plugin/flowplayer/flowplayer.swf"
	});
});

</script>
</head>
<body>
<div id="content">
	<div id="jsplaylist">
	</div>
</div>
</body>
</html>