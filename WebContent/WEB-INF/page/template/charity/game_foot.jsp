<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
            <!-- 浮动栏 -->
            <div class="er_top">
                <div class="er"><img src="/template/${site.directory }/images/game/er.png" alt="" />微信扫描</div>
                <a href="#"> <div class="top">返回顶部</div></a>
                <div class="er_img"><img src="/template/${site.directory }/images/game/weixin.jpg" alt="" height="160" /></div>
            </div>
            <script type="text/javascript">
                $('.er').hover(function(){
                    $('.er_img').fadeIn(100)
                },function(){
                    $('.er_img').fadeOut(100)
                })
            </script>
            


        <div class="footer">
            <div class="wrap">
                <p>地址：广州市番禺区市桥清河东路319号区行政办公中心西副楼三楼306室 电话：020-34608222 传真：020-34607240</p>
                <p>Copyright(C)  2015-2020   版权所有   广州市番禺区慈善会   粤ICP备4401130100745 &nbsp; 技术支持：<a href="http://www.riicy.com" target="_blank">睿驰科技</a>&nbsp;<a href="/admin.html">管理入口</a></p>
                <p>友情链接：
                <c:forEach items="${友情链接}" var="item">
                	<a target="_blank" href="${item.linkUrl}">${item.name}</a>
                </c:forEach>
               </div>
        </div>