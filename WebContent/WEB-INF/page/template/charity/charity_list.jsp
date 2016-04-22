<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>个人信息</title>
	<link rel="shortcut icon" type="image/x-icon" href="/template/${site.directory }/images/title.ico"/>
	<link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/index.css" />
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/module.css" />
        <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/inspages.css" />
	<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/template/${site.directory }/js/slide.js"></script>
	<script type="text/javascript" src="/js/base/util.js"></script>
	<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
	<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<script type="text/javascript">

$(function(){

	getInfo();
	loadMySum();
	
	
	
});

function getInfo(){
	
	$.post("/projectFront/getSessionUserInfo.action",{},function(e){
		
		
		if(e!=null){
			getUserInfo2();
			
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
			load();
			getUserSign();
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



function toUploadRegisterImg(){
	art.dialog.open('/userSign/toUploadRegisterImg.action',{
		title:"上传证书",
		width:'auto',
		height:'auto',
		ok:function(){
			$("#smallPicUrl").val(this.iframe.contentWindow.$("#typeValue").val());

			
			
		}
	});
	
}

function getUserSign(){
	$.post("/userSign/getUserSign.action",{},function(e){
		
		
		if(e==null||e.status!=1){
			art.dialog({
				width : 200,
				height : 150,
				content : "您还未通过申请审核,暂不能发起项目. 请提交并等待认证通过!",
				lock:true,
				ok : function(){
					window.location.href="/go-userSign.html";
				}
			});
			
		}else{
			$("#createBtn").show();
		}
		
	},"json");
	
}
function load(){
	loadByPage('/userSign/loadCharityProject.action',{status:$('#status').val(),keyword:$("#keyword").val()},this.showList);
};

function toGame(id){
	
	window.open("/go-game_view.html?id="+id,"_blank");
}
function showList(list){
	$('#tableBody').html('');
	var index = 0;
	if(list.length==0)
	{
		$(".prj_apl_btn_more").html("暂无相关数据");
	}else if(list.length>10){
		$(".prj_apl_btn_more").show();
	}else{
		$(".prj_apl_btn_more").hide();
	}
	for ( var item in list) {
		var cp = list[item];
		if(cp){
			var html='<div class="my_n_box">';
            html+='<dl class="prj_apl">';
            html+='    <dt><img src="'+cp.smallPicUrl+'" alt="" width="163" height="140"/></dt>';
            html+='    <dd>';
            html+='       <h4><a href="javascript:void(0);" onclick="toGame('+cp.id+')">'+cp.name+'</a></h4>';
            html+='        <div class="p_a_m_l">';
            html+='            <p>项目类型：'+cp.typeName+'</p>';
            html+='           <p>申报时间：'+cp.createTimeFormat+'</p>';
            var statusStr="";
            if(cp.status==1){
            	statusStr="发起";
            }
            if(cp.status==2){
            	statusStr="审核";
            }
            if(cp.status==3){
            	statusStr="募款";
            }
            if(cp.status==4){
            	statusStr="执行";
            }
            if(cp.status==5){
            	statusStr="结束";
            }
          	html+='            <p>进度：'+statusStr+'</p>';
          	var checkStr = "未审核";
          	if(cp.checked==0&&cp.status!=1){
          		checkStr="审核中";
            }
        	if(cp.checked==1){
        		checkStr="已通过";
            }
        	if(cp.checked==2){
        		checkStr="不通过";
            }
        	html+='           <p>审核状态：<span>'+checkStr+'</span></p>';
        	html+='       </div>';
        	html+='        <ul class="p_a_m_r">';
        	if(cp.status==1||(cp.status==2&&cp.checked==2)){
        		html+='            <li><a href="javascript:void(0);" onclick="updateProject('+cp.id+');">修改</a></li>';
        		html+='            <li><a href="javascript:void(0);" onclick="submitProject('+cp.id+');">提交审核</a></li>'; 
        	}
        	if(cp.checked==1){
        		html+='           <li><a href="javascript:void(0);" onclick="toRecord('+cp.id+');">进展管理</a> </li>';
            	html+='           <li><a href="javascript:void(0);" onclick="viewOpinions('+cp.id+');">审核记录</a></li>';
            	html+='          <li><a href="javascript:void(0);">捐款记录</a></li>';
            	html+='          <li><a href="javascript:void(0);"></a></li>';
        	}else{
        		html+='           <li><a href="javascript:void(0);" onclick="viewOpinions('+cp.id+');">审核记录</a></li>';
        		
        		html+='          <li><a href="javascript:void(0);"></a></li>';
        		if(cp.status!=1&&cp.checked!=2){
        			html+='           <li><a href="javascript:void(0);" style="color:#AAAAAA;">进展管理</a></li>';
                	html+='          <li><a href="javascript:void(0);">捐款记录</a></li>';
        		}
        		
        	}
        	
        	//html+='           <li><a href="#">进展管理</a></li>';
        	//html+='           <li><a href="#">审核记录</a></li>';
        	//html+='          <li><a href="#">捐款记录</a></li>';
        	html+='       </ul>';
        	html+='    </dd>';
        	html+='</dl>';
        	html+='<div class="clear"></div>';
        	html+='</div>';
			 $('#tableBody').append(html); 
		}else{
		}
		index++;
	}
	if (list&&list.length>0) {
		$("#deleteMutil").show();
		$("#moveMutil").show();
		$("#changeStatus").show();
	}else{
		$("#deleteMutil").hide();
		$("#moveMutil").hide();
		$("#changeStatus").hide();
	}
};

function createProject(){
	art.dialog.open('/userSign/add.action', {
		width: '100%',
		height: '100%',
		lock:true,
		title:'申报项目'
	});
};

function updateProject(id){
	art.dialog.open('/userSign/update.action?id='+id, {
		width: '100%',
		height: '100%',
		lock:true,
		title:'修改项目'
	});
};

function submitProject(id){
	art.dialog.confirm("确定要提交吗？", function(){
		$.post('/userSign/submitProject.action',{id:id},function(data){
			if(data=='ok'){
				//$('#tr_'+id).remove();
				load();
				art.dialog.alert('提交成功');
			}else{
				art.dialog.alert('操作失败');
			}
		});
	});
}

function viewOpinions(id){
	
	$.post("/userSign/getCharityProject.action",{id:id},function(e){
		
		art.dialog({
			width : 200,
			height : 150,
			title : '审核记录',
			lock:true,
			content : (e.opinions ? e.opinions : "暂无审核记录"),
			ok : function(){
				
			}

		});
		 
	},"json");
}


function toRecord(id){
	art.dialog.open('/userSign/toCharityRecordList.action?id='+id,{
		title:"进展管理",
		width:600,
		height:600,
		lock:true
	});
	
}
</script>
</head>
<body>
<div class="po_b"><a href="#" class=""><i class="wcsm"></i><br>微信扫描</a><a href="#" ><i class="fhdb"></i><br>返回顶部</a></div>
<!--头部 开始-->
<c:import url="/WEB-INF/page/template/${site.directory }/head.jsp" />
<!--头部 结束-->
<form id="infoForm" action="#" method="post">
	<div class="box">
	
	
    <div class="my_left_l">
    	<div class="my_tav">
        	<a href="/go-project_MyRecord.html" >我的捐赠</a>
        	<a href="/go-activity_MyRecord.html" >我的活动</a>
            <a href="/go-userInfo.html">个人信息</a>
            <a href="/go-userSign.html">报名申请</a>
            <a href="#"  class="hover" style="border:0;">慈善项目</a>
        </div>
        
                
                <a href="javascript:void(0);" id="createBtn" onclick="createProject();" style="color: #FFFFFF;display: none;"  class="prj_apl_btn btn_green">项目申报</a>
                <div id="tableBody">
                
                </div>

                <a href="#" class="btn_green prj_apl_btn_more">更多</a>
 
    </div><!--my_left_l-->
    
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

</form>


<div class="foot">
	地址：广州市番禺区市桥清河东路319号区行政办公中心西副楼三楼306室　电话：020-34608222　传真：020-34607240<br>
Copyright(C)　2015-2020　版权所有　广州市番禺区慈善会　粤ICP备4401130100745<br>
           
</div>

</body>

</html>