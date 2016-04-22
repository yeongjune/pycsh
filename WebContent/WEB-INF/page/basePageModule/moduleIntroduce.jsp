<!-- 此文件用于参考，常用动态化格式 -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<!-- 首页头 -->
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>${site.name } - 首页</title>
	<link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/index.css" />
    <script type="text/javascript" src="/template/${site.directory }/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/template/${site.directory }/js/carrot-.js"></script>
    <!-- 首页头结束 -->
    
    <!-- 内页头 -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>${site.name } - 列表</title>
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/InsidePages.css" />
    <script type="text/javascript" src="/template/${site.directory }/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/template/${site.directory }/js/carrot-.js"></script>
    <script type="text/javascript" src="/plugin/ueditor_1.4.3/ueditor.parse.min.js"></script>
    <script type="text/javascript">
    uParse('.includeplayer', {
		rootPath: '/plugin/ueditor_1.4.3/'
	});
    //className : includeplayer
    </script>
    <!-- 内页头结束 -->
    <!-- 统计 -->
    <script type="text/javascript">
	$(function(){
		var siteId = "${site.id}";
		$.post("/statistics/saveOrUpdatePageView.action",{siteId : siteId}, function(data){});
		$.post("/statistics/findPageView.action",{siteId : siteId}, function(data){
			if(data){
				$("#pageView").text(data);
			}
		});
	});
	</script>
	<!-- 统计结束 -->

    <!-- 内容图片放大工具 -->
    <link rel="stylesheet" type="text/css" href="/plugin/highslide/highslide.css" />
    <script type="text/javascript" src="/plugin/highslide/highslide.min.js"></script>
    <script type="text/javascript">
        hs.graphicsDir = '/plugin/highslide/graphics/';
        hs.wrapperClassName = 'wide-border';

        $(function(){
            $('.Content_article > .c_a_info img').each(function(i){
                $(this).wrap($('<a class="highslide" onclick="return hs.expand(this);" />').attr('href', $(this).attr('src')).css({
                    width : $(this).width(),
                    height : $(this).height()
                }).get(0));
            });
        });
    </script>
    <!-- 内容图片放大工具 -->
