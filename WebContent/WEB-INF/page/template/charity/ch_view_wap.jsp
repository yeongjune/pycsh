<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<link rel="shortcut icon" type="image/x-icon" href="/template/${site.directory }/images/title.ico"/>
<link rel="shortcut icon" type="image/x-icon" href="images/iliubang.ico"/>
<title>大赛页面</title>
<link rel="stylesheet" type="text/css" href="/skins/wap/css/base.css" />
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/base/util.js"></script>
<!-- 弹出框引入 -->
<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<style type="text/css">

.download_msg2{width:100%; border-top: 1px solid #dedede;position: fixed; bottom: 0px;cursor: pointer;text-align:center;padding:5px 0px;}
.m_o_tr{ font-size:16px; color:#000; line-height:20px; padding:8px 5px 8px 10px; text-align: right;float: right;}
.m_o_tl{ font-size:16px; color:#000; line-height:20px; padding:8px 5px 8px 10px; text-align: left;float: left;margin-right: 20px;}
</style>
<script type="text/javascript">
	
	var projectName="";
$(function(){
	
	loadByPage('/projectFront/loadRecordList.action',{"projectId":"${id}"},loadList);
	
	$.post("/projectFront/getProject.action",{"id":"${id}"},function(e){
		projectName=e.name;
		$("#projectContents").html(e.contents);
		$("#projectImg").attr("src",e.smallPicOriginalUrl);
		$(".m_o_text").find("img").css("max-width","100%");
		$("#pojName").html(projectName);
		$("#pojType").html(e.typeName);
	},"json");
	
	
	loadRecord();
});
	
	
	
	
	function loadList(list){


		for(var item in list){
			var record = list[item];
			var html="";
			var userName = "";
			if(record.name==null){
				userName=record.loginName.substring(0,4)+"*****"+record.loginName.substring(9,11);
			}else{
				userName=record.name.substring(0,record.name.length-1)+"*";
			}
			html+='<tr>';
			html+='<td>'+userName+'</td>';
			html+='<td>￥'+record.money+'元</td>';
			html+='<td>'+record.createTimeFormat+'</td>';	
			html+='</tr>';
			
			html="";
			html+='<div class="m_o_text">';
			html+='<div class="m_j_c">'+userName+'</div><div class="m_j_c center"><font class="orange">￥ '+record.money+'</font>元</div><div class="m_j_c right_t">'+record.createTimeFormat+'</div>';
			html+='<div class="clear"></div>';
			html+='</div>';
			
			$('#tableBody').append(html);
			

		}
		if($("#pageBtn").html()!=""&&params_cache.params!=null&&params_cache.params.currentPage!=params_cache.totalPage){
			$("#nextBtn").show();
		}else{
			$("#nextBtn").hide();
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
			title:"慈善项目-"+projectName,
			width:'auto',
			height:'auto',
			close:function(){
				loadRecord();
			}
		});
	}
	
	

	function submitDonate(){
		if($("#otherMoney").val()!=""){
			$("#money").val($("#otherMoney").val());
		}
		if($("#money").val()==""){
			alert("请选择捐款金额!");
		}else{
			$.post("/donateFront/saveDonateRecord.action",$("#donateForm").serialize(),function(e){
				if(e=="ok"){
					alert("捐款成功!");
					art.dialog.close();
				}else if(e=="notLogin"){
					art.dialog.open('/weixinUser/toLoginByMini.action',{
						title:"登录",
						width:'auto',
						height:'auto',
						close:function(){
							
						}
					});
					
				}
				
			},"text");
			//$("#donateForm").submit();
		}
		
	}

	function selectMoney(emt,money){
		$(".do_list").find("a").removeAttr("style");
		$(".do_list").find("font").attr("class","orange");
		
		
		$(emt).css("background","#ffa800");
		$(emt).css("color","#FFF");
		$(emt).find("font").attr("class","");
		$("#otherMoney").val("");
		$("#money").val(money);
	}

	function onlyNum() {
	    if(!(event.keyCode==46)&&!(event.keyCode==8)&&!(event.keyCode==37)&&!(event.keyCode==39))
	    if(!((event.keyCode>=48&&event.keyCode<=57)||(event.keyCode>=96&&event.keyCode<=105)))
	    event.returnValue=false;
	}
	
	function showDonate(){
		$("#donateDiv").show();
		
	}
	
	function hideDonate(){
		$("#donateDiv").hide();
		
	}
	
	function donate(){
		if($("#otherMoney").val()!=""){
			$("#money").val($("#otherMoney").val());
		}
		if($("#xyCheck").attr("checked")=="checked"||$("#xyCheck").attr("checked")==true){
			
			window.location.href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8ac5c7d84d8a17a5&redirect_uri=${WebHosts}wxpay/toSelectPay.action&response_type=code&scope=snsapi_base&state="+$("#money").val()+"-${id}-${sessionScope.weixinUser.id}#wechat_redirect";

			
			
			
		}else{
			alert("捐款前必须同意协议!");
		}
	}
	
	function lockDiv(divId){
		//$("#"+divId).css("background-color",null);
	
	}
	
	function openDiv(){
		
		$('#lockDiv').remove();
		$('#lockDivContent').remove();
	}
	
	
	function viewText(){
		
		window.location.href="/go-article_view.html?id=13216";
	}
	
	function checkDon(){
		if($('#xyCheck').attr('checked')=="checked"||$('#xyCheck').attr('checked')==true){
			$('#xyCheck').attr('checked',false);
		}else{
			$('#xyCheck').attr('checked',true);
		}
	}
	
</script>

</head>
<body class="bj">
	<div class="box" onclick="hideDonate();" style="margin-bottom: 60px;" id="viewDiv">
        <div class="i_b"><img onerror="this.src='/skins/images/projectSmall.jpg';" src="" id="projectImg" width="100%"></div>
        <div class="j_nav">
        	<div class="j_t"><font class="left" id="pojName"></font><div class="block  left" id="pojType"></div><div class="clear"></div></div>
            <div class="line"></div>
        	<a>已投票人数<font class="orange"><span id="pojMoney"></span></font>人</a>
        </div>
        
        <div class="m_one">
            <div class="m_o_t">项目详情</div>
            <div class="m_o_text" id="projectContents">
            	
            </div>
            <div class="line" style=" margin-top:10px;" ></div>
          
        </div>
        
    </div><!--box-->
<div class="download_msg" id="donateBtn">
		<div class="j_btn" style=" margin:0 auto"><a href="javascript:void(0);" onclick="addPoint();">我要投票</a></div>
</div>
</body>
<script type="text/javascript">
	function addPoint(){
		$.post("/pointRecord/save.action",{"pid":"${id}"},function(data){
			if(data=="noLogin"){
				art.dialog.open('/weixinUser/toLoginByMini.action',{
					title:"登录",
					width:'auto',
					height:'auto',
					close:function(){
						
					}
				});
			}else if(data=="already"){
				art.dialog.alert("已经投过票了");
			}else{
				art.dialog.alert("投票成功");
			}
		},"text");
	}
	
</script>
</html>