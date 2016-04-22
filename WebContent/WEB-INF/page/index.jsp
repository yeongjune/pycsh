<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>睿驰科技建站系统</title>
    <c:import url="/common/taglibs.jsp" />
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
    		    	for ( var item in mapList) {
    					var map = mapList[item];
    					frameManager.first_menu_array[map.id] = map;
    					$('#firstMenus').append('<div class="header_operation"><a href="javascript:void(0);" onclick="frameManager.changeMenu('+map.id+')" style="color:#FFF">'+map.name+'</a></div>');
    					var children = map.children;
    					if(children && children!=null){
    						frameManager.children_menus[map.id] = new Array();
    						for ( var s_item in children) {
    							var s_menu = children[s_item];
    							var secondMenu = null;
    							if(typeof s_menu.url == 'undefined' || s_menu.url.trim()==''){
    								secondMenu = $('<h2><a>'+s_menu.name+'</a></h2><div class="submenu"><ul></ul></div>');
    							}else{
    								secondMenu = $('<h2><a href="javascript:void(0);" onclick="loadUrlPage(\'/'+s_menu.url+'.action\',\'menu_name='+s_menu.name+'\')">'+s_menu.name+'</a></h2><div class="submenu"><ul></ul></div>');
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
    										thirdMenu = $('<li><a  href="javascript:void(0);" onclick="loadUrlPage(\'/'+t_menu.url+'.action\',\'menu_name='+s_menu.name+'\')">'+t_menu.name+'</a></li>');
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
            	$('#children_menus_div').empty();
            	frameManager.current_menu = id;
            	frameManager.first_menu = frameManager.first_menu_array[frameManager.current_menu];
            	if(frameManager.children_menus[id].length>0){
	            	for ( var item in frameManager.children_menus[id]) {
	    				var menu = frameManager.children_menus[id][item];
	    				menu.appendTo('#children_menus_div');
	    			}
	            	$('#main_left').show();
	            	$('#main_right').css('margin-left', '204px');
            	}else{
            		$('#main_left').hide();
                	$('#main_right').css('margin-left', '5px');
            	}
            	if(typeof frameManager.first_menu.url!='undefined' && frameManager.first_menu.url.trim()!=''){
            		loadUrlPage('/'+frameManager.first_menu.url+'.action');
            	}
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
   	<div class="header">
		<div class="header_above">
			<div class="header_logo">${authority_user.siteName }</div>
			<a style="float: right; color: #fff; margin-top: 20px; margin-right: 35px;" href="/sys/indexBak.action">简版</a>
		</div>
	</div><!--#header-->
	
	<div class="header_below">
		<div class="header_below_left" id="firstMenus">
		</div><!--hesder_below_left-->
		<div class="header_below_right">
			<div class="header_operation">${authority_user.name }</div>
			<c:if test="${authority_user.siteId>0 }">
				<div class="header_operation">
					<a target="_blank" href="http://${authority_user.siteDomain }" style="color:#FFF">进入网站</a>
				</div>
			</c:if>
			<div class="header_operation">
				<a href="javascript:frameManager.editPassword()" style="color:#FFF">修改密码</a>
			</div>
			<div class="header_operation">
				<div class="header_icon"><img src="${css }/skins/blue/images/mail_13.gif"/></div>
				<a href="javascript:frameManager.logout()" style="color:#FFF">退出系统</a>
			</div>
		</div><!--hesder_below_right-->
	</div><!--hesder_below-->
	
	<div class="clear"></div>
	<div class="main">
	
		<div class="main_left" id="main_left">
			<div class="menu">
				<div class="accordion" id="children_menus_div"></div><!--accordion-->
			</div><!--menu-->
		</div><!--main_left-->
		
		<div class="main_center" ><img id="controlIco" onclick="control();"  src="${css }/skins/blue/images/arrow.gif"/></div>
		
		<div class="main_right" id="main_right">
			<div class="main_content_items">
	 			<div class="main_right_content" id="main_right_content"></div><!--main_right_content-->
			</div>
		</div><!--main_right-->
		 
	</div><!--#main-->
	<div class="clear"></div>
	<div id="footer">技术支持：睿驰科技 联系电话：020-39920003 <a href="javascript:alert('该功能暂未开放');">反馈</a></div><!--#footer-->
</body>
</html>