<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>进入摇号</title>
<link rel="stylesheet" type="text/css" href="/skins/lottery/css/base.css" />
<link rel="stylesheet" type="text/css" href="/skins/lottery/css/layout.css" />

<!-- jquery 支持-->
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>

<script type="text/javascript" src="/plugin/jquery.cookie.js"></script>
<script type="text/javascript" src="/js/base/md5.min.js"></script>
<!-- 弹出框引入 -->
<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>

<script type="text/javascript" src="/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript" src="/js/base/util.js"></script>
<script type="text/javascript" src="/js/base/PagedQuery.js"></script>
</head>
<body>

	<!-- 头部 -->
	<c:import url="../common/head.jsp" />
	
    <!--主体main开始-->
    <div class="main">
        <!--主体main的右侧菜单开始-->
        <div class="main_left">
        <div class="ul_li1"><a href="/lottery/student/index.action" >参加学生</a></div>
        <div class="ul_li2"><a href="/lottery/student/index.action">学生管理</a></div>
        <div class="ul_li3"><a href="/lottery/lotterys.action" >摇号选项</a></div>
        <div class="ul_li4"><a href="/lottery/lotterys.action">摇号管理</a></div>
        <div class="ul_li5"><a href="/lottery/index.action" class="hover">进入摇号</a></div>
        <div class="ul_li6"><a href="/lottery/student/result1.action">摇号结果</a></div>
        <div class="ul_li7"><a href="/lottery/student/result1.action">摇中名单</a></div>
        <div class="ul_li8"><a href="/lottery/student/result2.action">候补名单</a></div>
        <!-- <div class="ul_li8"><a href="/lottery/student/result3.action">未中名单</a></div> -->
    </div>
        <!--主体main的右侧菜单结束-->
 
        <!--主体main的左侧可更换内容开始-->
        <div class="main_right">
        <div class="content">
		<div class="content_c">
			<form class="form"> 
		        <div class="left" style="line-height:24px;">当前摇号：</div><!-- <span class="select">测试</span> -->
		        <select name="lotteryId" id="lotteryId" class="select" style="width: 235px;">
						<c:forEach var="lottery" items="${list }">
							<option value="${lottery.id }" >${lottery.title }</option>
						</c:forEach>
				</select>
		    </form>
		</div>
        <div class="nr">
        <a href="javascript:lotteryManager.processLottery()" id="lottery_btn"><img src="/skins/lottery/images/yaohao.jpg" /></a>
        <p id="tip"></p>
        </div>
        </div>
      </div>
        <!--主体main的左侧可更换内容结束-->
        <div class="clear"></div>
    </div>
    <!--主体main结束-->


<script type="text/javascript">
var lotteryManager;
$(function(){
	lotteryManager = new lotteryManager();
	lotteryManager.load();
	
	$("#chk_ids").click(function(){
		if($(this).attr("checked")){
			$("input[name='chk_lottery_id']").attr('checked',true);
		}else{
			$("input[name='chk_lottery_id']").attr('checked',false);
		}
	});
	
	$('#lotteryId').change(function(){
		
		lotteryManager.load();
	});
	
});

