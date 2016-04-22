<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"
	name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<link rel="stylesheet" type="text/css" href="/skins/wap/css/base.css" />
<link rel="stylesheet" type="text/css" href="/skins/wap/css/swiper.min.css"/>
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/base/util.js"></script>
<script type="text/javascript" src="/js/base/md5.min.js"></script>
<script src="/js/swiper.jquery.min.js"></script>
<title>爱心捐赠</title>
<script type="text/javascript">
	$(function() {
		getDonateSum();
		loadByPage('/activityFront/loadActList.action', {
			"type1" : $("#type1").val(),
			"name" : $("#name").val()
		}, loadList);
		//alert(document.body.clientWidth);
		loadIndexImg();
	});

	function getDonateSum() {
		$.post("/activityFront/loadRecordStatistics.action", {}, function(data) {
            var usercount = 0;
            $.each(data, function(i, item){
                usercount += parseInt(item.userCount || item.usercount);
            });
            $("#donateSum").html(usercount);
        }, "json");
	}

	function loadList(list) {
		
		$("#idsDiv").html("");
		//$('#tableBody').html("");
		for ( var item in list) {
			var poj = list[item];
			var html = "";
			var statusStr = "";
			if (poj.status == 3) {
				statusStr = "进行中";
			}
			html = "";
			html += '<li onclick="toView(' + poj.id + ');">';
			html += '<div class="i_l_img" style="width:90px;overflow: hidden;"><a href="/go-activity_view_wap.html?id='
					+ poj.id
					+ '"><img style="margin-left : -15px;" onerror="this.src=\'/skins/images/projectSmall.jpg\';"  src="'+poj.smallPicUrl+'" width="120"></a></div>';
			html += '<div class="i_l_text">';
			html += '<div class="i_l_t_t"><a href="/go-activity_view_wap.html?id='
					+ poj.id + '">' + poj.name + '</a></div>';
			html += '<div class="" style="text-overflow: ellipsis;overflow: hidden;height:40px;">'
					+ poj.introduce + '</div>';
			html += '<div class="i_l_h">';
			html += '已有 <font class="orange" id="pojCount'+poj.id+'">0</font> 人参与 ';
			html += '</div>';
			html += '</div>';
			html += '<div class="clear"></div>';
			html += '</li>';

			$('#tableBody').append(html);
			html = "<input type='hidden' name='ids' value='"+poj.id+"'/>";
			$("#idsDiv").append(html);
		}
		loadRecord();
		if ($("#pageBtn").html() != "" && params_cache.params != null
				&& params_cache.params.currentPage != params_cache.totalPage) {
			$("#nextBtn").show();
		} else {
			$("#nextBtn").hide();
		}

	}

	function loadRecord() {
		$.post("/activityFront/loadRecordStatistics.action", $("#recordForm")
				.serialize(), function(data) {
            $.each(data, function(i, item){
                $("#pojMoney" + item.actId).html(item.money);
                $("#pojCount" + item.actId).html(item.userCount || item.usercount);
            });
		}, "json");
	}

	function toView(id) {
		window.location.href = "/go-activity_view_wap.html?id=" + id;
	}
	
	function loadIndexImg(){
		$.post("/wxUser/loadIndex.action",{},function(e){
			for(var i=0;i<e.length;i++){
				
				$("#indexImgDiv").append('<div class="swiper-slide"><img width="100%" src="'+e[i].smallPicOriginalUrl+'" /></div>');
			}
			
			var swiper = new Swiper('.swiper-container', {
				pagination: '.swiper-pagination',
				paginationClickable: true,
				nextButton: '.swiper-button-next',
				prevButton: '.swiper-button-prev'
			});
		},"json");
		
		
	}
</script>
</head>

<body class="bj">
	<div class="box ">
		<div class="i_t left">
			<font class="orange" id="donateSum">0</font> 份爱心
		</div>
		<div class="my">
			<a href="toMyDonate.action"><img src="/skins/wap/images/cs-1.png"
				width="34" /></a>
		</div>
	<div class="clear"></div>
	<div class="swiper-container">
		<div class="swiper-wrapper" id="indexImgDiv">
			

		</div>
		<!-- Add Pagination -->
		<div class="swiper-pagination"></div>
		<!-- Add Navigation -->
	</div>

		
		
		<div id="recordDiv">
			<div class="i_list">
				<ul id="tableBody">

				</ul>
			</div>
			<a href="javascript:void(0);" onclick="nextPage();" id="nextBtn"
				class="block"
				style="display: none; height: 50px; width: 100%; text-align: center; line-height: 50px; font-size: 16px; margin-left: 0px;">加载更多</a>

			<div style="display: none;" class="table_under_btn">
				<div class="flip" id="pageBtn"></div>
			</div>
		</div>
	</div>
	<!--box-->
	<form id="recordForm" method="post">
		<div id="idsDiv" style="display: none;"></div>
	</form>
</body>

</html>