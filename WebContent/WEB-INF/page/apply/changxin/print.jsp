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
.table_border2 td{ border: 1px solid #DEDEDE; text-align: center; line-height: 40px; font-size:16px; height:50px; }

.title{ font-size: 26px; color:#000; font-weight: bold;line-height:70px;}
.gray{ font-size:12px; color:#999;}

.printBtn{margin-left:10px;padding:5px 10px;font-size:20px;color:#626262;text-decoration: none;}
.printBtn:hover{color:#000;}
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
<c:forEach var="stu" items="${cxStudentList }" varStatus="i">
	<c:if test="${i.index>0 }">
	<div class="pageNext"></div>
	</c:if>
	<div class="box">
	  <table border="0" cellspacing="0" cellpadding="0" class="table_border2">
	    <tr>
	      <td colspan="9" style=" border: 0;"><font class="title"><fmt:formatDate value="${stu.createTime}" pattern="yyyy" />年集长兴中学借读生入学报名表</font></td>
	    </tr>
	    <tr>
	      <td width="100px">姓名</td>
	      <td colspan="2">${stu.name }</td>
	      <td>毕业小学</td>
	      <td colspan="3">${stu.graduation }</td>
	      <td rowspan="4" colspan="2" style="text-align: center;">
	       <img src="${stu.headPicUrl }" style="width:127px;height:158px;text-align: center;" />
	       <br>相片<br><font class="gray">(盖录取学校骑缝章)</font></td>
	    </tr>
	    <tr>
	      <td>性别</td>
	      <td colspan="2">${stu.gender }</td>
	      <td>曾任职务</td>
	      <td colspan="3">${stu.position }</td>
	    </tr>
	    <tr>
	      <td>户口所在地</td>
	      <td colspan="6">${stu.domicile }</td>
	    </tr>
	    <tr>
	      <td>家庭住址</td>
	      <td colspan="6">${stu.homeAddress }</td>
	    </tr>
	    <tr>
	      <td>父亲姓名</td>
	      <td colspan="2">${stu.fullName1 }</td>
	      <td>单位</td>
	      <td colspan="2">${stu.unit1 }</td>
	      <td>联系方式</td>
	      <td colspan="2">${stu.telephone1 }</td>
	    </tr>
	    <tr>
	      <td>母亲姓名</td>
	      <td colspan="2">${stu.fullName2 }</td>
	      <td>单位</td>
	      <td colspan="2">${stu.unit2 }</td>
	      <td>联系方式</td>
	      <td colspan="2">${stu.telephone2 }</td>
	    </tr>
	    <tr>
	      <td rowspan="4">近两年成绩</td>
	      <td colspan="4">五年级第一、二学期期末成绩</td>
	      <td colspan="4">六年级第一、二学期期末成绩</td>
	    </tr>
	    <tr>
	      <td  width="92px">语文</td>
	      <td  width="92px">数学</td>
	      <td  width="92px">英语</td>
	      <td width="100px">年级排名</td>
	      <td width="92px">语文</td>
	      <td width="92px">数学</td>
	      <td width="92px">英语</td>
	      <td width="100px">年级排名</td>
	    </tr>
	    <tr>
	      <td>${stu.yuwen1 }</td>
	      <td>${stu.yingyu1 }</td>
	      <td>${stu.shuxue1 }</td>
	      <td>${stu.paiming1 }</td>
	      <td>${stu.yuwen3 }</td>
	      <td>${stu.yingyu3 }</td>
	      <td>${stu.shuxue3 }</td>
	      <td>${stu.paiming3 }</td>
	    </tr>
	    <tr>
	      <td>${stu.yuwen2 }</td>
	      <td>${stu.yingyu2 }</td>
	      <td>${stu.shuxue2 }</td>
	      <td>${stu.paiming2 }</td>
	      <td>${stu.yuwen4 }</td>
	      <td>${stu.yingyu4 }</td>
	      <td>${stu.shuxue4 }</td>
	      <td>${stu.paiming4 }</td>
	    </tr>
	    <tr  style="height:68px;">
	      <td>有何特长</td>
	      <td colspan="8" style="text-align: left;">${stu.hobby }</td>
	    </tr>
	    <tr>
	      <td colspan="4">区以上获奖情况</td>
	      <td colspan="5">校内获奖情况</td>
	    </tr>
	    <tr style="height:200px;">
	      <td colspan="4">&nbsp;${stu.rewardInArea }</td>
	      <td colspan="5">&nbsp;${stu.rewardInSchool }</td>
	    </tr>
	  </table>
	  
	</div> <!--#box-->
</c:forEach>
</body>
</html>
  