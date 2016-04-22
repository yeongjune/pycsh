<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport"/>
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style"/>
    <meta content="telephone=no" name="format-detection"/>
    <link rel="shortcut icon" type="image/x-icon" href="/template/${site.directory }/images/title.ico"/>
    <link rel="shortcut icon" type="image/x-icon" href="images/iliubang.ico"/>
    <title>报名页面</title>
    <link rel="stylesheet" type="text/css" href="/skins/wap/css/base.css"/>
    <script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/js/base/util.js"></script>
    <style type="text/css">
        tr{line-height: 60px;}
        td.title{width: 120px;}
        td .r_m_input{
            border: 1px solid #DDD;
            width: 90%;
            margin: 0 auto;
            height: 32px;
        }
        td .left_j{
            font-size: 16px;
            float: left;
            width: 120px;
            text-align: right;
        }
        td .r_m_input input{
            border: 0;
            width: 100%;
            line-height: 30px;
            height: 30px;
            padding: 0;
            font-size: 14px;
            color: #555;
        }
    </style>
    <script type="text/javascript">

        function submitDonate() {
            if ($("#otherMoney").val() != "") {
                $("#money").val($("#otherMoney").val());
            }
            if ($("#money").val() == "") {
                alert("请选择捐款金额!");
            } else {
                $.post("/donateFront/saveDonateRecord.action", $("#donateForm").serialize(), function (e) {
                    if (e == "ok") {
                        alert("捐款成功!");
                        art.dialog.close();
                    } else if (e == "notLogin") {
                        art.dialog.open('/weixinUser/toLoginByMini.action', {
                            title: "登录",
                            width: 'auto',
                            height: 'auto',
                            close: function () {

                            }
                        });
                    }
                }, "text");
                //$("#donateForm").submit();
            }
        }

        function selectMoney(emt, money) {
            $(".do_list").find("a").removeAttr("style");
            $(".do_list").find("font").attr("class", "orange");

            $(emt).css("background", "#ffa800");
            $(emt).css("color", "#FFF");
            $(emt).find("font").attr("class", "");
            $("#otherMoney").val("");
            $("#money").val(money);
        }

        function onlyNum() {
            if (!(event.keyCode == 46) && !(event.keyCode == 8) && !(event.keyCode == 37) && !(event.keyCode == 39))
                if (!((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105)))
                    event.returnValue = false;
        }

        function donate() {
        	
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
        	if($("#phone").val().length!=11){
        		checkFlag=false;
        		tips="手机号码不正确!";
        	}
        	if($("#otherMoney").val()==""&&$("#money").val()==""){
        		checkFlag=false;
        		tips="请输入捐款金额!";
        	}
        	
        	if(checkFlag){
        		
    		
    					 if ($("#otherMoney").val() != "") {
    	                      $("#money").val($("#otherMoney").val());
    	                  }
    	                  if ($("#xyCheck").attr("checked") == "checked" || $("#xyCheck").attr("checked") == true) {
    	                      window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8ac5c7d84d8a17a5&redirect_uri=${WebHosts}wxpay/toSelectPay.action&response_type=code&scope=snsapi_base&state=" + $("#money").val() + "-${id}-${sessionScope.weixinUser.id}-"+$("#name").val()+"-"+$("#phone").val()+"-"+$("#idcard").val()+"-"+$("#exPhone").val()+"#wechat_redirect";
    	                  } else {
    	                      alert("捐款前必须同意协议!");
    	                  }
    
 
        		 
        	}else{
				alert(tips);
			}
        	
          
        }

        function lockDiv(divId) {
            //$("#"+divId).css("background-color",null);

        }

        function openDiv() {

            $('#lockDiv').remove();
            $('#lockDivContent').remove();
        }

        function viewText() {
            window.location.href = "/go-article_view.html?id=13216";
        }

        function checkDon() {
            if ($('#xyCheck').attr('checked') == "checked" || $('#xyCheck').attr('checked') == true) {
                $('#xyCheck').attr('checked', false);
            } else {
                $('#xyCheck').attr('checked', true);
            }
        }

    </script>

</head>
<body class="bj">
<div style="background: #FFF; padding-top: 10%;height: 100%;">
    <table style="width: 100%; border: 0;">
        <tr>
            <td class="title"><div class="left_j">姓名(<span class="red">*</span>)</div></td>
            <td>
                <div class="r_m_input">
                    <input type="text" name="name" id="name"/>
                </div>
            </td>
        </tr>
        <tr>
            <td class="title"><div class="left_j">手机号码(<span class="red">*</span>)</div></td>
            <td>
                <div class="r_m_input">
                    <input type="text" name="phone" id="phone"  onkeydown="onlyNum();" onfocus="putMoney();" />
                </div>
            </td>
        </tr>
        <tr>
            <td class="title"><div class="left_j">身份证号码</div></td>
            <td>
                <div class="r_m_input">
                    <input type="text" name="idcard" id="idcard"/>
                </div>
            </td>
        </tr>
        <tr>
            <td class="title"><div class="left_j">紧急联系人电话</div></td>
            <td>
                <div class="r_m_input">
                    <input type="text" name="exPhone" id="exPhone"/>
                </div>
            </td>
        </tr>
    </table>
    <div class="line"></div>
    <div class="do_tip">小善大爱，爱是一种情怀！</div>
    <div class="do_list">
        <a href="javascript:void(0);" onclick="selectMoney(this,10);"><font class="orange">10</font>元</a>
        <a href="javascript:void(0);" onclick="selectMoney(this,20);"><font class="orange">20</font>元</a>
        <a href="javascript:void(0);" onclick="selectMoney(this,50);"><font class="orange">50</font>元</a>
        <a href="javascript:void(0);" onclick="selectMoney(this,100);" style=" margin:0"><font
                class="orange">100</font>元</a>

        <div class="clear"></div>
    </div>
    <input type="hidden" name="money" id="money"/>
    <input type="hidden" name="projectId" value="${id }"/>

    <div class="do_input"><input type="text" id="otherMoney"
                                 onfocus="$('.do_list').find('a').removeAttr('style');$('.do_list').find('font').attr('class','orange');"
                                 onkeydown="onlyNum();" style="ime-mode:Disabled"/>
        <div class="yuan">元</div>
    </div>
    <div class="j_btn" style=" margin:10px auto;"><a href="javascript:void(0);" onclick="donate();">我要报名</a></div>
    <div class="ty_g"><a href="javascript:void(0);" onclick="checkDon();"><input onclick="event.stopPropagation();"
                                                                                 checked="checked" type="checkbox"
                                                                                 value="" id="xyCheck">同意</a><a
            href="javascript:void(0);" onclick="viewText();">《番禺慈善会公益用户协议》</a></div>
</div>
</body>

</html>