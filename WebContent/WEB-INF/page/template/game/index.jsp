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
         <script type="text/javascript" src="/template/${site.directory }/js/jquery-1.8.3.min.js"></script>
        <script type="text/javascript" src="/template/${site.directory }/js/base.js"></script>
        </head>
<script type="text/javascript">
    var page={
    		current:1,
    		size:4,
    		next:true
    }
	$(function(){
		load();
		loadDonation();
	});
    function load(){
		$.post("/userSign/loadCharityProjectList.action",{type:page.type,currentPage:page.current,pageSize:page.size},function(data){
			if(data){
				var $html='';
				var $aonther='';
				page.current=data.currentPage;
				page.next=data.hasNext;
				if(!page.next){
					$("#more").empty().html("没有更多项目了");
				}
				$.each(data.list,function(i,item){
					var statusStr = "";
					switch (item.status) {
					case 1:
						statusStr="发起";
						break;
					case 2:
						statusStr="审核中";
						break;
					case 3:
						statusStr="募款中";
						break;
					case 4:
						statusStr="执行中";
						break;
					case 5:
						statusStr="结束";
						break;

					default:
						break;
					}
					$html+=' <li>';
					$html+='<div class="m_l_imgbox">';
					$html+='<img src="'+item.smallPicUrl+'" alt="" width="322px" height="219px" />';
					$html+='<span>'+statusStr+'</span>';
					$html+=' </div>';
					$html+=' <div class="m_l_title"><h2><a href="/go-project_view.html?id='+item.id+'">'+item.name+'</a></h2><span>'+item.typeName+'</span><div class="clear"></div></div>';
					$html+=' <p>'+item.introduce+'</p>';
					$html+='<div class="info">';
					$html+='<div class="info_time fll">'+item.startTimeFormat+'</div>';
					$html+='<div class="info_r flr">'+item.company+'</div>';
					$html+=' <div class="clear"></div>';
					$html+='</div>';
					$html+='<div class="m_l_b">';
					$html+='<b>已筹<span id="pojMoney'+item.id+'" >0</span>元</b>&nbsp;&nbsp;<b>已有<span id="pojCount'+item.id+'">0</span>人捐款</b>';
					$html+='</div>';
					if(item.status==3){
					$html+='<div class="m_l_btn" onclick="javascript:toDonation('+item.id+')">我要捐款</div>';												
					}else{
					$html+='<div class="m_l_btn btn_end">我要捐款</div>';												
					}
					$html+='</li>';
					$aonther+='<input type="hidden" name="ids" value="'+item.id+'" />';
				});
				$("#_point").append($html);
				$("#idsDiv").empty().append($aonther);
			}
			loadRecord();
		},"json");
    }
    function loadMore(){
    	if(page.next){
			page.current++;
    		load();
    	}
     }
    function toDonation(id){
    	window.location.href="/go-project_view.html?id="+id;
    }
	var cp = 1 ;
	
    function loadDonation(){
    	$.post("/donateFront/loadDonateList.action",{currentPage:cp,pageSize:10},function(data){
    		if(data){
    			if(data.totalPage<=cp){
    	  	    	cp=1;
    	  	    }else{
    	  	    	cp++;
    	  	    }
    			toLoad(data.list);
    	    	window.setTimeout("loadDonation()",8000);
    		}
    	},"json");
    }
    function toLoad(list){
    	var $html='';
		$.each(list,function(i,item){
			var userName ="";
			if(item.name==null){
				userName=item.loginName.substring(0,4)+"*****"+item.loginName.substring(9,11);
			}else{
				userName=item.name.substring(0,item.name.length-1)+"*";
			}
			$html+='<li>';
			$html+=' <span class="name">'+userName+'</span>';
			$html+=' <span><b>￥'+item.money+'</b>元</span>';
			$html+=' <span class="m_r_time">'+item.createTimeFormat+'</span>';
			$html+='</li>';
		});
		$("#donateBody").append($html);
    }
    function loadRecord(){

    	$.post("/userSign/getCharityMoney.action",$("#recordForm").serialize(),function(e){

    		for(var item in e){
    			var tmp=e[item];
    			$("#pojMoney"+tmp.projectId).html(tmp.money);
    			$("#pojCount"+tmp.projectId).html(tmp.userCount);
    		}
    		
    	},"json");
    	
    }
    function addDonate(projectId,name){
		lockWindow();
		if(name==null){
			name="慈善捐款";
		}
		art.dialog.open('/donateFront/toDonate.action'+(projectId==null ? '' : '?projectId='+projectId),{
			top:'15%',
			title:name,
			id:"donatedialog",
			width:'auto',
			height:'auto',
			close:function(){
				loadRecord();
				openLock();
				getUserInfo();
			}
		});
	}
</script>
<body>
       <jsp:include page="head.jsp"></jsp:include>
        <!-- header结束 -->

        <!-- banner结束 -->

        <div class="main wrap">
            <div class="main_left fll">
            	<div style="margin-top: 6px;">
            		<img alt="" src="/template/${site.directory }/images/ad.jpg">
            	</div>
                <ul id="_point">
                	
                </ul>
                <div class="clear"></div>
                <a href="javascript:loadMore();" id="more">更多捐赠</a>
            </div>
            
            <!-- 左边列表结束 -->

            <div class="main_right flr">
                <div class="m_r_top">
                    <div class="m_r_t_tel">
                        <h3>020-34608222</h3>
                        捐赠电话
                    </div>
                    <div class="m_r_t_card">
                        <h3>12800851601000683</h3>
                        广发银行广州平康路支行账户
                    </div>
                    <a href="javascript:void(0);" onclick="javascript:addDonate();">我要捐赠</a>
                </div>
                <!-- 捐赠方式结束 -->

                <div class="m_r_bottom">
                    <p>捐赠列表</p>
                   <div class="m_r_bottom_box" >
                       <ul id="donateBody" style="position: relative;">
                       		
                        </ul>
                    </div>
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
                <!-- 捐赠名单结束 -->
            </div>
            <div class="clear"></div>
  
        </div>
        <form id="recordForm" method="post">
				<div id="idsDiv" style="display: none;"></div>
			</form>
        <!-- main结束 -->
	<jsp:include page="foot.jsp"></jsp:include>
    </body>
</html>
