<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<html lang="en">
    <head>
   
    <title>${site.name }</title>
   	<meta charset="utf-8" />
    
    <meta name="keywords" content="${site.name } 番禺慈善,番禺慈善会,慈善会,慈善,项目大赛" />
    <meta name="Description" content="广州市番禺区慈善会是立足于番禺，从事公益慈善活动的非营利性社会组织" />
        <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/game/base.css" />
        <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/game/index.css" />
        <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/game/inspages.css" />
        <script type="text/javascript" src="/template/${site.directory }/js/game/jquery-1.8.3.min.js"></script>
        <script type="text/javascript" src="/template/${site.directory }/js/game/base.js"></script>
</head>
    <body>
         <jsp:include page="game_head.jsp"></jsp:include>
        <!-- header结束 -->

        <!-- banner结束 -->

        <div class="main wrap">
            <div class="main_left fll">
                <div class="list_content">
                     <div class="crumbs">
                        当前位置：<a href="/go-game_index.html">首页</a> &gt; 
                        <c:forEach items="${当前位置}" var="item" varStatus="status">
                        		
                        		<c:if test="${status.last }">${item.name }</c:if>
                        </c:forEach>
                    </div>
                   <div class="txt_list">
                    <c:forEach items="${列表.list}" var="item">
                    	<dl>
                            <dt><img src="${item.smallPicUrl}" alt="${item.title}" width="208px" height="142px" /></dt>
                            <dd>
                                <h4><a href="/go-game_article.html?articleId=${item.id  }&columnId=${columnId}">${item.title}</a></h4>
                                <p>
                                ${item.introduce}
                                </p>
                                <div class="imglist_b">
                                    <div class="imglist_time fll">
                                    <span>
                                    	<fmt:formatDate value="${item.createTime}" type="date"/>
                                    </span>
                                    </div>
                                     </div>
                            </dd>
                        </dl>
                    </c:forEach>
                         <div class="clear"></div>
                    </div>
                    <hr />
                    <div class="pages flr">
                        <ul>
                          <c:if test="${列表.totalPage > 1 &&列表.currentPage>1}">
                         	<li ><span><a <c:if test="${列表.currentPage > 1 }">href="/go-game_list.html?columnId=${columnId }&currentPage=${currentPage - 1 }&pageSize=${pageSize }"</c:if>>上一页</a></span></li>
                            </c:if>
                              <c:forEach items="${列表.numbers }" var="item">
                               <li <c:if test="${item == currentPage }">class="lia_hover"</c:if>>
                                <a href="/go-game_list.html?columnId=${columnId }&currentPage=${item }&pageSize=${pageSize }">${item }</a>
                            	</li>
                            </c:forEach>
                            <c:if test="${列表.totalPage > 1 &&列表.currentPage!=列表.totalPage}">
                            <li><span><a <c:if test="${列表.currentPage < 列表.totalPage}">href="/go-game_list.html?columnId=${columnId }&currentPage=${currentPage + 1 }&pageSize=${pageSize }"</c:if>>下一页</a></span></li>
                            </c:if>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="clear"></div>
                
            </div>
            <!-- 左边列表结束 -->

             <jsp:include page="game_right2.jsp"></jsp:include>
  
        </div>
        <!-- main结束 -->

    	<jsp:include page="game_foot.jsp"></jsp:include>
    </body>
</html>