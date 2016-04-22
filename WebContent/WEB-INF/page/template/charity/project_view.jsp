<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>慈善项目</title>
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/base/util.js"></script>
<!-- 弹出框引入 -->
<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="/template/${site.directory }/images/title.ico"/>
  <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/index.css" />
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/module.css" />
     <style type="text/css">
    	.selectMoney{ background:#ffa800; color: #FFF;  border: 1px solid #ffa800; }
    	.money{ font-size:18px; padding:2px 8px; display: block; float: left; border: 1px solid #DEDEDE; margin-right:10px; color:#999}
    	
    	.btn_g2{padding: 10px 0 0 88px;text-align: left;}
    	.btn_g2 a{    width: 165px;
    height: 34px;
    line-height: 34px;
    color: #FFF;
    font-size: 16px;
    display: block;
    background: #c8c8c8;
    text-align: center;}
    	
    </style>
<script type="text/javascript">
	
	var projectName="";
	var donateFlag=false;
$(function(){
	
	loadByPage('/projectFront/loadRecordList.action',{"projectId":"${id}"},loadList);
	
	$.post("/projectFront/getProject.action",{"id":"${id}"},function(e){
		projectName=e.name;
		$("#projectName").html(projectName);
		$("#projectContents").html(e.contents);
		//改变图片大小
		$("#projectContents").find("img").css("width",560);
		
		$("#projectImg").attr("src",e.smallPicOriginalUrl);
		$("#typeName").html(e.typeName);
		if(e.organization==null){
			$("#organizationDiv").hide();
		}
		$("#startTimeFormat").html(e.startTimeFormat);
		$("#endTimeFormat").html(e.endTimeFormat);
		var statusStr ="";
		switch (e.status) {
		case 1:
			statusStr="发起";
			break;
		case 2:
			statusStr="审核";
			break;
		case 3:
			statusStr="募款";
			donateFlag=true;
			$("#donateDiv").attr("class","r_m_btn");
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
		$("#status").html(statusStr);
		
		
	},"json");
	
	
	loadRecord();
	
});
	
	function loadList(list){


		for(var item in list){
			var record = list[item];
			var html="";
			var userName ="";
			if(record.name==null){
				userName=record.loginName.substring(0,4)+"*****"+record.loginName.substring(9,11);
			}else{
				userName=record.name.substring(0,record.name.length-1)+"*";
			}
			html+='<li><span>'+userName+'</span><span><font class="orange_2">￥ '+record.money+'</font>元</span><span class="t_right">'+record.createTimeFormat+'</span></li>';
			
	        $('#donateBody').append(html);

		}
	}
	
	

	function loadRecord(){ 

		$.post("/projectFront/loadRecordStatistics.action",{"ids":"${id}"},function(e){

			for(var item in e){
				var tmp=e[item];
				$("#pojMoney").html(tmp.money);
				$("#pojCount").html(tmp.userCount);
			}
			
		},"json");
		
	}

	
	function addDonate(){
		art.dialog.open('/donateFront/toDonate.action?projectId=${id}',{
			title:projectName,
			width:'auto',
			height:'auto',
			close:function(){
				loadRecord();
			}
		});
	}
	
	

	function submitDonate(){
		$.post("/projectFront/getSessionUserInfo.action",{},function(e){
			if(e!=null){
				if(donateFlag){
					if($("#otherMoney").val()!=""){
						$("#money").val($("#otherMoney").val());
					}
					if($("#money").val()==""){
						alert("请选择捐款金额!");
					}else{
						$("#donateForm").submit();
						
						lockWindow();
						art.dialog({
							title:"捐款支付",
							content:"是否已完成支付?",
							button:[{
								name:"已完成",
								callback: function () {
									window.location.reload();
								}
							},{
								name:"遇到问题",
								callback: function () {
									art.dialog({
										title:"捐款支付",
										content:"是否重新捐款?",
										ok:function(){
											submitDonate();
										},
										cancel:function(){
											window.location.reload();
										}
									});
								}
							}]
						});
						//$("#donateForm").submit();
					}
				}
				
			}else{
				toLogin();
			}
			
		},"json");
		
		
	}

	function selectMoney(emt,money){
		$("#otherMoney").val("");
		
		putMoney();
		$("#money").val(money);
		$(emt).attr("class","selectMoney");
	}

	function onlyNum() {
	    if(!(event.keyCode==46)&&!(event.keyCode==8)&&!(event.keyCode==37)&&!(event.keyCode==39))
	    if(!((event.keyCode>=48&&event.keyCode<=57)||(event.keyCode>=96&&event.keyCode<=105)))
	    event.returnValue=false;
	   
	}

	function putMoney(){
		var aList=$(".r_m_list").find("a");
		for(var i=0;i<aList.length;i++){
			$(aList[i]).attr("class","money");
		}
		$("#money").val("");
	}

	function onlyNum() {
	    if(!(event.keyCode==46)&&!(event.keyCode==8)&&!(event.keyCode==37)&&!(event.keyCode==39))
	    if(!((event.keyCode>=48&&event.keyCode<=57)||(event.keyCode>=96&&event.keyCode<=105)))
	    event.returnValue=false;
	}
	
</script>

</head>
<body>
	
<div class="po_b"><a href="#" class=""><i class="wcsm"></i><br>微信扫描</a><a href="#" ><i class="fhdb"></i><br>返回顶部</a></div>
<!--头部 开始-->
<c:import url="/WEB-INF/page/template/${site.directory }/head.jsp" />
<!--头部 结束-->

	
<div class="box">
    
    <div class="left_xq">
    	<div class="l_x_img"> <img id="projectImg" src="" width="560" ></div>
        <div class="title">
            <div class="t_font overflow" id="projectName"></div>
            <div class="tip left" id="typeName"></div>
        </div>
        <div class="xq_t" id="projectContents">
        	
        </div>
        <div class="xq_small" id="organizationDiv">主办方：<span id="organization"></span></div>
  </div><!--left_xq-->
  <form id="donateForm"  method="post" target="_blank" action="/alipay/addPay.action">
  <div class="right_xq">
     <div class="r_mo_o" style="width: 370px;">
     	<div class="r_m_l">项目状态 : <font class="orange_2" id="status"></font></div>
        <div class="r_m_o_b">
        	已筹 <font class="orange_2" id="pojMoney">0</font> 元 　已有 <font class="orange_2" id="pojCount">0</font> 人捐款 <br>
            <font class="gray_s">时间：<span id="startTimeFormat"></span> 至 <span id="endTimeFormat"></span></font>
		</div>
        
        <div class="r_m_j">
        	<div class="left_j">捐款金额</div>
            <div class="r_m_list">
            	<a  href="javascript:void(0);" onclick="selectMoney(this,10)">10元</a>
            	<a  href="javascript:void(0);" onclick="selectMoney(this,20)">20元</a>
                <a  href="javascript:void(0);" onclick="selectMoney(this,50)">50元</a>
                <a  href="javascript:void(0);" onclick="selectMoney(this,100)">100元</a>
            </div>
        </div>
        
         <div class="r_m_j">
        	<div class="left_j">其他金额</div>
            <div class="r_m_input">
            	<input type="text" id="otherMoney" onkeydown="onlyNum();" onfocus="putMoney();">
                <font>元</font>
            </div>
        </div>
        <input type="hidden" name="total_fee" id="money"/>
		<input type="hidden" name="projectId" value="${id }"/>

        <div class="clear"></div>
        
        <div class="btn_g2" id="donateDiv"><a href="javascript:void(0);" onclick="submitDonate();">我要捐赠</a></div>
     </div>
     
     <div class="o_icon" style=" padding-bottom:0; width:370px;">
        	<div class="j_tit">捐赠列表</div>
            <DIV class="j_list" style="overflow: hidden;height: 270px;">
            	<ul id="donateBody" style="position: relative;">

                </ul>
            </DIV>
            <script type="text/javascript">
                window.setTimeout(function(){
                    window.setInterval(function(){
                        var font = $('#donateBody');
                        var fWidth = parseInt(font.outerHeight(true));
                        var ftop = parseInt(font.css('top').replace(/[^0-9\-]/g, '')) || 0;
                        if((0-ftop) > fWidth)
                            ftop = 140;
                        font.css('top', ftop - 1);
                    }, 80);
                }, 3000);
            </script>            
        </div>
  </div><!--right_xq-->
  <div class="clear"></div>
 	</form>
 
</div><!--box-->
	
<!--脚部 开始-->
<c:import url="/WEB-INF/page/template/${site.directory }/foot.jsp" />
<!--脚部 结束-->
	
	
</body>
</html>