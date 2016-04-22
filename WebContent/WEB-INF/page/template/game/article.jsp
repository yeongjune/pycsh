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
<body>
         <jsp:include page="head.jsp"></jsp:include>
        <!-- header结束 -->


        <div class="main wrap">
            <div class="main_left fll">
                <div class="list_content">
                    <div class="crumbs">
                        当前位置：<a href="/go-index.html">首页</a> &gt; 
                        <c:forEach items="${当前位置}" var="item" varStatus="status">
                        		${item.name }
                        		<c:if test="${!status.last }">&gt;</c:if>
                        </c:forEach>
                    </div>
                    <div class="list_article">
                    
                        <h4>${文章内容.title}</h4>
                         ${文章内容.content }
                                    <c:forEach items="${文章内容.fileList }" var="item">
                                        <p><a href="${item.path }">附件：${item.fileName }</a></p>
                                    </c:forEach>
                        </div>
                        <script type="text/javascript">
                        	maxImgWidth(".list_article");
                        </script>
                </div>
                <div class="clear"></div>
                
            </div>
            <!-- 左边列表结束 -->

              <jsp:include page="right.jsp"></jsp:include>
  
        </div>
        <!-- main结束 -->
		<jsp:include page="foot.jsp"></jsp:include>
    </body>
</html>
