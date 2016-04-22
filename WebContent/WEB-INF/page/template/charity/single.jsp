<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${site.name } - 首页</title>
    <meta name="keywords" content="${site.name }" />
    <meta name="description" content="${site.name }" />
	<link rel="shortcut icon" type="image/x-icon" href="/template/${site.directory }/images/title.ico"/>    
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/base.css">
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/index.css" />
    <link rel="stylesheet" type="text/css" href="/template/${site.directory }/css/module.css" />
	<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="/plugin/juicebox/juicebox.js"></script>
    <script type="text/javascript">
        $(function(){
            if($('#juicebox-container').length > 0){
                new juicebox({
                    containerId : 'juicebox-container',
                    configUrl : '/config-${文章内容.id}.xml',
                    backgroundColor:'rgba(0,0,0,.0)',
                    galleryHeight:'600',
                    debugMode :true
                });
            }
            $(".c_a_info").find("img").css("max-width","690px");
        });
    </script>
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
  <div class="right_about">
     	<div class=""><img src="/template/${site.directory }/images/help_img.jpg" width="690" ></div>
        <div class="r_a_t">
        <div class="Content_article">
        <c:choose>
            <c:when test="${isPicColumn}">
                <div id="juicebox-container" class="c_a_info" style="width: 100%; height: 585px; margin: 0 auto;">

                </div>
                <div id="js_code">

                </div>
            </c:when>
            <c:otherwise>
                <div class="c_a_info">
                         ${单网页.content }
                    <c:forEach items="${单网页.fileList }" var="item">
                        <p><a href="${item.path }">附件：${item.fileName }</a></p>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        </div>	                             
        </div>
  </div><!--right_about-->
  <DIV class="clear"></DIV>
 	 
 
</div><!--box-->

<!--脚部 开始-->
<c:import url="/WEB-INF/page/template/${site.directory }/foot.jsp" />
<!--脚部 结束-->

</body>
</html>