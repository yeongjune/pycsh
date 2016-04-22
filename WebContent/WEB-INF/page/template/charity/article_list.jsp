<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<link rel="shortcut icon" type="image/x-icon" href="/template/${site.directory }/images/title.ico"/>
<link rel="stylesheet" type="text/css" href="/skins/wap/css/base.css" />
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/base/util.js"></script>
<script type="text/javascript" src="/js/base/md5.min.js"></script>
<title>媒体报道</title>
<script type="text/javascript">

$(function(){
	if("${type}"!=""){
		loadByPage('/wxUser/loadNewsList.action',{"type":"${type}"},loadList);
	}else{
		loadByPage('/wxUser/loadNewsList.action',{"type":2337},loadList);
	}
	
	if("${type}"=="2338"){
		$("title").html("机构资讯");
	}
	//alert(document.body.clientWidth);
});

	
	
	function loadList(list){
		for(var item in list){
			var are = list[item];
			var html="";
			
			if((params_cache.params==null||params_cache.params.currentPage==null||params_cache.params.currentPage==1)&&item==0){
				$("#topImg").attr("src",are.smallPicUrl);
				$("#topTime").html(are.createTimeFormat);
				$("#topId").val(are.id);
			}else{
				html+='<li onclick="toView('+are.id+');">';
				html+='<div class="i_l_text" style="width:50%;">';
	            html+='  	<div class="i_l_t_t" style="text-overflow: ellipsis;overflow: hidden;width:170px;">'+are.title+'</div>';
	          	html+='      <div style="text-overflow: ellipsis;overflow: hidden;height:40px;">'+are.introduce+'</div>';
	            html+='</div>';
	            html+='<div class="i_l_img"><img src="'+are.smallPicUrl+'" width="120" ></div>';
	            html+='<div class="clear"></div>';
	            html+='<div class="z_o_text"><font class="left">番禺区慈善会</font> <font class="right">'+are.createTimeFormat+'</font><div class="clear"></div></div>';
	            html+='<div class="clear"></div>';
	            html+='</li>';
	            $('#tableBody').append(html);
			}
			
			
			
			
			

		}
		if($("#pageBtn").html()!=""&&params_cache.params!=null&&params_cache.params.currentPage!=params_cache.totalPage){
			$("#nextBtn").show();
		}else{
			$("#nextBtn").hide();
		}
	}
	

	
	function toView(id){
		window.location.href="/go-article_view.html?id="+id;
	}
	
	function toViewTop(){
		window.location.href="/go-article_view.html?id="+$("#topId").val();
	}
	
	function selectType(type){
		 $('#tableBody').html("");
		loadByPage('/wxUser/loadNewsList.action',{"type":type},loadList);
		if(type==2337){
			$("title").html("媒体报道");
		}
		if(type==2338){
			$("title").html("机构资讯");
		}
	}
</script>
</head>

<body class="bj">
	<div class="box ">
		
        <div class="m_one" onclick="toViewTop();"><input type="hidden" id="topId"></input>
        	 <div class="m_o_t" id="topTitle"></div>
        	<div class="m_o_img"><img src="" id="topImg" width="100%"></div>
            <div class="z_o_text"><font class="left">番禺区慈善会</font> <font class="right" id="topTime"></font><div class="clear"></div></div>
        </div>
        <div class="z_list">
        	<ul id="tableBody">
            	
            </ul>
         </div>
    </div><!--box-->
	<a href="javascript:void(0);" onclick="nextPage();" id="nextBtn" class="block" style="display: none;height: 50px;width: 100%;text-align:center;line-height:50px;font-size: 16px;margin-left: 0px;">加载更多</a>
	
        <div style="display: none;" class="table_under_btn">
			<div class="flip" id="pageBtn">
				</div>
			</div>
</body>


</html>