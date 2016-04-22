<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta charset="utf-8" />
    <title>我的捐赠</title>
    <meta name="keywords" content="${site.name }" />
    <meta name="Description" content="${site.name }" />
	<link rel="shortcut icon" type="image/x-icon" href="/template/${site.directory }/images/title.ico"/>    
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/index.css" />
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/module.css" />
    <script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/template/${site.directory }/js/slide.js"></script>
	<script type="text/javascript" src="/js/base/util.js"></script>
	<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
	<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
	
	
$(function(){
	getUserInfo2();
	loadByPage('/projectFront/loadMyList.action',{},loadList);
	loadMySum();
});
	
	function loadList(list){
		$("#idsDiv").html("");

		for(var item in list){
			var poj = list[item];
			var html="";

			html+='<div class="my_n_box">';
			html+=' <div class="list_mode" style="width:410px;">';
            html+=' <dl class="l_l" style="width:410px;">';
                html+='   <dt><img src="'+poj.smallPicUrl+'" width="160" height="140"></dt>';
                    html+='   <dd style="width:230px;">';
                    html+=' 	<div class="title">';
                    	html+='        <div class="t_font overflow" style="max-width:160px; padding-top:20px;">'+poj.name+'</div>';
                            html+='       <div class="tip left" style=" margin-top:20px;">慈善项目</div>';
                            html+='  </div>';
                        html+='  <div class="clear"></div>';
                        html+=' 已有 <font class="orange_2" id="pojCount'+poj.id+'">0</font> 份爱心 ';
                        html+='             <div class="t_time">时间：'+poj.endTimeFormat+' 至 '+poj.endTimeFormat+'</div>';
                        html+='         </dd>';
                    html+='     </dl>';
                html+=' </div><!--list_mode-->';
            html+='  <div class="right_m">';
            html+='      <div class="one_m">共捐赠 <font class="orange">￥<span >'+poj.sumMoney+'</span></font> 元</div>';
                html+='      <div class="my_ro" onclick="showRecord('+poj.id+',this);"> 查看捐赠记录<i class="m_jk" id="recordI'+poj.id+'"></i></div>';
                html+=' </div>';
          html+=' <div class="clear"></div>';
          
          html+='  <div class="my_o_list" style="display: none;" id="recordDiv'+poj.id+'">';
          html+='   <ul id="recordTd'+poj.id+'">';
                
            html+='   </ul>';
            html+='</div><!--my_o_list-->';
        html+=' <div class="clear"></div>';
       html+='</div>';
			
			
			
			$('#tableBody').append(html);
			html="<input type='hidden' name='ids' value='"+poj.id+"'/>";
			$("#idsDiv").append(html);
		}
		loadRecord();
	}
	
	
	function loadRecord(){

		$.post("/projectFront/loadRecordStatistics.action",$("#recordForm").serialize(),function(e){

			for(var item in e){
				var tmp=e[item];
				$("#pojMoney"+tmp.projectId).html(tmp.money);
				$("#pojCount"+tmp.projectId).html(tmp.userCount);
			}
			
		},"json");
		
	}
	function showRecord(id){

		if($("#recordI"+id).attr("class")=="m_jk"){
			
			$.post("/projectFront/loadMyRecord.action",{"projectId":id},function(e){
				$('#recordTd'+id).html("");
				$("#recordDiv"+id).show();
				for(var item in e){
					var record = e[item];
					var html="";
					var styleStr="";
					if((e.length-1)==item){
						styleStr='style="border:0"';
					}
					html+=' <li '+styleStr+'><a href="#" class="left_i">捐款  <font class="orange_2">'+record.money+'</font> 元</a><span>'+record.createTimeFormat+' </span><div class=" clear"></div></li>';
					$('#recordTd'+id).append(html);
				}
				$("#recordI"+id).attr("class","m_jk2");
			},"json");
		}else{
			$("#recordDiv"+id).hide();
			$("#recordI"+id).attr("class","m_jk");
		}
		
		
		
	}
	

	
	function loadMySum(){
		
		$.post("/projectFront/loadRecordSum.action",{},function(e){
			var sum=0;
			for(var item in e){
				var record = e[item];
				sum+=record.sumMoney;
			}
			$("#recordSum").html("￥ "+sum);
		},"json");
		
		$.post("/projectFront/loadRecordCount.action",{},function(e){
			
			$("#projectCount").html(e);
		},"text");
		
		$.post("/activityFront/loadRecordCount.action",{},function(e){
			
			$("#activityCount").html(e);
		},"text");
		
	}

	
	function getUserInfo2(){
		$.post("/projectFront/getSessionUserInfo.action",{},function(e){
			
			if(e!=null){

				$("#userImg").attr("src",e.imgUrl);
				var userName = "";
				if(e.name==null){
					userName=e.loginName.substring(0,4)+"*****"+e.loginName.substring(9,11);
				}else{
					userName=e.name;
				}
				$("#userName2").html(userName);
			}else{

				art.dialog.open('/weixinUser/toLoginByMini.action',{
					title:"登录",
					width:'auto',
					height:'auto',
					close:function(){
						window.location.reload();
					}
				});
			}
			
		},"json");
	}

	
</script>

</head>
<body>

<div class="po_b"><a href="#" class=""><i class="wcsm"></i><br>微信扫描</a><a href="#" ><i class="fhdb"></i><br>返回顶部</a></div>
<!--头部 开始-->
<c:import url="/WEB-INF/page/template/${site.directory }/head.jsp" />
<!--头部 结束-->


<div class="box">
	
	
    <div class="my_left_l" id="tableBody">
    	<div class="my_tav">
        	<a href="#" class="hover">我的捐赠</a>
        	<a href="/go-activity_MyRecord.html" >我的活动</a>
            <a href="/go-userInfo.html">个人信息</a>
            <a href="/go-userSign.html">报名申请</a>
            <a href="/go-charity_list.html" style="border:0;">慈善项目</a>
        </div>
        
        
    </div><!--my_left_l-->
      <form id="recordForm" method="post">
				<div id="idsDiv" style="display: none;"></div>
			</form>
    <div class="my_right_l">
    	<dl class="my_r_dl">
        	<dt><img src="" width="130" height="160" id="userImg"/></dt>
            <dd>
            	<span id="userName2"></span><br>共捐款<font class="orange" id="recordSum">￥ 0</span></font> 元
                <div class="line"></div>
                <b>爱心记录</b><br>
				品牌项目共捐赠 <font class="orange_2" id="projectCount">0</font> 个<br>慈善活动共参加 <font class="orange_2" id="activityCount">0</font> 次  
				
            </dd>
        </dl>
    </div>
    <div class="clear"></div>
</div><!--box-->

<div class="foot">
	地址：广州市番禺区市桥清河东路319号区行政办公中心西副楼三楼306室　电话：020-34608222　传真：020-34607240<br>
Copyright(C)　2015-2020　版权所有　广州市番禺区慈善会　粤ICP备4401130100745<br>
           
</div>

</body>


</html>