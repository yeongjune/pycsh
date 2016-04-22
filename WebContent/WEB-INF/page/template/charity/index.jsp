<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta charset="utf-8" />
    <title>广州市番禺区慈善会-首页</title>
    <meta name="keywords" content="${site.name } 番禺慈善,番禺慈善会,慈善会,慈善" />
    <meta name="Description" content="广州市番禺区慈善会是立足于番禺，从事公益慈善活动的非营利性社会组织" />
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/index.css" />
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/slide.css" />
    <link rel="shortcut icon" type="image/x-icon" href="/template/${site.directory }/images/title.ico"/>
    <script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/template/${site.directory }/js/slide.js"></script>
	<script type="text/javascript" src="/js/base/util.js"></script>
	<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
	<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>
<script type="text/javascript">
    $(function(){
    	 $.post("/donateFront/loadDonateList.action",{"pageSize":10,"currentPage": cp},function(e){
 	    	if(e.totalPage<=cp){
 	  	    	cp=1;
 	  	    }else{
 	  	    	cp++;
 	  	    }
 	    	loadList(e.list);
 	    	loadDonate();
 	    	
 	    },"json");
    	//loadByPage('/wxUser/loadNewsList.action',{"pageSize":3},loadNewsList);
    	loadByPage('/projectFront/loadList.action',{"pageSize":4,status:1},loadPojectList);
    	//多余字体用省略号
		var maxwidth1=35;
		var one_new = $(".one_new");
		one_new.each(function(){
			if($(this).html().length>maxwidth1){
				$(this).html($(this).html().substring(0,maxwidth1)+"...");
			}
		});
    	//多余字体用省略号
		var maxwidth2=80;
		var introduce = $(".introduce");
		introduce.each(function(){
			if($(this).html().length>maxwidth2){
				$(this).html($(this).html().substring(0,maxwidth2)+"...");
			}
		});
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
			html+='<li><span style=" white-space: nowrap;text-overflow: ellipsis;overflow: hidden;">'+userName+'</span><span><font class="orange_2">￥ '+record.money+'</font>元</span><span class="t_right">'+record.createTimeFormat+'</span></li>';
			
	        $('#donateBody').append(html);

	       
			

		}
		 

	}
	var cp = 1 ;
	function loadDonate(){
	  
	    
	    $.post("/donateFront/loadDonateList.action",{"pageSize":10,"currentPage": cp},function(e){
	    	if(e.totalPage<=cp){
	  	    	cp=1;
	  	    }else{
	  	    	cp++;
	  	    }
	    	loadList(e.list);
	    	window.setTimeout("loadDonate()",30000);
	    	
	    },"json");

	}
	

	
	function loadNewsList(list){
		for(var item in list){
			var are = list[item];
			var html="";
		
			
			html+='<li>';
			html+='<dl>';
        	html+=' <dt><img src="'+are.smallPicOriginalUrl+'" width="115" height="70"></dt>';
                html+=' <dd>';
                html+=' <span>'+are.title+'</span>';
                    html+=are.introduce+'...';
                    html+=' </dd>';
                    html+='</dl>';
            html+='<div class="clear"></div>';
            html+='</li>';
		
	        $('#newBody').append(html);


		}

	}
	
	function loadPojectList(list){
		$("#idsDiv").html("");
		for(var item in list){
			var poj = list[item];
			var html="";
			var statusStr = "";
			switch (poj.status) {
			case 1:
				statusStr="发起";
				break;
			case 2:
				statusStr="审核";
				break;
			case 3:
				statusStr="募款";
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
			
			html+='<li>';
			html+=' <div class="list_mode">';
            html+='<dl class="l_l" onclick="toProject('+poj.id+')">';
            html+=' <dt><img src="'+poj.smallPicUrl+'" onerror="/template/${site.directory }/images/img.jpg" width="160" height="140"></dt>';
            html+=' <dd>';
            html+='<div class="title">';
            html+='   <div class="t_font overflow">'+poj.name+'</div>';
            html+='   <div class="tip left">'+poj.typeName+'</div>';
            html+=' </div>';
            html+='  <div class="clear"></div>';
            html+=poj.introduce;
            html+='    <div class="t_time">'+poj.startTimeFormat+' 至 '+poj.endTimeFormat+' 　　'+(poj.organization ==undefined ? '' :poj.organization)+'</div>';
            html+='  </dd>';
            html+='  </dl>';
            html+=' </div><!--list_mode-->';
            html+=' <div class="right_m">';
            html+='<div class="one_m">';
            html+='项目状态 :  <font class="orange_2">'+statusStr+'</font><br>';
            html+=' 已筹 <font class="orange_2" id="pojMoney'+poj.id+'" >0</font> 元<br>';
            html+='  已有 <font class="orange_2" id="pojCount'+poj.id+'">0</font> 人捐款<br>';
            html+=' </div>';
            html+='  <div class="btn_m" onclick="addDonate('+poj.id+',\''+poj.name+'\')">我要捐赠</div>';
            html+='</div>';
          	html+='<div class="clear"></div>';
          	html+='</li>';
		
	        $('#projectBody').append(html);
	        html="<input type='hidden' name='ids' value='"+poj.id+"'/>";
			$("#idsDiv").append(html);
			if($("#pageBtn").html()!=""&&params_cache.params!=null&&params_cache.params.currentPage!=params_cache.totalPage){
				$("#nextBtn").show();
			}else{
				$("#nextBtn").hide();
			}

		}
		loadRecord();
	}
	
	
	function loadRecord(){

		$.post("/projectFront/loadRecordStatistics.action",$("#recordForm").serialize(),function(e){

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
	
	function toProject(id){
		window.location.href="/go-project_view.html?id="+id;	
	}
    
</script>
<style type="text/css">
.i_one_n a:hover{ color:#409c5a; text-decoration: underline}
</style>	
</head>
<body>
<!--头部 开始-->
<c:import url="/WEB-INF/page/template/${site.directory }/head.jsp" />
<!--头部 结束-->
<!--bannre 开始-->
	<div class="s_s_d">
	<div class="s_img_z"></div>
       <div class="Slideshow_s">
	       <ul>
		         <c:forEach items="${小幻灯片}" var="item">
		           	<li title="${item.title}"><a <c:if test="${fn:contains(item.title2,'/go-game_index.html')==true }">target="_blank"</c:if> href="${item.title2}" ><div class="s_s_imgD"> <img src="${item.smallPicOriginalUrl}"></div></a></li>
		           	<!--<li title="${item.title}"><a href="/article-${item.id }.html"><div class="s_s_imgD"> <img src="${item.smallPicUrl}"></div></a></li>-->
		    	</c:forEach>                                
	       </ul>
       <div class="clear"></div>
       <!--小的幻灯片数字 开始-->
       <div class="Slideshow_num">
           <a class="s_s_Description overflow">${小幻灯片[0].title}</a>
           <div class="Slideshow_num_d">
	           <ul>
			       <c:forEach items="${小幻灯片}" var="item" varStatus="vs">
			       	<li><a show_title="${item.title}" class="num_icon <c:if test="${vs.first}">num2</c:if>" href="javascript:void(0);"></a></li>
			       </c:forEach>                                        
	           </ul>
               <div class="clear"></div>
          </div>
          <div class="clear"></div>
       </div>
	   <script type="text/javascript">
			new ImageSlide($('.s_s_d .Slideshow_s > ul')
		        , $('.s_s_d .Slideshow_num_d > ul')
		        , function(index){
		            $('.s_s_d .Slideshow_num_d > ul > li').each(function(i){
		            	
		                $(this).find('a').removeClass('num2');
		                if(index == i)
		                    $(this).find('a').addClass('num2');
		                //切换标题
		                $(".s_s_Description").html($(this).find('.num2').attr("show_title"));
		            });
		        });
		</script>                                
            <!--小的幻灯片数字 结束-->
   		</div>
	</div><!--s_s_d-->
<!--bannre 结束-->     

<div class="box">
	
    <div class="roll">
        <ul>
        </ul>
    </div><!--roll-->
    <%--首页新闻列表start --%>
    <div class="left_list">
    	<dl class="i_one_n">
        	<dt><img src="${首页新闻1[0].smallPicUrl}" width="245" height="180"></dt>
            <dd>
            	<a class="new_title" href="/article-${首页新闻1[0].id}.html"><span>${首页新闻1[0].title}</span></a>
            	${首页新闻1[0].introduce}
                <a href="/article-${首页新闻1[0].id}.html">[详情]</a>
            </dd>
        </dl>
        <div class="clear"></div>
        <div class="i_o_list">
        	<ul>
                <c:forEach items="${首页新闻1}" var="item" varStatus="v">
                	<c:if test="${v.index!=0 }">
            		<li><a href="/article-${item.id }.html" class="left_i one_new" title="${item.title}">${item.title}</a><span><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd" /></span><div class=" clear"></div></li>
                    <div class="clear"></div>
                	</c:if>
                </c:forEach>         	
            </ul>
        </div><!--i_o_list-->
        <div class="clear"></div>
    <%--首页新闻列表end --%>
        <DIV class="i_t_list">
        	<ul id="newBody">
                <c:forEach items="${首页新闻2}" var="item" varStatus="v">
                	<li>
                	<dl>
                        <dt><img src="${item.smallPicUrl}" onerror="/template/${site.directory }/images/img.jpg" width="115" height="70"></dt>
                        <dd>
                            <a href="/article-${item.id }.html" class="left_i"><span>${item.title}</span></a>
                            <div class="introduce">${item.introduce}</div>
                        </dd>
                    </dl>
                    <div class="clear"></div>
                	</li>
                </c:forEach>           	
            </ul>
        </DIV>
    </div><!--left_list-->
    
     <div class="right_mode">
     	<div class="charity_info">
          	<div class="ka_o" style="border-bottom: 1px solid #DEDEDE;padding-top:1px;">
                  <div class="ph_img"> <img src="/template/${site.directory }/images/phone.jpg" width="35"></div>
                  <div class="ph_t">020-34608222<br><font class="font_16">捐赠电话</font></div>
                  <div class="clear"></div>
          	</div>
          	<div class="ka_o">
                  <div class="ph_img"> <img src="/template/${site.directory }/images/account.jpg" width="35"></div>
                  <div class="ph_t">128008516010000683<br><font class="font_16">广发银行广州平康路支行账户</font></div>
                  <div class="clear"></div>
          	</div>
            <div class="i_o_btn"><a href="javascript:void(0);" onclick="addDonate();">我要捐赠</a></div>
        </div>
        <div class="clear"></div>
        <div class="o_icon" style=" padding-bottom:0">
        	<div class="j_tit">捐赠列表</div>
            <DIV class="j_list" style="overflow: hidden;height: 290px;">
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
     </div><!--right_mode-->
     <DIV class="clear"></DIV>
 	<div class="b_list"> 
        <ul id="projectBody">
            
            
            
          </ul>
  </div> 
  
  <form id="recordForm" method="post">
				<div id="idsDiv" style="display: none;"></div>
			</form>
  
  <div class="in_m"  onclick="nextPage();" id="nextBtn" style="display: none;"><a href="javascript:void(0);">更多捐赠</a></div>
  
   <div style="display: none;" class="table_under_btn">
			<div class="flip" id="pageBtn">
				</div>
			</div>
  <div class="in_b_th">
  	<a href="${资讯指南[0].url}" class="cyzn">${资讯指南[0].name}</a>
    <a href="${资讯指南[1].url}" class="sqzn">${资讯指南[1].name}</a>
    <a href="${资讯指南[2].url}" class="cwgk" style=" margin-right:0;">${资讯指南[2].name}</a>
    <div class="clear"></div>
  </div>
</div><!--box-->


<!--脚部 开始-->
<c:import url="/WEB-INF/page/template/${site.directory }/foot.jsp" />
<!--脚部 结束-->
<!--首页-->
</body>
</html>
