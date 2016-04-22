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
    <style type="text/css">
    .form_item .form_span{
    width: 150px;
    }
    </style>
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
			
			$("#name").val((e.name == null ? '':e.name));
			$("#idCard").val((e.idCard == null ? '':e.idCard));
			$("#email").val((e.email == null ? '':e.email));
			$("#userImg").attr("src",e.imgUrl);
			$("#loginName").html(e.loginName.substring(0,4)+"*****"+e.loginName.substring(9,11));
			getUserInfo2();
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

function saveUserSign(){
	
	if($("#company").val()==""){
		art.dialog({
			title:"消息",
			content:"请填写单位名称",
			lock:true,
			close:function(){
				$("#company").focus();
			}
		});
	}else if($("#corporation").val()==""){
		art.dialog({
			title:"消息",
			content:"请填写法人代表",
			lock:true,
			close:function(){
				$("#corporation").focus();
			}
		});
	}else if($("#contact").val()==""){
		art.dialog({
			title:"消息",
			content:"请填写联系人",
			lock:true,
			close:function(){
				$("#contact").focus();
			}
		});
	}else if($("#contactPhone").val()==""){
		art.dialog({
			title:"消息",
			content:"请填写联系电话",
			lock:true,
			close:function(){
				$("#contactPhone").focus();
			}
		});
	}else if($("#smallPicUrl").val()==""){
		art.dialog({
			title:"消息",
			content:"请上传证书",
			lock:true,
			close:function(){
				$("#smallPicUrl").focus();
			}
		});
	}else if($("#email").val()==""){
		art.dialog({
			title:"消息",
			content:"请填写电子邮箱",
			lock:true,
			close:function(){
				$("#email").focus();
			}
		});
	}else{
		$.post("${ctx}/userSign/saveUserSign.action",$("#infoForm").serialize(),function(e){
			if(e=="ok"){
				art.dialog({
					title:"消息",
					content:"申请成功!",
					lock:true,
					close:function(){
						window.location.reload();
					}
				});
				
			}
			
		},"text");
	}
	
	
}

function toUploadRegisterImg(){
	art.dialog.open('/userSign/toUploadRegisterImg.action',{
		title:"上传证书",
		width:'auto',
		height:'auto',
		lock:true,
		ok:function(){
			$("#smallPicUrl").val(this.iframe.contentWindow.$("#typeValue").val());
			$("#smallPic").attr("src",this.iframe.contentWindow.$("#typeValue").val());
			$("#smallPic").show();
			
		}
	});
	
}
var opinions="";
var promise="";
var application="";
function getUserSign(){
	$(".swfupload").attr("width",200);
	$.post("/userSign/getUserSign.action",{},function(e){
		
		
		if(e!=null){
			
			$("#company").val((e.company == null ? '':e.company));
			$("#corporation").val((e.corporation == null ? '':e.corporation));
			$("#contact").val((e.contact == null ? '':e.contact));
			$("#contactPhone").val((e.contactPhone == null ? '':e.contactPhone));
			$("#email").val((e.email == null ? '':e.email));
			
			
			for(var i=0;i<e.imgList.length;i++){
				var html="";
				html+='<div id="imgDiv'+imgIndex+'" style="float:left;margin-right: 5px;margin-bottom: 5px;">';
				html+='<img  src="'+e.imgList[i].imgUrl+'" width="200" />';
				html+='<input name="imgUrls" value="'+e.imgList[i].imgUrl+'" type="hidden"/>';
				html+='</div>';
				$("#imgUrlDiv").append(html);
				imgIndex++;
			}
			$("#smallPicUrl").val((e.registerImgUrl == null ? '':e.registerImgUrl));
			if(e.status==2){
				$("#subDiv").show();
				$("#statusDiv").attr("class","my_n_box_checked check_line_sb");
				$("#statusStr").html("不通过");
				$("#statusTips").html("您的认证未能通过,请点击报名信息修正并重新提交! <a href='javascript:void(0);' onclick='showOpinions();'>点击查看原因</a>");
				opinions=e.opinions;
				
				$("#backBtn").hide();
				
				
			}
			if(e.status==1){
				$("#subDiv").hide();
				$("#statusDiv").attr("class","my_n_box_checked check_line_cg");
				$("#statusStr").html("已认证");
				$("#statusTips").html("您的认证已通过!");
				$("#backBtn").show();
				$("#uploadRegisterImg").hide();
				$("#btnUpload_1").hide();
				$(".swfupload").remove();
				$("#promiseDiv").show();

				
			}
			if(e.status==0){
				$("#backBtn").show();
				$("#uploadRegisterImg").hide();
				$("#btnUpload_1").hide();
				$(".swfupload").remove();
				
				
			}
			if(e.registerImgUrl!=null){
				$("#smallPic").attr("src",e.registerImgUrl);
				$("#smallPic").show();
			}
			$("#finDidv").show();
			
			if(e.promise!=null){	
				promise=e.promise;
				$("#promiseDiv").html('<a href="javascript:void(0);" class="btn_green" id="promiseBtn" onclick="toViewPromise();">查看承诺书</a>');
			}
			if(e.application!=null){
				application=e.application;	
			}
		}else{
			$("#subDiv").show();
			$("#infoDiv").show();
		}
		
	},"json");
	
}

