<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>flowplayer播放列表1+使用标签控制</title>
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
<script>
//该例子不需要js控制，可以将以下测试的js去掉  
// listen to playlist events
function log() {
   /* $("#event-info").css("opacity", 1).append("<p>" + [].slice.call(arguments).join(", ") + "</p>"); */
}

flowplayer(function(api, root) {

   if (!root.is("#basic-playlist")) return;

   api.bind("load", function(e, api, video) {
      log("clip " + video.index, "is_last: " + video.is_last);

   }).bind("cuepoint", function(e, api, cuepoint) {
      log("clip " + api.video.index, "cuepoint " + cuepoint.time);
   });

});

</script>
</head>
<body>
<div id="content">
	<div id="basic-playlist" data-swf="/plugin/flowplayer/flowplayer.swf" class="flowplayer is-splash is-closeable" data-ratio="0.5625">
	
	   <video>
		   <!-- <source type="video/webm" src="http://stream.flowplayer.org/night3/640x360.webm">
		   <source type="video/mp4" src="http://stream.flowplayer.org/night3/640x360.mp4">
		   <source type="video/ogg" src="http://stream.flowplayer.org/night3/640x360.ogv"> -->
		   <source type="video/mp4" src="/plugin/flowplayer/test/test.mp4"></source>
	   </video>
	
	   <a class="fp-prev"></a>
	   <a class="fp-next"></a>
	
	   <div class="fp-playlist">
	      <!-- <a class="item1" href="http://stream.flowplayer.org/night3/640x360.mp4" data-cuepoints="[0.5, 1]"></a>
	      <a class="item2" href="http://stream.flowplayer.org/night1/640x360.mp4" data-cuepoints="[0.9, 1.5]"></a>
	      <a class="item3" href="http://stream.flowplayer.org/night5/640x360.mp4"></a>
	      <a class="item4" href="http://stream.flowplayer.org/night6/640x360.mp4"></a> -->
	      
	      <a class="item1" href="/plugin/flowplayer/test/test.mp4" ></a>
	      <a class="item2" href="/plugin/flowplayer/test/test.mp4"></a>
	      <a class="item3" href="/plugin/flowplayer/test/test.mp4" ></a>
	      <a class="item4" href="/plugin/flowplayer/test/test.mp4"></a>
	   </div>
		<!-- <div id="event-info" ></div> -->
	</div>
</div>
</body>
</html>