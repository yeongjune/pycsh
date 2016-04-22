<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<head>
    <meta charset="utf-8">
    <title>列表</title>
	<link rel="shortcut icon" type="image/x-icon" href="/template/${site.directory }/images/title.ico"/>    
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/base.css">
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/index.css" />
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/module.css" />
    <meta name="keywords" content="${site.name }" />
    <meta name="Description" content="${site.name }" />
</head>
<body>
<!--头部 开始-->
<c:import url="/WEB-INF/page/template/${site.directory }/head.jsp" />
<!--头部 结束-->

<div class="box">
    
    <%--左侧菜单start --%>
    <div class="left_about">
    	<div class="l_a_t">${列表导航.name }</div>
        <div class="l_a_nav">
	        <c:forEach items="${列表导航.children }" var="item" varStatus="vs">
	            <c:if test="${item.id == 文章内容.columnId && item.type == '图片栏目'}">
	                <c:set var="isPicColumn" value="true"/>
	            </c:if>
	                <a href="${item.url }" <c:if test="${rfn:checkIsRelevant(item.id, columnId) == true || rfn:checkIsRelevant(item.id, 文章内容.columnId) == true}">class="hover"</c:if>>${item.name }</a>
	        </c:forEach> 
        </div>
    </div>
    <%--左侧菜单end --%>  
  <%--右侧新闻列表end --%> 
  <c:if test="${列表.list[0].columnType == '新闻栏目'}"> 
  <div class="right_about">
                        <c:if test="${列表.list[0].columnType == '新闻栏目'}">
                            <ul class="new_list_ul">
                                <c:forEach items="${列表.list }" var="item">
                                    <li>
                                        <a href="/article-${item.id }.html">${item.title }</a><sup>${item.status == 1?"new":"" }</sup>
                                        <span><fmt:formatDate value="${item.createTime }" pattern="MM-dd" /></span>
                                        <div class="clear"></div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:if>
                        <c:if test="${列表.list[0].columnType == '图片栏目'}">
                            <ul class="n_imgList">
                                <c:forEach items="${列表.list }" var="item">
                                    <li>
	                                    <a href="#">
	                                        <div class="img_d"><img src="${item.smallPicUrl }"></div>
	                                        <p>${item.title }</p>
	                                    </a>
                                    </li>                                    
                                </c:forEach>
                            </ul>
                            <div class="clear"></div>
                       </c:if>  
   					<div class="clear"></div>
                    <div class="page">
                        <c:if test="${列表.totalPage > 1}">
                            <a <c:if test="${列表.currentPage > 1 }">href="/list-${columnId }-${currentPage - 1 }-${pageSize }.html"</c:if>>
                                <img src="/template/${site.directory }/images/jt_l.png" /></a>
                        </c:if>
                        <c:forEach items="${列表.numbers }" var="item">
                            <a href="/list-${columnId }-${item }-${pageSize }.html"><span <c:if test="${item == currentPage }">class="hover"</c:if>>${item }</span></a>
                        </c:forEach>
                        <c:if test="${列表.totalPage > 1}">
                            <a <c:if test="${列表.currentPage < 列表.totalPage}">href="/list-${columnId }-${currentPage + 1 }-${pageSize }.html"</c:if>>
                                <img src="/template/${site.directory }/images/jt_r.png" /></a>
                        </c:if>
                        <div class="page_count">共&nbsp;<span>${列表.totalSize }</span>&nbsp;条，共&nbsp;<span>${列表.totalPage }</span>&nbsp;页</div>
                    </div>
  </div>
  </c:if>
  <%--右侧新闻列表end --%>
  <DIV class="clear"></DIV>
             <%--右侧图片列表start --%>
            <c:if test="${列表.list[0].columnType == '图片栏目'}">
            <div class="main_r_two">
            	<div class="img_list"></div>
                	<div class="img_l_bg">
                        <div class="img_l_t">
                            <div class="img_l_l">${rfn:getColumnName(columnId) }</div>
                        </div>
                       <div class="Content_list">
                                <ul class="n_imgList">
									<c:forEach items="${列表.list }" var="item">
	                                    <li>
	                                    	<a href="/article-${item.id }.html">
	                                        	<div class="img_d"><img src="${item.smallPicUrl }"></div>
	                                        	<p>${item.title }</p>
	                                    	</a>
	                                    </li>
	                                </c:forEach>                                
                                </ul>
                                <div class="clear"></div>
                            </div>
                    </div>    
                    <div class="clear"></div>
                    <div class="img_l_bottom"></div>
                    <div class="page">
                        <c:if test="${列表.totalPage > 1}">
                            <a <c:if test="${列表.currentPage > 1 }">href="/list-${columnId }-${currentPage - 1 }-${pageSize }.html"</c:if>>
                                <img src="/template/${site.directory }/images/jt_l.png" /></a>
                        </c:if>
                        <c:forEach items="${列表.numbers }" var="item">
                            <a href="/list-${columnId }-${item }-${pageSize }.html"><span <c:if test="${item == currentPage }">class="hover"</c:if>>${item }</span></a>
                        </c:forEach>
                        <c:if test="${列表.totalPage > 1}">
                            <a <c:if test="${列表.currentPage < 列表.totalPage}">href="/list-${columnId }-${currentPage + 1 }-${pageSize }.html"</c:if>>
                                <img src="/template/${site.directory }/images/jt_r.png" /></a>
                        </c:if>
                        <div class="page_count">共&nbsp;<span>${列表.totalSize }</span>&nbsp;条，共&nbsp;<span>${列表.totalPage }</span>&nbsp;页</div>
                    </div>
                    
            	
            </div><!--mian_r-->
            </c:if>            
            <%--右侧图片列表end --%>
 
</div><!--box-->

<!--脚部 开始-->
<c:import url="/WEB-INF/page/template/${site.directory }/foot.jsp" />
<!--脚部 结束-->

</body>
</html>
