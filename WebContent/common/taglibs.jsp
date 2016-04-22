<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    //（1）做开发时，可去掉下面注释！以便清理缓存！
    //（2）项目完成时，必须把下面内容注释起来！(否则ie6下出现网页过期)
    request.getSession().getServletContext().setAttribute("css", "");
	//request.getSession().getServletContext().setAttribute("css", "");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	response.flushBuffer();
	request.setAttribute("ctx", request.getContextPath());
%>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link href="/images/favicon.ico" rel="shortcut icon">

<!-- css import -->
<link href="${css }/skins/blue/css/base.css" rel="stylesheet" type="text/css" />
<link href="${css }/skins/blue/css/layout.css" rel="stylesheet" type="text/css" />
<link href="${css }/skins/blue/css/login.css" rel="stylesheet" type="text/css" />
<link href="${css }/skins/blue/css/pop.css" rel="stylesheet" type="text/css" />
<link href="${css }/skins/blue/css/table_form.css" rel="stylesheet" type="text/css" />

<!-- jquery 支持-->
<script type="text/javascript" src="/plugin/jquery-1.8.3.min.js"></script>

<!-- png透明 -->
<script type="text/javascript" src="/plugin/iepngfix_tilebg.js"></script>

<!-- cookie 操作 -->
<script type="text/javascript" src="/plugin/jquery.cookie.js"></script>

<!-- 弹出框引入 -->
<script type="text/javascript" src="/plugin/artDialog4.1.7/artDialog.js?skin=aero"></script>
<script type="text/javascript" src="/plugin/artDialog4.1.7/plugins/iframeTools.source.js"></script>

<script type="text/javascript" src="/My97DatePicker/WdatePicker.js"></script>

<script type="text/javascript" src="/js/base/util.js"></script>
<script type="text/javascript" src="/js/base/PagedQuery.js"></script>
<script>
	// 默认弹出框锁屏
	artDialog.defaults.lock = true;
	artDialog.defaults.fixed = true;
	artDialog.defaults.resize = false;
</script>

<!-- ztree -->
<link rel="stylesheet" href="/plugin/ztree3.5.14/css/demo.css" type="text/css">
<link rel="stylesheet" href="/plugin/ztree3.5.14/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="/plugin/ztree3.5.14/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="/plugin/ztree3.5.14/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript" src="/plugin/ztree3.5.14/jquery.ztree.exedit-3.5.min.js"></script>