</head>
<body>
	
	<!-- 常用导入 -->
	<c:import url="/WEB-INF/page/template/${site.directory }/head.jsp" />
	<c:import url="/WEB-INF/page/template/${site.directory }/foot.jsp" />
	<c:import url="/WEB-INF/page/template/${site.directory }/nav.jsp" />
	<!-- 常用导入结束 -->
	
	<!-- 首页菜单导航 -->
	<div class="menu">
	    <ul>
	        <li><a href="/go-index.html" <c:if test="${empty columnId && empty 文章内容.columnId }">class="hover"</c:if>>网站首页</a><span class="fgx">/</span><div class="clear"></div>
	        </li>
	        <c:forEach items="${菜单 }" var="item" varStatus="vs">
	        	<li>
	        		<a href="${item.url }" <c:if test="${rfn:checkIsRelevant(item.id, columnId) == true || rfn:checkIsRelevant(item.id, 文章内容.columnId) == true  }">class="hover"</c:if>>${item.name }</a>
	        		<c:if test="${!vs.last }"><span class="fgx">/</span></c:if><!-- 注意分隔符 -->
	        		<div class="clear"></div>
		            <!-- 二级菜单 开始-->
		            <div class="twoMenu" style="display: none;">
		            	<c:forEach items="${item.children }" var="child" varStatus="cvs">
			                <div class="twoMenuTitle">
			                    <div class="WTriangle_icon"></div>
			                    <a href="${child.url }">${child.name }</a><div class="clear"></div>
			                </div>
		                </c:forEach>
		                <div class="clear"></div>
		            </div>
		            <!-- 二级菜单 结束-->
		        </li>
	        </c:forEach>
	    </ul>
	    <div class="clear"></div>
	</div>
	<!-- 首页菜单导航结束 -->
	
	<!-- 幻灯片Slideshow_s -->
	<c:forEach items="${数据源名称[0].list }" var="item">
		<li><a href="/article-${item.id }.html">
	       	<img src="${item.smallPicUrl }" />
	    </a></li>
	</c:forEach>
	<!-- 幻灯片Slideshow_s结束 -->
	
	<!-- 幻灯片Slideshow_s下标 -->
	<c:forEach items="${数据源名称[0].list }" var="item" varStatus="vs">
   		<li><a rel="${vs.index }" class="num_icon 
   			<c:if test="${vs.first }">num2</c:if>" href="javascript:void(0)">
   		</a></li>
   	</c:forEach>
	<!-- 幻灯片Slideshow_s下标结束 -->
	
	<!-- 首页新闻列表 -->
	<c:forEach items="${数据源名称[0].list }" var="item">
   		<li>
        	<a href="/article-${item.id }.html">${item.title }</a>
        	<sup>${item.status==1?"new":"" }</sup>
            <span><fmt:formatDate value="${item.createTime }" pattern="MM-dd" /></span>
            <div class="clear"></div>
        </li>
   	</c:forEach>
	<!-- 首页新闻列表结束 -->
	
	<!-- 列表导航 -->
	<ul>
		<c:forEach items="${列表导航.children }" var="item" varStatus="vs">
			<li><a href="${item.url }" <c:if test="${rfn:checkIsRelevant(item.id, columnId) == true || rfn:checkIsRelevant(item.id, 文章内容.columnId) == true  }">class="hover"</c:if>>
				<span>${item.name }</span>
				<c:if test="${vs.first }"><div class="clear"></div></c:if>
		  	</a></li>
		</c:forEach>
	</ul>
	<!-- 列表导航结束 -->
	
	<!-- 列表 -->
	<c:forEach items="${列表.list }" var="item">
   		<li>
   			<a href="/article-${item.id }.html">${item.title }</a>
   			<sup>${item.status == 1?"new":"" }</sup>
	        <span><fmt:formatDate value="${item.createTime }" pattern="MM-dd" /></span>
            <div class="clear"></div>
        </li>
   	</c:forEach>
	<!-- 列表导航 -->
	
	<!-- 当前位置 -->
	<c:forEach items="${当前位置 }" var="item" varStatus="vs">
    	<c:if test="${!vs.last }">
    		 <a href="${item.url }">${item.name }</a>&nbsp;>&nbsp;
    	</c:if>
    	<c:if test="${vs.last }">
    		${item.name }
    	</c:if>
    </c:forEach>
	
	<!-- 列表分页 -->
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
	<!-- 列表分页结束 -->
	
	<!--底部友情链接-->
	<p class="links">友情链接：
    	<c:forEach items="${友情链接 }" var="item">
    		<a href="${item.linkUrl }">${item.name }</a>
    	</c:forEach>
    </p>
	<!--底部友情链接结束-->
	
	<!-- 附件 -->
	<br />
	<c:forEach items="${文章内容.fileList }" var="item">
		<a href="${item.path }">附件：${item.fileName }</a><br />
	</c:forEach>
	<!-- 附件结束 -->
	
	<!-- 上下篇文章跳转 -->
	<c:if test="${!empty 文章内容.pre}">
   		<p><a href="/article-${文章内容.pre.id }.html">上一篇：${文章内容.pre.title }</a></p>
   	</c:if>
   	<c:if test="${!empty 文章内容.next}">
   		<p><a href="/article-${文章内容.next.id }.html">下一篇：${文章内容.next.title }</a></p>
   	</c:if>
   	
   	<!--放视屏的-->
	<c:if test="${not empty article.fileList[0].path }">
		<c:if test="${fn:endsWith(article.fileList[0].path,'.swf') }">
			<embed src="${article.fileList[0].path }" type="application/x-shockwave-flash" width="161" height="116" quality="high" />
		</c:if>
		<c:if test="${not fn:endsWith(article.fileList[0].path,'.swf') }">
			<embed src="${article.fileList[0].path }" type="video/x-ms-asf-plugin" width="161" height="116" quality="high" autostart="true" loop="true" />
		</c:if>
	</c:if>
</body>
</html>