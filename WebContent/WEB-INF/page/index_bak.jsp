<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>系统管理后台</title>
    <c:import url="/common/taglibs_bak.jsp" />
    <link href="/plugin/frame/frame.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function() {
        	frameManager.initMenu();
        });
        function FrameManager(){
            this.first_menu_array = new Object();
            this.first_menu = false;
            this.current_menu = 0;
            this.children_menus = {};
            this.initMenu = function(){
            	$.post('/sys/loadForMenu.action', {}, function(data){
            		var mapList = $.parseJSON(data);
            		var siteId = parseInt("${authority_user.siteId}");
    		    	for ( var item in mapList) {
    					var map = mapList[item];
    					frameManager.first_menu_array[map.id] = map;
    					$('#firstMenus').append('<span><a class="level_0" id="level_0_'+map.id+'" href="javascript:frameManager.changeMenu('+map.id+')">'+map.name+'</a></span>');
    					var children = map.children;
    					if(children && children!=null){
    						frameManager.children_menus[map.id] = new Array();
    						for ( var s_item in children) {
    							var s_menu = children[s_item];
    							var secondMenu = null;
    							if(typeof s_menu.url == 'undefined' || s_menu.url.trim()==''){
    								secondMenu = $('<div class="accordion_pane"><span class="head"><a>'+s_menu.name+'</a></span><ul class="body"></ul></div>');
    							}else{
    								secondMenu = $('<div class="accordion_pane"><span class="head"><a href="javascript:loadUrlPage(\'/'+s_menu.url+'.action\')">'+s_menu.name+'</a></span><ul class="body"></ul></div>');
    							}
    							var thirdChildren = s_menu.children;
    							if(thirdChildren && thirdChildren!=null){
    								secondMenu.find('ul').empty();
    								for ( var t_item in thirdChildren) {
    									var t_menu = thirdChildren[t_item];
    									var thirdMenu = null;
    									if(typeof t_menu.url == 'undefined' || t_menu.url.trim()==''){
    										thirdMenu = $('<li><a>'+t_menu.name+'</a></li>');
    									}else{
    										thirdMenu = $('<li><a class="level_2" id="level_2_'+t_menu.id+'" href="javascript: frameManager.loadUrlPage('+t_menu.id+', \'/'+t_menu.url+'.action\')">'+t_menu.name+'</a></li>');
    									}
    									secondMenu.find('ul').append(thirdMenu);
    								}
    							}
    							frameManager.children_menus[map.id].push(secondMenu);
    						}
    					}
    					if(frameManager.current_menu==0)frameManager.changeMenu(map.id);
    				}
    		     });
            };
            this.changeMenu = function(id){
            	$('.level_2').removeClass('hover');
            	$('#children_menus_div').empty();
            	frameManager.current_menu = id;
            	$('.level_0').removeClass('hover');
            	$('#level_0_'+id).addClass('hover');
            	frameManager.first_menu = frameManager.first_menu_array[frameManager.current_menu];
            	if(frameManager.children_menus[id].length>0){
	            	for ( var item in frameManager.children_menus[id]) {
	    				var menu = frameManager.children_menus[id][item];
	    				menu.appendTo('#children_menus_div');
	    			}
	            	$('#frame_left').show();
	            	$('#frame_right').css('margin-left', '205px');
            	}else{
            		$('#frame_left').hide();
                	$('#frame_right').css('margin-left', '0px');
            	}
            	if(typeof frameManager.first_menu.url!='undefined' && frameManager.first_menu.url.trim()!=''){
            		loadUrlPage('/'+frameManager.first_menu.url+'.action');
            	}
				frame.initAccordionContainer();
            };
            this.loadUrlPage = function(id, url){
            	$('.level_2').removeClass('hover');
            	$('#level_2_'+id).addClass('hover');
            	loadUrlPage(url);
            };
            this.logout = function(){
            	art.dialog.confirm('确定退出吗？', function(){
    	        	$.post('/login/logout.action', {}, function(data){
    	        		if(data=='succeed'){
    	        			window.location.href='/sys/index.action';
    	        		}
    	        	});
            	});
            };
            this.editPassword = function(){
            	art.dialog.open('/sys/editPassword.action', {
    				width: 500,
    				height: 200,
    				title:'修改密码'
    			});
            };
        }
        var frameManager = new FrameManager();
    </script>
</head>
<body>
   	<div id="frame_head">
   		<div style="font-size: 16px; color: #fff; text-align: left; padding-top: 14px; padding-left: 30px; float: left; width: 500px;">
		${authority_user.siteName }
   		</div>
   		<div style="float: right; width: 100px; margin-top: 20px;"><a style="color: #fff;" href="/sys/index.action">原版</a></div>
	</div>
	<div id="frame_menubar">
		<div class="left" id="firstMenus">
		</div><!--hesder_below_left-->
		<div class="right">
			<span><a href="javascript:frameManager.logout()" style="color:#FFF">退出系统</a></span>
			<span><a href="javascript:frameManager.editPassword()" style="color:#FFF">修改密码</a></span>
			<c:if test="${authority_user.siteId>0 }">
				<span>
					<a target="_blank" href="http://${authority_user.siteDomain }" style="color:#FFF">进入网站</a>
				</span>
			</c:if>
			<span><a>${authority_user.name }</a></span>
		</div>
	</div>
	
	<div id="frame_center">
		<div id="frame_left">
			<div class="accordion_container" id="children_menus_div">
			</div>
		</div>
		<div id="frame_right">
			<div class="main_content_items">
	 			<div class="main_right_content" id="main_right_content"></div><!--main_right_content-->
			</div>
		</div>
	</div>
	<div id="frame_foot">技术支持：睿驰科技</div>

<script type="text/javascript" src="/plugin/frame/frame.js"></script>
<script type="text/javascript">
	var frame = new Frame();
	$(document).ready(function(){
		frame.autoHeight();
	});
	window.onresize = function(e){
		frame.autoHeight();
		frame.accordionContainerAutoHeight();
	};
</script>
</body>
</html>