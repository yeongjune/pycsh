<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/index.css" />
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/module.css" />
	<link rel="shortcut icon" type="image/x-icon" href="/template/${site.directory }/images/title.ico"/>    
<title>慈善活动-列表</title>
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/base/util.js"></script>
<!-- 弹出框引入 -->
<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>

<script type="text/javascript">
	
	
$(function(){
	loadByPage('/activityFront/loadActList.action',{},loadList);

});
	
function loadList(list){
	for(var item in list){
		var poj = list[item];
		var html="";
	
		var statusStr = "";
		switch (poj.status) {
		case 1:
			statusStr="发起";
			break;
		case 2:
			statusStr="审核";
			break;
		case 3:
			statusStr="报名中";
			break;
		case 4:
			statusStr="执行";
			break;
		case 5:
			statusStr="结束";
			break;

		default:
			break;
		}
		
		html+='<li>';
		html+=' <div class="list_mode">';
        html+='<dl class="l_l" onclick="toProject('+poj.id+')">';
        html+=' <dt><img src="'+poj.smallPicUrl+'" width="160" height="140"></dt>';
        html+=' <dd>';
        html+='<div class="title">';
        html+='   <div class="t_font overflow">'+poj.name+'</div>';
        html+=' </div>';
        html+='  <div class="clear"></div>';
        html+=poj.introduce;
        html+='    <div class="t_time">'+poj.startTimeFormat+' 至 '+poj.endTimeFormat+' 　　'+(poj.organization ==undefined ? '' :poj.organization)+'</div>';
        html+='  </dd>';
        html+='  </dl>';
        html+=' </div><!--list_mode-->';
        html+=' <div class="right_m">';
        html+='<div class="one_m">';
        html+='活动状态 :  <font class="orange_2">'+statusStr+'</font><br>';
        html+=' 已筹 <font class="orange_2" id="pojMoney'+poj.id+'" >0</font> 元<br>';
        html+='  已有 <font class="orange_2" id="pojCount'+poj.id+'">0</font> 人报名<br>';
        html+=' </div>';
        if(poj.status==3){
        	
	        html+='  <div class="btn_m" onclick="signActivity('+poj.id+',\''+poj.name+'\')">我要报名</div>';
        }else{
        	html+='  <div class="btn_g">报名已结束</div>';
        	
        }
        html+='</div>';
      	html+='<div class="clear"></div>';
      	html+='</li>';
	
        $('#tableBody').append(html);
        html="<input type='hidden' name='ids' value='"+poj.id+"'/>";
		$("#idsDiv").append(html);
		if($("#pageBtn").html()!=""&&params_cache.params!=null&&params_cache.params.currentPage!=params_cache.totalPage){
			$("#nextBtn").show();
		}else{
			$("#nextBtn").hide();
		}

	}
	loadRecord();
}


function loadRecord(){

	$.post("/activityFront/loadRecordStatistics.action",$("#recordForm").serialize(),function(e){

		for(var item in e){
			var tmp=e[item];
			$("#pojMoney"+tmp.actId).html(tmp.money);
			$("#pojCount"+tmp.actId).html(tmp.userCount);
		}
		
	},"json");
	
}
	
	function addDonate(projectId,actName,name,phone,idcard,exPhone){
		lockWindow();
	
		art.dialog.open('/donateFront/toDonate.action?actId='+projectId+"&name="+name+"&phone="+phone+"&idcard="+idcard+"&exPhone="+exPhone,{
			id:"donatedialog",
			title:actName,
			width:'auto',
			height:'auto',
			close:function(){
				loadRecord();
				openLock();
			}
		});
			
			

		
		
	}
	
	function signActivity(projectId,name){
		
		lockWindow();
		$.post("/projectFront/getSessionUserInfo.action",{},function(e){
			if(e!=null){
				
				addDonate(projectId,name,$("#name").val(),$("#phone").val(),$("#idcard").val(),$("#exPhone").val());
					
			}else{
				openLock();
				toLogin();
			}
		},"json");
		
	}
	
	function putTitle(emt){
		if($(emt).val()=="请输活动名称"){
			
			$(emt).val("");
		}
	}
	
	function blurTitle(emt){
		if($(emt).val()==""){
			
			$(emt).val("请输活动名称");
		}
	}
	
	function seletProject(){
		$('#tableBody').html("");
		loadByPage('/activityFront/loadActList.action',{"name":($("#name").val()=="请输活动名称" ? '' : $("#name").val() )},loadList);
	}
	
	function toProject(id){
		window.location.href="/go-activity_view.html?id="+id;	
	}
</script>

</head>
<body>
<div class="po_b"><a href="#" class=""><i class="wcsm"></i><br>微信扫描</a><a href="#" ><i class="fhdb"></i><br>返回顶部</a></div>
<!--头部 开始-->
<c:import url="/WEB-INF/page/template/${site.directory }/head.jsp" />
<!--头部 结束-->


<div class="box">
	
   
    
   <div class="xs_o_t">
   		<%-- <div class="l_o_btn"><a href="#">我要求助</a></div> --%>
        <div class="r_o">
        	<%-- <div class="lx_o"><span>所有类型</span><i class="o_m_jk left"></i></div> --%>
            <div class="sear_o">
            	<div class="left"> <input type="text" id="name" class="piece" value="请输活动名称" onfocus="putTitle(this);" onblur="blurTitle(this);"></div>
              <div class="se_o_btn"><a href="javascript:void(0);" onclick="seletProject();">查询</a></div>
            </div>
        </div>
        <div class="clear"></div>
   	
   </div>

			<form id="recordForm" method="post">
				<div id="idsDiv" style="display: none;"></div>
			</form>
 	<div class="b_list"> 
        <ul id="tableBody">
           
            
          </ul>
  </div> 
   <div style="display: none;" class="table_under_btn">
		<div class="flip" id="pageBtn"></div>
	</div>
  
  <div class="in_m"><a href="javascript:void(0);" onclick="nextPage();" id="nextBtn" class="block" style="display: none;">更多活动</a></div>
  
</div><!--box-->

<!--脚部 开始-->
<c:import url="/WEB-INF/page/template/${site.directory }/foot.jsp" />
<!--脚部 结束-->

</body>

</html>