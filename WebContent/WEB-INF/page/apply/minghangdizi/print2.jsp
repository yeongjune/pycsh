<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>民航广州子弟学校小学报名信息</title>
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

.box{ width: 890px; height: auto; margin: 0 auto; position: relative; z-index:3; background: #FFF; padding: 0 5px;}
.table_border2{ width: 100%;max-width:100%; border-collapse: collapse; margin: 5px 0 5px 0; }
.table_border2 td{ border: 1px solid #DEDEDE; text-align: center; line-height: 40px; font-size:16px; }

.tab_2{ width: 100%; border-collapse: collapse;  }
.tab_2 td{ border: 1px solid #FFF; text-align: left; line-height: 40px; font-size:16px; padding-left:20px; }

.tab_3{ width: 100%; border-collapse: collapse; }
.tab_3 td{  border: 1px solid #FFF; border-top: 1px solid #DEDEDE; text-align: left; line-height: 28px; font-size:16px; padding-left:15px; }

.tab_4{ width: 100%; border-collapse: collapse; }
.tab_4 td{  border: 1px solid #DEDEDE; border-left: none; border-top: 0; text-align: center; line-height: 32px; font-size:16px;  }

.tab_5{ width: 100%; border-collapse: collapse; }
.tab_5 td{  border: 1px solid #DEDEDE; border-left: none; border-right: none; border-top: 0; text-align: center; line-height: 40px; font-size:16px;  }


.title{ font-size: 22px; color:#000; font-weight: bold; line-height: 60px;}
.gray{ font-size:12px; color:#999;}

.tip{ font-size:12px; color:#999; text-align: left;}

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
<c:forEach var="stu" items="${dzStudent2List }" varStatus="i">
	<c:if test="${i.index !=0 }">
	<div class="pageNext"></div>
	</c:if>
	<div class="box">
	  <table id="table_${stu.id }" width="100%" border="0" cellspacing="0" cellpadding="0" class="table_border2">
	    <tr><td colspan="6"  class="title" style="border:0;">民航广州子弟学校<fmt:formatDate value="${stu.createTime}" pattern="yyyy" />年初一新生入学报名表</td></tr>
	    <tr>
			<td colspan="6" style="border:0;" > 
				<table class="tab_2">
					<tr>
						<td width="50%">编号：</td>
						<td width="50%">身份证：${stu.iDCard }</td>
					</tr>
				</table>		</td>
		</tr>
	    <tr>
	      <td width="150">学生姓名</td>
	      <td width="150">${stu.name }</td>
	      <td width="60"  >性别</td>
	      <td width="60">${stu.gender }</td>
	      <td style="text-align: left; padding-left:10px;">出生：<fmt:formatDate value="${stu.birthday}" pattern="yyyy年MM月dd日" /></td>
	      <td rowspan="3">
	      	<img src="${stu.headPicUrl }" style="width:auto;height: 132px;" />
	      </td>
	    </tr>
		<tr>
	      <td >籍贯</td>
	      <td >${stu.nativePlace }</td>
	      <td colspan="3">
		  	户口所在：${stu.domicile }
		</td>
	    </tr>
		<tr>
	      <td width="150">家庭住址</td>
	      <td colspan="5" style="text-align: left; padding-left:10px;">家庭住址</td>
	    </tr>
		
		 <tr>
	      <td width="150">家庭主要成员</td>
	      <td colspan="5" style="border: 0;">
		  	<table class="tab_4">
				<tr>
					<td >关系</td>
					<td >姓名</td>
					<td >工作单位</td>
					<td>单位电话</td>
				</tr>
				<tr>
					<td>　父亲</td>
				    <td>　${stu.fullName1 }</td>
				    <td>　${stu.unit1 }</td>
				    <td>　${stu.telephone1 }</td>
				</tr>
				<tr>
					<td>　母亲</td>
				    <td>　${stu.fullName2 }</td>
				    <td>　${stu.unit2 }</td>
				    <td>　${stu.telephone2 }</td>
				</tr>
			</table>	  </td>
	    </tr>
		 <tr><td colspan="6"   style="border:0; text-align: left; font-size:14px; color:#999">说明：表中姓名、出生年月必须以户口本为准，各项内容须如实填写，并按规定时间上交。 </td></tr>
		 <tr><td colspan="6" style="border:0; line-height: 40px; text-align: right; padding-right:200px;">家长签名:</td></tr>
	  </table>
	</div>
</c:forEach> 
</body>
</html>