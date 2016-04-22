<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<link rel="shortcut icon" type="image/x-icon" href="/template/${site.directory }/images/title.ico"/>
<link rel="shortcut icon" type="image/x-icon" href="images/iliubang.ico"/>
<title>活动页面</title>
<link rel="stylesheet" type="text/css" href="/skins/wap/css/base.css" />
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/base/util.js"></script>
<style type="text/css">

.download_msg2{width:100%; border-top: 1px solid #dedede;position: fixed; bottom: 0px;cursor: pointer;text-align:center;padding:5px 0px;}
.m_o_tr{ font-size:16px; color:#000; line-height:20px; padding:8px 5px 8px 10px; text-align: right;float: right;}
.m_o_tl{ font-size:16px; color:#000; line-height:20px; padding:8px 5px 8px 10px; text-align: left;float: left;margin-right: 20px;}
</style>
<script type="text/javascript">
	
	var projectName="";
$(function(){
	
	loadByPage('/activityFront/loadRecordList.action',{"id":"${id}"},loadList);
	
	$.post("/activityFront/getActInfo.action",{"id":"${id}"},function(e){
		projectName=e.name;
        $('#projectName').html(projectName);
		$("#projectContents").html(e.contents);
		$("#projectImg").attr("src",e.smallPicOriginalUrl);
		$(".m_o_text").find("img").css("max-width","100%");
		
	},"json");
	
	
	loadRecord();
});
	
	function loadList(list){

		for(var item in list){
			var record = list[item];
			var html="";
			var userName = record.name;
			html+='<div class="m_o_text">';
			html+='<div class="m_j_c">'+userName+'</div><div class="m_j_c center"><font class="orange">￥ '+record.money+'</font>元</div><div class="m_j_c right_t">'+record.createTimeFormat+'</div>';
			html+='<div class="clear"></div>';
			html+='</div>';
			$('#tableBody').append(html);
		}
		if($("#pageBtn").html()!=""&&params_cache.params!=null&&params_cache.params.currentPage!=params_cache.totalPage){
			$("#nextBtn").show();
		}else{
			$("#nextBtn").hide();
		}
	}
	function loadRecord(){
		$.post("/activityFront/loadRecordStatistics.action",{"ids":"${id}"},function(e){

			for(var item in e){
				var tmp=e[item];
				$("#pojMoney").html(tmp.money);
				$("#pojCount").html(tmp.userCount);
			}
			
		},"json");
		
	}

	function onlyNum() {
	    if(!(event.keyCode==46)&&!(event.keyCode==8)&&!(event.keyCode==37)&&!(event.keyCode==39))
	    if(!((event.keyCode>=48&&event.keyCode<=57)||(event.keyCode>=96&&event.keyCode<=105)))
	    event.returnValue=false;
	}

	function checkDon(){
		if($('#xyCheck').attr('checked')=="checked"||$('#xyCheck').attr('checked')==true){
			$('#xyCheck').attr('checked',false);
		}else{
			$('#xyCheck').attr('checked',true);
		}
	}
	
</script>

</head>
<body class="bj">
	<div class="box" style="margin-bottom: 60px;" id="viewDiv">
        <div class="i_b"><img onerror="this.src='/skins/images/projectSmall.jpg';" src="" id="projectImg" width="100%"></div>
        <div class="j_nav">
        	<div class="j_t"><font class="left" id="projectName"></font><div class="clear"></div></div>
            <div class="line"></div>
        	<a>已筹 <font class="orange">￥<span id="pojMoney">0</span></font> 元</a><a style=" border:0;">参与人数 <font class="orange"><span id="pojCount">0</span></font> 人</a>
        </div>
        
        <div class="m_one">
            <div class="m_o_t">活动详情</div>
            <div class="m_o_text" id="projectContents">
            	
            </div>
            <div class="line" style=" margin-top:10px;" ></div>
            <div class="m_o_t">参与列表</div>
            <div id="tableBody">
            </div>
            <a href="javascript:void(0);" onclick="nextPage();" id="nextBtn" class="block" style="display: none;height: 50px;width: 100%;text-align:center;line-height:50px;font-size: 16px;margin-left: 0px;">加载更多</a>
	
        </div>
        
    </div><!--box-->
<div class="download_msg" id="donateBtn">
	<div class="j_btn" style=" margin:0 auto"><a href="/go-activity_donate_wap.html?id=${id}">我要报名</a></div>
</div>

</body>

</html>