function lotteryManager(){
	var isFull = false;//是否已经摇到需要的人数，摇到将不能再进行摇号
	var stuNum = 0;//该摇号已经添加的学生
	var flag = true;//是否能够摇号的标志
	var step = 0;
	this.load = function(){
		$.post('/lottery/load.action',{id:$('#lotteryId').val()},function(data){
			var json = data;
			if('succeed' == json.code){
				var lottery = json.lottery;
				step = lottery.step;
				stuNum = lottery.stuNum; 
				if(lottery.number == null || lottery.number > lottery.selected){
					flag = false;
				}
				/* var tip = '当前摇号总共需要选出' + lottery.number + '名学生，总共摇号' + lottery.times + '次，已经摇号' + lottery.lotteryTimes +'次，选出了' + lottery.selected + '名学生';
				$('#tip').html(tip); */
				if(lottery.selected >= lottery.number){
					isFull = true;
				}else{
					isFull = false;
				}
			}
		}, 'JSON');
	};
	this.processLottery = function(){
		var lotteryId = $('#lotteryId').val();
		if(!lotteryId){
			art.dialog.alert("您尚未创建摇号，请新建摇号并添加学生再进行摇号！");
			return;
		}
		if(stuNum == 0){
			art.dialog.alert("该摇号暂未添加学生，不能进行摇号，请先添加学生再试！");
			return;
		}
		if(isFull){
			art.dialog.confirm("摇号已完成，是否查看结果？", function(){
				window.location.href =  '/lottery/student/result1.action?id='+$('#lotteryId').val();
			});
			return;
		}
		/* if(step != null && step > 0){
			var tip = "该摇号已经进行到第" + (step + 1) + "步，是否跳转到指定页面？";
			if(step > 2){
				tip = "该摇号已完成，是否跳转到查看页面？";
			}
			art.dialog.confirm(tip, function(){
				window.location.href =  '/lottery/toList.action?id='+$('#lotteryId').val();
			});
			return;
		} */
		//lockWindow();
		this.lotterying();
		$.post('/lottery/processLottery.action',{lotteryId:$('#lotteryId').val()},function(data){
			var json = data;
			if('succeed' == json.code){
				var timer=setTimeout(function(){openLock();window.location.href = '/lottery/student/result1.action?id='+$('#lotteryId').val();},15000);
				/* art.dialog.confirm('摇号选中了' + json.num + '人，确定跳转到查看摇号结果页面吗？', function(){
					window.location.href = '/lottery/student/result1.action';//跳转到摇号结果页面
				},function(){
					lotteryManager.load();
				}); */
			}else{
				openLock();
				art.dialog.alert(json.msg);
			}
		}, 'JSON');
	};
	this.deleteLottery = function(id){
		art.dialog.confirm("确定删除吗？", function(){
			$.post('/lottery/delete.action',{ids:id},function(data){
				if(data=='succeed'){
					lotteryManager.load();
				}else{
					art.dialog.alert('操作失败');
				}
			});
		});
	};
	this.deleteMutilLottery = function(){
		var ids=[];
		$("input[type='checkbox'][name='chk_lottery_id']:checked").each(function(){
			ids.push($(this).val());
		});
		
		if (!ids||ids.length==0) {
			art.dialog.alert("您尚未选中任何要删除的摇号！");
			return;
		}

		art.dialog.confirm("您确定要批量删除已选中的摇号吗？", function(){
			$.post('/lottery/delete.action',{ids:ids.join(',')},function(data){
				if(data=='succeed'){
					lotteryManager.load();
				}else{
					art.dialog.alert('操作失败');
				}
			});
		});
	};
	this.editLottery = function(id){
		art.dialog.open('/lottery/toEdit.action?id='+id, {
			width: '50%',
			height: '50%',
			title:'修改'
		});
	};
	this.toViewLottery = function(id){
		art.dialog.open('/lottery/toView.action?id='+id, {
			width: '100%',
			height: '100%',
			title:'查看'
		});
	};
	
	/**
	 * 异步操作时锁屏（需要主动调用）
	 */
	this.lotterying = function(){
		if(isLoading){
			
		}else{
			isLoading = true;
			$('body').append(
					'<div id="lockWindow" style="background: gray; opacity: 0.2; filter:alpha(opacity=20); width: 100%; height: 100%; z-index: 200; position:fixed; _position:absolute; top:0; left:0;">'+
					'</div>'+
					'<div id="lockContent" style="left:35%; margin-left:-20px; top:35%; margin-top:-20px; position:fixed; _position:absolute; height: "+h+"px; width: "+w+"px; z-index: 2101; overflow: hidden;">'+
					'	<div class="nodata"><img src="/skins/lottery/images/lottery.gif"></img></div>'+
					'</div>'
			);
		}
	}
	
}

</script>
</body>
</html>