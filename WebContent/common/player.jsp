<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 前提是引入jquery库，用includeplayer样式的标签包含 视频内容 --%>
<%-- 引入皮肤 --%>
<link rel="stylesheet" href="/plugin/flowplayer/skin/minimalist.css" />
<style type="text/css">
/*调用界面上可以重写指定高宽*/
.myPlayer{max-width: 90%;}
</style>
<%-- 引入flowplayer --%>
<script type="text/javascript" src="/plugin/flowplayer/flowplayer.min.js"></script>
<script type="text/javascript">
//全局配置
flowplayer.conf = {
		ratio:3/4,
		swf:"/plugin/flowplayer/flowplayer.swf",
		volume:0.5,
		engine:"flash"
}
$(function(){
	var i=0;
	var urls=[];
	$(".includeplayer embed").each(function(){
		var src=$(this).attr("src");
		var width=$(this).attr("width")?$(this).attr("width"):'500';
		var height=$(this).attr("height")?$(this).attr("height"):'300';
		var reg=new RegExp("((\.mp4)|(\.ogg)|(\.webm)|(\.flv)|(\.rmvb))$");
		if(reg.test(src)){
			urls.push({src:src,id:'player_'+i,width:width,height:height});					
			$(this).replaceWith('<div style="width:100%;"><div id="player_'+i+'" class="myPlayer" ></div><div>');
			i++;
		}
	});
	for(var j=0;j<urls.length;j++){
		$("#"+urls[j]['id']).flowplayer({
			playlist :[
		        [{mp4:urls[j]['src']},
		         {flash:urls[j]['src']},
		         {ogg:urls[j]['src']},
		         {webm:urls[j]['src']},
		         {flv:urls[j]['src']}
		         ]
	        ],
	        swf:"/plugin/flowplayer/flowplayer.swf",
	        engine:'flash',
	        volume:0.4,
	        width:urls[j]['width'],
	        height:urls[j]['height'],
	        tooltip:false
		});
	}
});
</script>