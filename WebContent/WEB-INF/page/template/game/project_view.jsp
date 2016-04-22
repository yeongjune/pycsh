<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<html>
<head>
   
    <title>${site.name }</title>
   	<meta charset="utf-8" />
    
    <meta name="keywords" content="${site.name } 番禺慈善,番禺慈善会,慈善会,慈善,项目大赛" />
    <meta name="Description" content="广州市番禺区慈善会是立足于番禺，从事公益慈善活动的非营利性社会组织" />
        <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/base.css" />
        <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/index.css" />
        <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/inspages.css" />
        <script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
        <script type="text/javascript" src="/template/${site.directory }/js/jquery-1.8.3.min.js"></script>
        <script type="text/javascript" src="/template/${site.directory }/js/base.js"></script>
        <script type="text/javascript" src="/js/base/util.js"></script>
        <script type="text/javascript">
       	$(function(){
        		loadPo();
        		loadRecord();
        		 loadTerm();
        		 loadSetBack();
        		 $("#_trave").on("click",function(){
        			 $("#one").hide();
        			 $("#two").show();
        			 $(this).addClass("m_b_btn_cur");
        			 $("#_desc").removeClass("m_b_btn_cur");
        		 });
        		 $("#_desc").on("click",function(){
        			 $("#one").show();
        			 $("#two").hide();
        			 $(this).addClass("m_b_btn_cur");
        			 $("#_trave").removeClass("m_b_btn_cur");
        		 });
        	});
        	function loadPo(){
        		$.post("/userSign/getCharityProject.action",{id:"${id}"},function(data){
        			if(data){
        				$("img.fll").attr("src",data.smallPicOriginalUrl);
        				$("div.article").empty().html(data.contents);
        				$("#_pointMoney").empty().html(data.targer);
        				$("div.sponsor").empty().html(" 主办方："+data.company);
        				$("#startTime").html(data.startTimeFormat);
        				var $html='<i class="s_l_fist"></i>';
        				for(var i=2;i<=5;i++){
        					if(i<=data.status){
        						$html+='<i class="s_l_y"></i>';        						
        					}else{        						
        						$html+='<i></i>';        						
        					}
        				}
        				$("div.state_line").empty().append($html);
        			}
        		},"json");
        	}
        	function loadRecord(){ 

        		$.post("/userSign/getCharityMoney.action",{"ids":"${id}"},function(e){

        			for(var item in e){
        				var tmp=e[item];
        				$("#pojMoney").html(tmp.money);
        				$("#pojCount").html(tmp.userCount);
        				
        			}
        			
        		},"json");
        		
        	}
			function submitDonate(){
        		$.post("/projectFront/getSessionUserInfo.action",{},function(e){
        			if(e!=null){
        					if($("#otherMoney").val()!=""){
        						$("#money").val($("#otherMoney").val());
        					}
        					if($("#money").val()==""){
        						alert("请选择捐款金额!");
        					}else{
        						$("#donateForm").submit();
        						
        						lockWindow();
        						art.dialog({
        							top:'15%',
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
        				
        			}else{
        				toLogin();
        			}
        			
        		},"json");
        		
        		
        	}
        	function loadTerm(){
        		$.post("/userSign/loadCharityProjectList.action",{type:1,pageSize:7},function(data){
        			if(data){
        				var $html='';
        				$.each(data.list,function(i,item){
        					if(item.id!="${id}"){
        						$html+='<li>';
            					$html+='<div class="m_b_b_imgbox">';
            					$html+='<img class="fll" src="'+item.smallPicUrl+'" alt="" width="176px" height="120px" />';
            					$html+='<span>'+item.typeName+'</span>';
            					$html+='</div>';
            					$html+='<div class="m_b_b_con fll">';
            					$html+='<h5><a href="/go-project_view.html?id='+item.id+'">'+item.name+'</a></h5>';
            					$html+='<p>'+item.introduce+'</p>';
            					$html+=' <a href="/go-project_view.html?id='+item.id+'">我要捐赠</a>';
            					$html+=' </div>';
            					$html+='</li>';
        					}
        					
        				})
        				$("#_item").append($html);
        			}
        	},"json");
        	}
        	function loadSetBack(){
            	$.post("/userSign/getCharityRecord.action",{id:"${id}"},function(data){
            		if(data){
            			var $html='';
            			$.each(data,function(i,item){
            				$html+='<li>';
            				$html+='<p class="xm_title">'+item.contents+'</p>';
            				$html+='<div class="m_b_time">'+item.createTimeFormat+'</div>';
            				$html+='</li>';
            			});
            			$("ol.m_b_b_xm").append($html);
            		}
            	},"json");
            }
        </script>
</head>
<body>
           <jsp:include page="head.jsp"></jsp:include>
        <!-- header结束 -->

        <div class="main wrap">
            <div class="main_top">
                <img class="fll" src="/template/${site.directory }/images/img02.jpg" alt="" width="560px" height="281px" />
                <div class="m_t_de fll">
                    <!-- 募款状态 -->
                    <div class="m_t_de_top">
                        <div class="state fll">状态</div>
                        <span>
                            <b>发起</b>
                            <b>审核</b>
                            <b>募款</b>
                            <!-- class="m_t_de_cur" -->
                            <b >执行</b>
                            <b class="m_t_de_no" style="padding-right:0;">发起</b>
                            <div class="state_line"><!-- 状态条 -->
                              <!--   <i class="s_l_fist"></i>
                                class="s_l_y"
                               
                                <i></i>
                                <i></i>
                                <i></i> -->
                                <div class="clear"></div>
                            </div>
                        </span>
                    </div>

                    <div class="m_t_de_bottom">
                        <span class="m_t_de_target">
                            <div class="btn btn_green">目标</div>
                            <b id="_pointMoney">1000000</b> 元
                        </span>
                        <span class="m_t_de_now">
                            <div class="btn btn_orange">已筹</div>
                            <b id="pojMoney">0</b> 元
                        </span>
                        <div class="m_t_line">
                            <div class="m_t_line_green"></div>
                        </div>
                        <div class="m_t_de_time">
                            时间：<span id="startTime">2015-7-30</span>
                        </div>
                        <div class="m_t_de_tip">
                            募款结束，项目执行中，敬请关注！
                        </div>
                        <p class="fll">已有<span id="pojCount"></span>人捐款</p>
                        <a href="javascript:submitDonate();">我要捐赠</a>
                    </div>
                </div>
            </div>
  

            <div class="main_bottom">
                <div class="main_bottom_left fll">
                    <div class="m_b_top">
                        <div class="m_b_btn m_b_btn_cur" id="_desc">
                            募助说明
                        </div>
                        <div class="m_b_btn" id="_trave" style="margin-left:-1px;">
                            项目进展
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="m_b_bottom" id="one">
                       <div class="article">
                             </div>
                        <div class="sponsor">
                             主办方：中国运动员教育基金会
                        </div>
                    </div>
                     
                    <div class="m_b_bottom" id="two" style="display: none;">
                        <ol class="m_b_b_xm">
                            
                        </ol>
                    </div>
                    <div class="clear"></div>
                </div>
                
                <div class="main_bottom_right flr">
                    <div class="m_b_top">
                        <div class="m_b_btn m_b_btn_cur">
                            可能关注
                        </div>
                        
                        <div class="clear"></div>
                    </div>
                    <div class="m_b_bottom">
                        <ul id="_item">
                            
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
            <div class="clear"></div>
        </div>
        <!-- main结束 -->
	<jsp:include page="foot.jsp"></jsp:include>
    </body>
</html>
