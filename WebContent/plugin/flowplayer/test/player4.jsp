<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>VideoJS播放单个视频+标签控制(可以提取ueditor里的组件videoJs插件出来用同时调用flowplayer.swf,兼容性IE9+)</title>
  <script type="text/javascript" src="/plugin/flowplayer/jquery.js"></script>
  <!-- 加载 VideoJS js -->
  <script src="/plugin/ueditor_1.4.3/third-party/video-js/video-js.min.css" type="text/javascript" charset="utf-8"></script>
  <!-- 皮肤 -->
  <link rel="stylesheet" href="/plugin/ueditor_1.4.3/third-party/video-js/video-js.css" type="text/css" media="screen" title="Video JS">
  <script type="text/javascript">
  $(function(){
		// 这段代码必须放在video.js后面
	    // 页面加载完成  才加载VideoJS的标签
	    VideoJS.setupAllWhenReady();
  });
  </script>
</head>
<body>
 <!-- Begin VideoJS -->
  <div class="video-js-box" style="margin:20px auto">
    
    <video id="example_video_1" class="video-js" width="640" height="264" controls="controls" preload="auto" poster="/plugin/flowplayer/test/test.jpg">
      <source src="/plugin/flowplayer/test/test.mp4" type='video/mp4; codecs="avc1.42E01E, mp4a.40.2"' />
      <!-- <source src="http://video-js.zencoder.com/oceans-clip.webm" type='video/webm; codecs="vp8, vorbis"' />
      <source src="http://video-js.zencoder.com/oceans-clip.ogv" type='video/ogg; codecs="theora, vorbis"' /> -->
      <!-- 如果浏览器不兼容HTML5则使用flash播放 -->
      <object id="flash_fallback_1" class="vjs-flash-fallback" width="640" height="264" type="application/x-shockwave-flash"
        data="/plugin/flowplayer/flowplayer.swf">
        <param name="movie" value="/plugin/flowplayer/flowplayer.swf" />
        <param name="allowfullscreen" value="true" />
        <param name="flashvars" value='config={"playlist":["/plugin/flowplayer/test/test.jpgg", {"url": "/plugin/flowplayer/test/test.mp4","autoPlay":false,"autoBuffering":true}]}' />
        <!-- 视频图片. -->
        <img src="/plugin/flowplayer/test/test.jpg" width="640" height="264" alt="Poster Image"
          title="No video playback capabilities." />
      </object>
     </video>   
  </div>
  <!-- End VideoJS -->
</body>
</html>