<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>投稿</title>
<link href="${css }/skins/blue/css/base.css" rel="stylesheet" type="text/css" />

<link href="${css }/skins/blue/css/table_form.css" rel="stylesheet" type="text/css" />
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
	
	
	function saveContribute(){
		var attachmentIds="";
		var attList = $("[name=attachmentIds]");
		for(var i=0;i<attList.length;i++){
			if(i==0){
				attachmentIds+=$(attList[i]).val();
			}else{
				
			attachmentIds+=","+$(attList[i]).val();
			}
		}
		var submitFlag= true;
		var tips = "";
		if($("#title").val()==""){
			submitFlag=false;
			tips="标题不能为空";
		}
		if($("#author").val()==""){
			submitFlag=false;
			tips="作者不能为空";
		}
		if($("#phone").val()==""){
			submitFlag=false;
			tips="电话不能为空";
		}
		
		if($("#content").val()==""){
			submitFlag=false;
			tips="内容不能为空";
		}
		if(submitFlag){
			$.post("/contributeFront/save.action",{attachmentIds:attachmentIds,title:$("#title").val(),author:$("#author").val(),phone:$("#phone").val(),partners:$("#partners").val(),address:$("#address").val(),content:$("#content").val()},function(e){
				alert("投稿成功");
				window.location.reload();
			},"text");
		}else{
			alert(tips);
		}
		
		
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
    	
        <div class="form_item div_title_1_1">
			<span class="form_span"><font color="red" id="title_tip">*</font>标题：</span>
			<input type="text" id="title" class="piece" maxlength="100" />
		</div>
		<div class="form_item div_title_1_1">
			<span class="form_span"><font color="red" id="title_tip">*</font>作者：</span>
			<input type="text" id="author" class="piece" maxlength="100" />
		</div>
		<div class="form_item div_title_1_1">
			<span class="form_span"><font color="red" id="title_tip">*</font>电话：</span>
			<input type="text" id="phone" class="piece" maxlength="100" />
		</div>
		<div class="form_item div_title_1_1">
			<span class="form_span">合作单位：</span>
			<input type="text" id="partners" class="piece" maxlength="100" />
		</div>
		<div class="form_item div_title_1_1">
			<span class="form_span">联系地址：</span>
			<input type="text" id="address" class="piece" maxlength="100" />
		</div>
		<div class="form_item div_title_1_1">
			<span class="form_span"><font color="red" id="title_tip">*</font>内容：</span>
			<textarea rows="5" cols="50" id="content"></textarea>
		</div>
		<div class="form_item div_introduce" style="margin-top: 30px;">
			<span class="form_span">附件：</span>
			<c:import url="/common/swfUpload_front.jsp">

				<c:param name="types">*</c:param>
				<c:param name="upload_size">5000</c:param>
				<c:param name="type">3</c:param>
				<c:param name="index">5</c:param>
			</c:import>		
		</div>
		
		
		
		<div class="form_submit">
			<div class="btn_m" onclick="saveContribute();">投稿</div>

		</div>
  </div><!--left_xq-->

   
</div><!--box-->
<div class="clear"></div>
<!--脚部 开始-->
<c:import url="/WEB-INF/page/template/${site.directory }/foot.jsp" />
<!--脚部 结束-->
	
	
</body>
</html>