function toUploadPromise(){
	art.dialog.open('/userSign/toUploadPromise.action',{
		title:"承诺书(doc,xls,docx,xlsx,pdf)",
		width:'auto',
		height:'auto',
		lock:true,
		close:function(){
			$.post("/userSign/updatePromise.action",{promise:this.iframe.contentWindow.$("#typeValue").val()},function(e){
				if(e=="ok"){
					window.location.reload();
				}
			},"text");
			
			
		}
	});
	
}


function toViewPromise(){
	window.open(promise,"_blank");
}

function toViewApplication(){
	window.open(application,"_blank");
}


function showOpinions(){
	art.dialog({
		title:"消息",
		content:opinions,
		close:function(){
			
		}
	});
}
function showInfo(){
	$("#infoDiv").show();
	$("#finDidv").hide();

}

function backFin(){
	$("#finDidv").show();
	$("#infoDiv").hide();
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
            <a href="#"  class="hover" style="border-right: 1px solid #dedede;">报名申请</a>
            <a href="/go-charity_list.html" style="border:0;">慈善项目</a>
        </div>
        
        <div class="my_n_box"  style="display: none;" id="infoDiv">
       		 <div class="f_i_b" style=" padding: 20px 0 0 10px">
 
        
                     <div class="form_item">     
                        <span class="form_span">单位名称</span>
                        <input type="text" class="piece" name="company" id="company" />
                     </div>
                       <div class="form_item">     
                        <span class="form_span">单位法人</span>
                        <input type="text" class="piece" name="corporation" id="corporation" />
                     </div>
                       <div class="form_item">     
                        <span class="form_span">联系人</span>
                         <input type="text" class="piece" name="contact" id="contact" />
                     </div>
                     <div class="form_item">     
                        <span class="form_span">联系电话</span>
                        <input type="text" class="piece"  name="contactPhone" id="contactPhone" />
                     </div>
                     <div class="form_item">     
                        <span class="form_span">电子邮箱</span>
                        <input type="text" class="piece"  name="email" id="email" />
                     </div>
                     <div class="form_item" style="height:50px;">     
                        <span class="form_span">社会组织登记证书<p style="font-size: 12px;">（社团法人，民非企法人）</p></span>
                        <div id="uploadRegisterImg" class="xg_t" style="float:left;width:100px;height:34px;text-align:center;line-height:34px;background:#409c5a;"><a style="color:#fff;text-decoration:none;" href="javascript:void(0);" onclick="toUploadRegisterImg();">上传图片</a></div>
                        <input type="hidden" id="smallPicUrl" name="smallPicUrl"/>
                        
                     </div>
                     <div class="form_item" style="margin: 0">     
                     	<img src="" width="200" style="display: none;margin-left: 160px;" id="smallPic" />
                     </div>
                     
                     <div class="form_item">     
                        <span class="form_span">附件<p style="font-size: 12px;">（社会等级评估证书等）</p></span>
                        <c:import url="/common/swfUpload6.jsp">
						    <c:param name="limit">1</c:param>
							<c:param name="types">*.jpg;*.gif;*.png;*.bmp;*.jpeg</c:param>
							<c:param name="upload_size">10000</c:param>
							<c:param name="type">0</c:param>
							<c:param name="index">1</c:param>
						</c:import>	
                     </div>
                     <div class="clear"></div>
                     <div id="imgUrlDiv" style="margin-left: 160px;"></div>
                     	
                     
                    <div class="clear"></div>
                    
                     <div class="form_submit" id="subDiv" style="display: none;padding-left: 160px;"><a  href="javascript:void(0);" onclick="saveUserSign();" class="f_btn">提交申请</a></div>
                      <div class="form_submit" id="backBtn" style="display: none;"><a  href="javascript:void(0);" onclick="backFin();" class="f_btn">返回</a></div>
                     <div class="clear"></div>
            </div>
        </div>
        
        <div class="my_n_box" style="display: none;" id="finDidv">
          <div class="my_n_box_checked" id="statusDiv">
                <div class="check_img"></div>
                <div class="check_line">
                    <span>进度：</span>
                    <div class="check_line_grey"></div>
                    <div class="check_line_orange"></div>
                        <div class="check_line_sq">
                            <i>申请</i>

                        </div>
                        <div class="check_line_sh">
                            <i>认证中</i>
                        </div>
                        <div class="check_line_jg">
   							<i id="statusStr"></i>
                        </div>
                    
                </div>
                <p id="statusTips">请耐心等候，工作人员正在认证您的信息</p>
                <div class="check_btn">
                    <a href="javascript:void(0);" class="btn_green" onclick="showInfo();">报名信息</a>
                
	                <span class="check_btn" style="display: none;" id="promiseDiv">
	                    <a href="javascript:void(0);" class="btn_green" id="promiseBtn" onclick="toUploadPromise();">上传承诺书</a>
	                </span>
                </div>
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