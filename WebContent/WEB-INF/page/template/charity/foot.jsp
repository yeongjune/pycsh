<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="rfn" uri="http://www.riicy.com/tag/functions"%>
<div class="foot">
	地址：广州市番禺区市桥清河东路319号区行政办公中心西副楼三楼306室　电话：020-34608222　传真：020-34607240<br>
Copyright(C)　2015-2020　版权所有　广州市番禺区慈善会　粤ICP备4401130100745 技术支持：<a href="http://www.riicy.com" target="_blank">睿驰科技</a>&nbsp;<a href="http://www.pycs.org.cn/admin.html">管理入口</a>
<br>
<p class="links">
<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1256053704'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s95.cnzz.com/z_stat.php%3Fid%3D1256053704%26show%3Dpic' type='text/javascript'%3E%3C/script%3E"));</script>
            友情链接：
	            <c:forEach items="${友情链接 }" var="item">
	            	<a href="${item.linkUrl }" target="_blank">${item.name }</a>
	            </c:forEach>
	        </p>  
</div>