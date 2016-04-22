<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>慈善捐款</title>
<script type="text/javascript">

function onBridgeReady(){
	   WeixinJSBridge.invoke(
	       'getBrandWCPayRequest', {

	           appId : "${requestParams.appId}",     //公众号名称，由商户传入
	           timeStamp:"${requestParams.timeStamp}",         //时间戳，自1970年以来的秒数
	           nonceStr : "${requestParams.nonceStr}", //随机串
	           package : "${requestParams.packageStr}",
	           signType : "MD5",         //微信签名方式：
	           paySign : "${requestParams.paySign}" //微信签名

	       },
	       function(res){     
	    	  
	           if(res.err_msg == "get_brand_wcpay_request:ok" ) {
	        	   alert("捐赠成功!");
	        	 window.location.href="/wxUser/toIndex.action";
	           }     // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。 
	       }
	   ); 
	}
	if (typeof WeixinJSBridge == "undefined"){
	   if( document.addEventListener ){
	       document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
	   }else if (document.attachEvent){
	       document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
	       document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
	   }
	}else{
	   onBridgeReady();
	}

</script>
</head>
<body>

</body>
</html>