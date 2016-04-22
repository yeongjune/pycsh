<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>登录</title>
<%@include file="/common/taglibs.jsp" %>
	<link rel="stylesheet" type="text/css" href="/template/charity/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/template/charity/css/index.css" />
    <link rel="stylesheet" type="text/css" href="/template/charity/css/module.css" />
    <style type="text/css">
    	.selectMoney{ background:#ffa800; color: #FFF;  border: 1px solid #ffa800; }
    	.money{ font-size:18px; padding:2px 8px; display: block; float: left; border: 1px solid #DEDEDE; margin-right:10px; color:#999}
    </style>
	<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/js/base/util.js"></script>
	<script type="text/javascript" src="/js/base/md5.min.js"></script>
	<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<script type="text/javascript">

$(function(){
	
	

});

function sendCaptcha(){
	
	$.post("${ctx}/weixinUser/sendCaptcha.action",{},function(e){
		if(e=="ok"){
			alert("发送成功!");
		}else if(e=="notMobiles"){
			alert("登录失效!");
			window.location.reload();
		}
		
	},"text");
}


function submitDonate(){
	var checkFlag=true;
	var tips="";
	
	
	if($("#name").val()==""){
		checkFlag=false;
		tips="姓名不能为空!";
	}
	if($("#phone").val()==""){
		checkFlag=false;
		tips="手机号码不能为空!";
	}
	if("${actId}"!=""&&$("#phone").val().length!=11){
		checkFlag=false;
		tips="手机号码不正确!";
	}
	if(checkFlag||"${actId}"==""){
		if($("#xyCheck").attr("checked")=="checked"||$("#xyCheck").attr("checked")==true){
	
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
									art.dialog.close();
								}
							},{
								name:"遇到问题",
								callback: function () {
									art.dialog({
										title:"捐款支付",
										content:"是否重新捐款?",
										ok:function(){
											window.location.reload();
										},
										cancel:function(){
											art.dialog.close();
										}
									});
								}
							}]
						});
						//$("#donateForm").submit();
					}

			
		}else{
			alert("捐款前必须同意协议!");
		}
		
	}else{
		art.dialog({
			title:"消息",
			content:tips,
			close:function(){
				
			}
		});
	}
	
	
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

function checkDon(){
	if($('#xyCheck').attr('checked')=="checked"||$('#xyCheck').attr('checked')==true){
		$('#xyCheck').attr('checked',false);
	}else{
		$('#xyCheck').attr('checked',true);
	}
}

function viewText(){
	
	window.open("/single-2368.html");
}

</script>
</head>
<body>
<form id="donateForm" method="post" target="_blank" action="/alipay/addPay.action">
	<div class="po_box" style="width: 390px;">
	<div class="po_title left">

   	</div>
    <div class="clear"></div>
    <div class="po_one">
    	<c:if test="${actId!=null }">
    	
    		 <div class="right_xq">
     <div class="r_mo_o" style="width: 370px;">
     	
        <div class="r_m_j" >
        	<div class="left_j">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名(<span class="red">*</span>)</div>
        	<div class="r_m_input" style="width: 243px;">
           		<input type="text" name="name" id="name" style="width: 233px;"/>
           		<input type="hidden" name="actId" value="${actId }" />
            </div>
        </div>
        <div class="r_m_j">
        	<div class="left_j">手机号码(<span class="red">*</span>)</div>
        	<div class="r_m_input" style="width: 245px;">
           		<input type="text" name="phone"  id="phone" style="width: 235px;"  onkeydown="onlyNum();" onfocus="putMoney();" />
            </div>
        </div>
        <div class="r_m_j">
        	<div class="left_j">身份证号</div>
        	<div class="r_m_input" style="width: 265px;">
           		<input type="text" name="idcard" id="idcard" style="width: 255px;"/>
            </div>
        </div>
         <div class="r_m_j">
        	<div class="left_j">紧急联系人电话</div>
        	<div class="r_m_input" style="width: 210px;">
           		<input type="text" name="exPhone"  id="exPhone" style="width: 200px;" />
            </div>
        </div>
        <div class="r_m_j" style="margin-top: 20px;margin-bottom: 20px;">
        	捐款献爱心---------------------------------------------------------
        </div>
    	</c:if>
	 	  <div class="r_m_j">
        	<div class="left_j">捐款金额</div>
            <div class="r_m_list">
            	<a href="javascript:void(0);" onclick="selectMoney(this,10)">10元</a>
				<a href="javascript:void(0);" onclick="selectMoney(this,20)">20元</a>
				<a href="javascript:void(0);" onclick="selectMoney(this,50)">50元</a>
				<a href="javascript:void(0);" onclick="selectMoney(this,100)">100元</a>
            </div>
      	  </div>
          <div class="r_m_j">
        	<div class="left_j">其他金额</div>
            <div class="r_m_input">
            	<input type="text" id="otherMoney" onkeydown="onlyNum();" onfocus="putMoney();" style="ime-mode:Disabled"/>
                <font>元</font>
            </div>
            <input type="hidden" name="total_fee" id="money"/>
			<input type="hidden" name="projectId" value="${projectId }"/>

          </div>
          <div class="clear"></div>
          <div class="r_m_btn"><a href="javascript:void(0);" onclick="submitDonate();">确定捐赠</a></div>
          <div class="ty_g"><a href="javascript:void(0);" onclick="checkDon();"><input onclick="event.stopPropagation();" name="" checked="checked" type="checkbox" class="checkbox" value="" id="xyCheck" /> 同意</a><a href="javascript:void(0);" onclick="viewText();">《番禺慈善会公益用户协议》</a></div>
     </div>
</div>
	

</form>
</body>
</html>