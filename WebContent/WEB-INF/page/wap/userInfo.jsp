<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<link rel="stylesheet" type="text/css" href="/skins/wap/css/base.css" />
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/base/util.js"></script>
<script type="text/javascript" src="/js/base/md5.min.js"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<title>基本资料</title>
<script type="text/javascript">

	function showName(){
		$("#name").show();
		$("#nameSpan").hide();
		$("#name").select();
	}
	
	function updateName(){
		$.post("/wxUser/updateInfo.action",{"name":$("#name").val()},function(e){
			if(e=="ok"){
				$("#name").hide();
				$("#nameSpan").show();
				$("#nameSpan").html($("#name").val());
			}
		},"text");
	}
	
	
	function showEmail(){
		$("#email").show();
		$("#emailSpan").hide();
		$("#email").select();
	}
	
	function updateEmail(){
		$.post("/wxUser/updateInfo.action",{"email":$("#email").val()},function(e){
			if(e=="ok"){
				$("#email").hide();
				$("#emailSpan").show();
				$("#emailSpan").html($("#email").val());
			}
		},"text");
	}
	
	
	function showLiveAddress(){
		$("#liveAddress").show();
		$("#liveAddressSpan").hide();
		$("#liveAddress").select();
	}
	
	function updateLiveAddress(){
		$.post("/wxUser/updateInfo.action",{"liveAddress":$("#liveAddress").val()},function(e){
			if(e=="ok"){
				$("#liveAddress").hide();
				$("#liveAddressSpan").show();
				$("#liveAddressSpan").html($("#liveAddress").val());
			}
		},"text");
	}
	
	

	function showGender(){
		$("#genderValueSpan").show();
		$("#genderSpan").hide();
		
	}
	
	function updateGender(gender){
		$.post("/wxUser/updateInfo.action",{"gender":gender},function(e){
			if(e=="ok"){
				$("#genderValueSpan").hide();
				$("#genderSpan").show();
				$("#genderSpan").html((gender==1 ? '男' : '女'));
			}
		},"text");
	}
	
	function updateImg(){
		
		art.dialog.confirm('你确定要同步头像吗？', 
			    function () {
					$.post("/wxUser/updateImg.action",{},function(e){
						if(e=="ok"){
							art.dialog.tips('同步成功!');
							window.location.reload();
						}
					},"text");
			   
			    }, 
			    function () {
			    
			});
		

		
	}
</script>
</head>

<body class="bj">
	<div class="box ">
		 <div class="m_one">
        	<div class="j_title">基本资料</div>
            <div class="j_bj">
            	<ul>
                	<li><span class="left_w">头像</span><span class="right"><a onclick="updateImg();"><img src="${userInfo.imgUrl }" width="60" class="bj_img" ></img></a></span><div class="clear"></div></li>
                    <li>
                    	<span class="left">名字</span><input type='text' style="margin-right:30px;  display: none;" id='name' class='input_d' value='${userInfo.name }' onblur="updateName();"/><span class="right_i" id="nameSpan">${userInfo.name }</span>
                        <div class="q_jt"><a  onclick="showName();"><img src="/skins/wap/images/cs-2.png" width="26"></a></div>
                        <div class="clear"></div>
                   </li>
                   <li>
                    	<span class="left">性别</span><span id="genderValueSpan" style=" display: none;"><input type="radio" ${userInfo.gender==1 ? 'checked="checked"' : '' } name="gender" onclick="updateGender(1)"/>男 <input type="radio" name="gender" ${userInfo.gender==2 ? 'checked="checked"' : '' }  onclick="updateGender(2)"/>女</span><span class="right_i" id="genderSpan">${userInfo.gender==1 ? '男' : '' }${userInfo.gender==2 ? '女' : '' }</span>
                        <div class="q_jt"><a onclick="showGender();"><img src="/skins/wap/images/cs-2.png" width="26" ></a></div>
                        <div class="clear"></div>
                   </li>
                   <li>
                    	<span class="left">手机号码</span><span class="right_i">${userInfo.loginName }</span>
                        <%-- <div class="q_jt"><img src="/skins/wap/images/cs-2.png" width="26" ></div> --%>
                        <div class="clear"></div>
                   </li>
                   <li>
                    	<span class="left">电子邮件</span><input type='text' style="margin-right:30px;  display: none;" id='email' class='input_d' value='${userInfo.email }' onblur="updateEmail();"/><span class="right_i" id="emailSpan">${userInfo.email }</span>
                        <div class="q_jt"><a onclick="showEmail();"><img src="/skins/wap/images/cs-2.png" width="26" ></a></div>
                        <div class="clear"></div>
                   </li>
                   <li>
                    	<span class="left">地址</span><input type='text' style="margin-right:30px;  display: none;" id='liveAddress' class='input_d' value='${userInfo.liveAddress }' onblur="updateLiveAddress();"/><span class="right_i" id="liveAddressSpan">${userInfo.liveAddress }</span>
                        <div class="q_jt"><a onclick="showLiveAddress();"><img src="/skins/wap/images/cs-2.png" width="26" ></a></div>
                        <div class="clear"></div>
                   </li>
                </ul>
            </div>
        </div>
        <div class="clear"></div>
      	<div class="r_btn"><a href="toMyDonate.action">返回</a></div>
    </div><!--box-->

</body>
</html>

