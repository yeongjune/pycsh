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
	<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/template/${site.directory }/js/slide.js"></script>
	<script type="text/javascript" src="/js/base/util.js"></script>
	<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
	<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<script type="text/javascript">

$(function(){

	getInfo();
	loadMySum();
	getUserInfo2();
});

function getInfo(){
	
	$.post("/projectFront/getSessionUserInfo.action",{},function(e){
		
		
		if(e!=null){
			
			$("#name").val((e.name == null ? '':e.name));
			$("#idCard").val((e.idCard == null ? '':e.idCard));
			$("#email").val((e.email == null ? '':e.email));
			$("#userImg").attr("src",e.imgUrl);
			$("#loginName").html(e.loginName.substring(0,4)+"*****"+e.loginName.substring(9,11));
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

function saveInfo(){
	

	$.post("${ctx}/weixinUser/saveInfo.action",$("#infoForm").serialize(),function(e){
		if(e=="ok"){
			alert("保存成功!");
		}
		
	},"text");
	
}

function toUploadUserImg(){
	art.dialog.open('/weixinUser/toUploadUserImg.action',{
		title:"上传头像",
		width:'auto',
		height:'auto',
		ok:function(){
			$.post("/weixinUser/updateImg.action",{smallPicUrl:this.iframe.contentWindow.$("#typeValue").val()},function(e){
				if(e=="ok"){
					window.location.reload();
				}
			},"text");
			
			
		}
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
            <a href="#"  class="hover">个人信息</a>
            <a href="/go-userSign.html">报名申请</a>
            <a href="/go-charity_list.html" style="border:0;">慈善项目</a>
        </div>
        
        <div class="my_n_box">
       		 <div class="f_i_b">
                    <div class="form_item">     
                        <span class="form_span">个人头像</span>
                        <div class="xg_t"><a href="javascript:void(0);" onclick="toUploadUserImg();">修改</a></div>
                     </div>
        
                     <div class="form_item">     
                        <span class="form_span">姓名</span>
                        <input type="text" class="piece" name="name" id="name" />
                     </div>
                       <div class="form_item">     
                        <span class="form_span">身份证号码</span>
                        <input type="text" class="piece" name="idCard" id="idCard" />
                     </div>
                       <div class="form_item">     
                        <span class="form_span">联系电话</span>
                         <div class="xg_t" id="loginName"></div>
                     </div>
                       <div class="form_item">     
                        <span class="form_span">电子邮件</span>
                        <input type="text" class="piece"  name="email" id="email" />
                     </div>
                     <div class="form_submit"><a  href="javascript:void(0);" onclick="saveInfo();" class="f_btn">确认保存</a></div>
                     <div class="clear"></div>
            </div>
        </div>
               
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