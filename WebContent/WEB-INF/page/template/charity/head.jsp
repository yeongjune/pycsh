<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
$(function(){
	getUserInfo();
	$.post("/donateFront/getDonateSum.action",{},function(e){
		$("#donateCount").html(e.donateCount);
		$("#sumMoney").html(e.sumMoney);
		
	},"json");
	
	$(".weixin").hover(function(){
		$(".po_weixin").show();
	},function(){
		$(".po_weixin").hide();
	});
});


function toLogin(){
	lockWindow();
	art.dialog.open('/weixinUser/toLoginByMini.action',{
		title:"登录",
		width:'auto',
		height:'auto',
		close:function(){
			getUserInfo();
			openLock();
		}
	});
}


function toRegister(){
	lockWindow();
	art.dialog.open('/weixinUser/toRegister.action',{
		title:"注册",
		width:'auto',
		height:'auto',
		close:function(){
			getUserInfo();
			openLock();
		}
	});
}

function getUserInfo(){
	$.post("/projectFront/getSessionUserInfo.action",{},function(e){
		
		if(e!=null){
			
			var userName = "";
			if(e.name==null||e.name==""){
				userName=e.loginName;
				//userName=e.loginName.substring(0,4)+"*****"+e.loginName.substring(9,11);
			}else{
				userName=e.name;
				//userName=e.name.substring(0,e.name.length-1)+"*";
			}
			$("#loginSpan").hide();
			$("#userSpan").show();
			$("#userName").html(userName);
		}
		
	},"json");
}

function toUserInfo(){
	window.location.href="/go-userInfo.html";
}

function logout(){
	
	$.post("/weixinUser/logout.action",{},function(e){
		if(e){
					location.reload();
		}
	},"text");
	
}
</script>
<div class="po_b"><a href="javascript:void(0)" class="weixin"><i class="wcsm"></i><br>微信扫描</a><a href="#" ><i class="fhdb"></i><br>返回顶部</a></div>
<div class="po_weixin" style="display: none;"><img src="/template/${site.directory }/images/weixin.jpg" width="160px;" height="160px;"/></div>
<!--头部 开始-->
<div class="header">
<div class="header_box">
	<div class="welcome">
    	<div class="left">欢迎来到番禺区慈善会　<span id="userSpan" style="display: none;"><a href="javascript:void(0);" onclick="toUserInfo();" id="userName"></a>　[<a href="javascript:void(0);" onclick="logout();">退出</a>]</span><span id="loginSpan">请<a href="javascript:void(0);" onclick="toLogin();">登录</a>　[<a href="javascript:void(0);" onclick="toRegister();">免费注册</a>]</span></div>
        <div class="right">已传递 <font class="orange" id="donateCount">0</font> 份爱心　已捐款 <font class="orange" id="sumMoney">0</font> 元 </div>
    </div><!--welcome-->
    <div class="logo"><a href="/go-index.html"><img src="/template/${site.directory }/images/logo.jpg" width="426" height="77"></a></div>
    <!-- 菜单start -->
		<c:import url="/WEB-INF/page/template/${site.directory }/menu.jsp" />
    <!-- 菜单end -->
</div>
</div><!--header-->
<div class="clear"></div>
<!--头部 结束-->