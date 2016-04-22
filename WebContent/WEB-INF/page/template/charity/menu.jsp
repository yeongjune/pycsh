<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<div class="menu">
<ul>
	<c:forEach items="${菜单 }" var="item" varStatus="status">
		<span class="line"></span>
		<li class="menu_one_li"
			<c:if test="${rfn:checkIsRelevant(item.id, columnId) == true
                            || rfn:checkIsRelevant(item.id, 文章内容.columnId) == true
                               || rfn:checkIsRelevant(item.id, 单网页.columnId) == true}">class="hover"</c:if>>
		<a <c:if test="${item.name=='项目大赛'}">target="_blank"</c:if>
			href="${fn:length(item.children) > 0 ? item.children[0].url : item.url }"
			<c:if test="${rfn:checkIsRelevant(item.id, columnId) == true
                            || rfn:checkIsRelevant(item.id, 文章内容.columnId) == true
                               || rfn:checkIsRelevant(item.id, 单网页.columnId) == true}">class="hover"</c:if>>${item.name
		}</a> 
		<div class="clear"></div>

		<c:if test="${fn:length(item.children) > 0 }">
	 		<div class="twoMenu" style="display: none">
			    <c:forEach items="${item.children }" var="children" varStatus="cvs">
			    <c:choose>
                        	 	<c:when test="${children.url eq '/go-userSign.html'}">
                        	 		<a href="javascript:void(0);" onclick="getUser();">${children.name }</a>
                        	 	</c:when>
                        	 	<c:otherwise>
                        	 		<a href="${children.url }">${children.name }</a>
                        	 	</c:otherwise>
                        	 </c:choose>
		        	
				</c:forEach>                    
	        </div>		
		</c:if>
		</li>
	</c:forEach>
</ul>
<div class="clear"></div>
</div>

<script>
    $(document).ready(function(){
        $(".menu_one_li").hover(
        		function(){
        			$('.twoMenu').hide();
	        		//当鼠标放上去的时候,程序处理
					//var x = $(this).offset().top;
					//var y = $(this).offset().left;
					var x = $(this).position().top;
					var y = $(this).position().left;
					var two = $(this).find('.twoMenu');
					two.css({position: "absolute",'top':x+36,'left':y+10,'z-index':100});   
					two.show();
        		},
        		function(){
        			$('.twoMenu').hide();
        		});
       			$(".twoMenu").hover(
        		function(){
        			$(this).show();
        		},
        		function(){
        			$('.twoMenu').hide();
        		});
    });
    function getUser(){
    	$.post("/projectFront/getSessionUserInfo.action",{},function(e){
    		
    		if(e!=null){
				location.href="/go-userSign.html";
    		}else{
    				art.dialog.open('/weixinUser/toLoginByMini.action?url=/go-userSign.html&toParam=true',{
    					id:"_menu",
    					title:"登录",
    					width:'auto',
    					height:'auto',
    					close:function(){
    					window.location.reload();
    				}
    			});
    		}
    		
    	},"json");
    }
</script>