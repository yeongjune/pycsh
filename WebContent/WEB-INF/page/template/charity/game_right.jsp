<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
 <div class="main_right flr">
                <!-- <div class="list_content_right"> -->
                 
           
                 <c:if test="${!empty 大赛菜单.children}">
                 
                 
                    <div class="list_m_r_top">
                    	  <p></p>
                        <div class="list_title">
                        <c:set value="${rfn:getParentColumn(columnId)}" var="parent"></c:set>
                        		${parent.name}
                         </div>
                    
                  
                        <ul>
                         <c:forEach items="${rfn:getChildrenColumn(site.id,parent.id)}" var="item">
                         			 <li <c:if test="${item.id == columnId }"> class="li_m_r_t_hover"</c:if>><a href="${item.url}">${item.name}</a></li>
                     
                         </c:forEach>
                         </ul>
                    </div>
                    </c:if>
                    
    
                    <div class="list_m_r_bottom">
                        <div class="list_title">
                            新闻活动
                        </div>
                        <ul>
                        <c:forEach items="${新闻动态}" var="item">
                        	<li><a href="/go-game_article.html?articleId=${item.id }&columnId=${columnId}" title="${item.title}" >
                        	<c:if test="${fn:length(item.title)>18}">
                        		${fn:substring(item.title,0,18)}...
                        	</c:if>
                        	<c:if test="${fn:length(item.title)<=18}">
                        		${item.title}
                        	</c:if>
                        	</a></li>
                         </c:forEach>
                        </ul>
                    </div>
                    
               <!--  </div> -->
                
            </div>
   <div class="clear"></div>