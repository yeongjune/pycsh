<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/base/util.js"></script>
        <script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<script type="text/javascript">

var pa={
		n:"",
		p:""
};

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


function toLogin(url){
	lockWindow();
	var _url="";
	if(url!=null&&url!=""){
		_url="/weixinUser/toLoginByMini.action?url="+url;
	}else{
		_url="/weixinUser/toLoginByMini.action";
	}
	console.log(_url);
	art.dialog.open(_url,{
		top:'15%',
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
		top:'15%',
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
				pa.n=e.loginName;
				pa.p=e.password;
				//userName=e.name.substring(0,e.name.length-1)+"*";
			}
			$("#loginSpan").hide();
			$("#userSpan").show();
			$("#userName").html(userName);
		}
		
	},"json");
}

function toUserInfo(){
		location.href="/go-userInfo.html";
}

function logout(){
	
	$.post("/weixinUser/logout.action",{},function(e){
		if(e){
					location.reload();
		}
	},"text");
}
</script>
 <div class="header">
            <div class="wrap">
                <div class="header_top">
                
                    <div class="h_left fll">欢迎来到番禺慈善会
                    <span id="userSpan" style="display: none;"><a href="javascript:void(0);" onclick="toUserInfo();" id="userName"></a>　
                    <a href="javascript:void(0);" onclick="logout();">退出</a>
                    </span>
                    <span id="loginSpan">
                    <a href="javascript:void(0);" onclick="toLogin();">请登录</a>
                    <a href="javascript:void(0);" onclick="toRegister();">[免费注册]</a></span>
                    </div>
                    
                    <div class="h_right flr"><b>已传递 <span id="donateCount">346548</span> 份爱心</b><b>已捐款 <span  id="sumMoney">985462</span> 元</b>
                    </div>
                
                    <div class="clear"></div>
                </div>
                <div class="header_bottom">
                    <h1 class="logo"><a href="/go-index.html"><img src="/template/${site.directory }/images/game/logo.png" alt="" /></a></h1>
                    <div class="nav">
                        <ul>
                        <li><a href="/go-game_index.html">首页</a></li>
                        
                      <c:forEach items="${大赛菜单.children}" var="item">
                      		<li 
                        	 <c:if test="${rfn:checkIsRelevant(item.id, columnId) == true
                            || rfn:checkIsRelevant(item.id, 文章内容.columnId) == true
                               || rfn:checkIsRelevant(item.id, 单网页.columnId) == true}">class="nav_li_hover"</c:if>
                        	><a href="${item.url}">${item.name }</a></li>
                        </c:forEach>
                      </ul>
                    </div>
                    <div class="clear"></div>	
                </div>
            </div>
        </div>
<!-- class="banner" -->
        <div >
            <ul>
         <c:forEach items="${大赛图片轮播}" var="item">
         	   <li>
         	                <img alt="" src="${item.imageList[0].path}" width="100%">
         	    </li>            	
            </c:forEach>
              </ul>
            <!-- 指示器 -->
                <%-- <ol>
                  <c:forEach items="${大赛图片轮播}" var="item" varStatus="status">
                    <li  <c:if test="${status.count==1}">class="o_l_hover"</c:if>>
                    </c:forEach>
           
                </ol>
             --%>
            
        </div>