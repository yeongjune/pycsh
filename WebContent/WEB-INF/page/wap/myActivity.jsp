<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport"/>
    <meta content="yes" name="apple-mobile-web-app-capable"/>
    <meta content="black" name="apple-mobile-web-app-status-bar-style"/>
    <meta content="telephone=no" name="format-detection"/>
    <link rel="stylesheet" type="text/css" href="/skins/wap/css/base.css"/>
    <script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/js/base/util.js"></script>
    <title>活动查询</title>
    <script type="text/javascript">
        $(function () {
            //getUserInfo();
            loadByPage('/activityFront/loadMyList.action', {}, loadList);
            //loadMySum();
        });

        function loadList(list) {
            if (list.length != 0) {
                $("#donateDiv").hide();
            } else {
                $("#recordDiv").hide();
                $("#donateDiv").show();
            }
            $("#idsDiv").html("");
            //$('#tableBody').html("");
            for (var item in list) {
                var poj = list[item];
                var html = "";

                html = "";
                html += '<li>';
                html += '<div class="re_w">';

                html += '<div class="i_l_img"><img src="' + poj.smallPicUrl + '" width="108"></div>';
                html += '<div class="i_l_text">';
                html += '	<div class="i_l_t_t">' + poj.name + '</div>';
                html += '   <div class="q_y">报名人:'+poj.recordName+' 已捐赠 <font class="orange">'+ poj.sumMoney + '</font>元</div>';
                html+='  <div class="clear"></div>';
                html+='  序列号: '+poj.code.substring(0,4)+'-'+poj.code.substring(4,8)+'-'+poj.code.substring(8,12)+'-'+poj.code.substring(12,16);
                html+='  <div class="clear"></div>';
                html += '   <div class="q_time">' + poj.startTimeFormat + '至 '
                + poj.endTimeFormat + '<strong></strong></div>';
                html += '  <div class="i_l_h">';
                // html+='  	<div class="block left">慈善捐助</div> ';
                html += '  </div>';

                html += '</div>';
                html += '<div class="clear"></div>';
                html += '   <div class="q_j_r"><img src="/skins/wap/images/q_j.jpg" width="12" ></div>';
                html += '</div>';
                html += '<div class="q_line" id="lineDiv' + poj.id + '" style="display: none;"></div>';
                html += '<div class="q_l_two">';

                html += '<ul class="recordUl" id="recordTd' + poj.id + '"></ul>';
                html += '</div>';
                html += '</div>';

                html += '<div class="clear"></div>';
                html += ' </li>';

                $('#tableBody').append(html);
                if ($("#pageBtn").html() != ""
                	&& params_cache != null && params_cache.params != null
                        && params_cache.params.currentPage != params_cache.totalPage) {
                    $("#nextBtn").show();
                } else {
                    $("#nextBtn").hide();
                }
            }
        }

        function loadMySum() {
            $.post("/activityFront/loadRecordCount.action", {}, function (sum) {
                $("#recordSum").html(sum);
            });
        }

        function getUserInfo() {
            $.post("/projectFront/getSessionUserInfo.action", {}, function (e) {

                if (e != null) {
                    $("#userImg").attr("src", e.img);
                    var userName = "";
                    if (record.name == null) {
                        userName = e.loginName.substring(0, 4) + "*****"
                        + e.loginName.substring(9, 11);
                    } else {
                        userName = e.name;
                    }
                    $("#userName").html(userName);
                } else {
                    art.dialog.open('/weixinUser/toLoginByMini.action', {
                        title: "登录",
                        width: 'auto',
                        height: 'auto',
                        close: function () {
                            window.location.reload();
                        }
                    });
                }

            }, "json");
        }
    </script>

</head>

<body class="bj" onclick="$('.recordUl').html('');$('.q_line').hide();">
<div class="box ">
    <div class="m_one">
        <dl class="q_head">
            <dt>
                <img src="${userInfo.imgUrl }" width="70"/>
            </dt>
            <dd>
                <span class="font_16">${userInfo.name }</span><br/>${userInfo.loginName }
            </dd>
            <div class="q_j">
                <a href="toUserInfo.action"><img
                        src="/skins/wap/images/cs-2.png" width="25"/></a>
            </div>
        </dl>
        <div class="clear"></div>
    </div>
    <div class="clear"></div>

    <div id="recordDiv">
        <div class="q_list">
            <ul id="tableBody">


            </ul>
        </div>
    </div>
    <!--box-->
    <a href="javascript:void(0);" onclick="nextPage();" id="nextBtn"
       class="block"
       style="display: none; height: 50px; width: 100%; text-align: center; line-height: 50px; font-size: 16px; margin-left: 0px;">加载更多</a>
</div>
<div id="donateDiv" style="display: none;">
    <div class="q_list_none">
        <img src="/skins/wap/images/qu_03.jpg" width="100"/>

        <div class="none">暂无活动记录</div>
    </div>
    <div class="download_msg" style="background: none; border: 0;">
        <div class="j_btn" style="margin: 0 auto">
            <a href="/wxUser/toActivityIndex.action">我要报名</a>
        </div>

    </div>
</div>

<div style="display: none;" class="table_under_btn">
    <div class="flip" id="pageBtn"></div>
</div>
</body>
</html>
