<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>长兴中学借读生报名信息</title>

<style>
/* 公共之标签样式 */
body, h1, h2, h3, h4, h5, h6, hr, p, blockquote, /* structural elements 结构元素 */
dl, dt, dd, ul, ol, li, /* list elements 列表元素 */
pre, /* text formatting elements 文本格式元素 */
fieldset, lengend, button, input, textarea, /* form elements 表单元素 */
th, td { /* table elements 表格元素 */
    margin: 0;padding: 0;}
* { margin: 0; padding: 0; }
img,input { border:0; }
ul, li { list-style-type: none; margin:0px; padding:0px;}
body, input, select, button, textarea {  font:12px/22px 'Microsoft YaHei','宋体', Arial,  Helvetica, sans-serif;color:#626262;   }
body{ background:#EFEFEF}


.box{width:800px;margin: 0 auto; position: relative; z-index:3; background: #FFF; padding: 0 15px;}
.table_border2{width:100%; border-collapse: collapse; margin: 5px 0 5px 0; }
.table_border2 td{ border: 1px solid #DEDEDE; text-align: center; font-size:16px; }

.title{ font-size: 26px; color:#000; font-weight: bold;line-height:70px;}
.gray{ font-size:12px; color:#999;}

.printBtn{margin-left:10px;padding:5px 10px;font-size:20px;color:#626262;text-decoration: none;}
.printBtn:hover{color:#000;}
table tr td img{
    height: 90px;
}
</style>
 <style media="print">
 .noprint{display: none;}
 .pageNext{page-break-after: always;}
 </style>
 <script src="/plugin/jquery-1.8.3.min.js" type="text/javascript"></script>
 <script type="text/javascript">
 $(function(){
	 if($.browser.msie && $.browser.version <9){
		 alert('你的IE浏览器版本过低不支持直接打印，请升级为IE9以上的版本');
	 }else{
		 $('#printBtn').click(function(){
			 window.print();
		 });
	 }
 });
 </script>
</head>
<body>
<div id="printBana" class="noprint" style="width:150px;height:30px;padding:8px 0px;position: fixed;top:0px;right:0px;;z-index: 10;background-color: white;border:solid 1px #ccc;text-align:center;">
	<a id="printBtn" class="printBtn" href="javascript:void(0);">打印</a>
</div>
<c:forEach var="studentList" items="${studentListGroup }" varStatus="status">
	<c:if test="${!status.first}">
	    <div class="pageNext"></div>
	</c:if>
    <div class="box">
        <table border="0" cellspacing="0" cellpadding="0" class="table_border2">
            <tr>
                <td colspan="6" style=" border: 0;"><font class="title">长兴中学面谈第 ${status.index + 1} 试室</font></td>
            </tr>
            <c:forEach var="stu" items="${studentList}" varStatus="vs">
                <c:if test="${(vs.index +1)%6 == 1}">
                    <tr>
                        <c:forEach var="st" items="${studentList}" begin="${vs.index}" end="${vs.index +5}" varStatus="svar">
                            <td style="padding: 10px 0px;">
                                <img src="${st.headPicUrl}"/>
                                <div style="font-size: 15px;">${svar.index+1}.${st.name}</div>
                                <div style="font-size: 14px;">${st.graduation}</div>
                            </td>
                        </c:forEach>
                    </tr>
                </c:if>
            </c:forEach>
        </table>
	  
	</div> <!--#box-->
</c:forEach>
</body>
</html>
  