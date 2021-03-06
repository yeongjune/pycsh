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
body, input, select, button, textarea {  font:12px/22px 'Microsoft YaHei','宋体', Arial,  Helvetica, sans-serif;color:#000;   }
body{ background:#EFEFEF}


.box{ width: 890px;  height: auto; margin: 0 auto; position: relative; z-index:3; background: #FFF; padding: 0 5px;}
.table_border2{ width: 100%; border-collapse: collapse; margin: 5px 0 5px 0; }
.table_border2 td{ border: 1px solid #DEDEDE; text-align: center; line-height: 29px; padding : 1px 0; font-size:16px; }

.tab_2{ width: 100%; border-collapse: collapse;  }
.tab_2 td{ border: 1px solid #FFF; text-align: left; line-height: 36px; font-size:16px; padding-left:20px; }

.tab_3{ width: 100%; border-collapse: collapse; }
.tab_3 td{  border: 1px solid #FFF; border-top: 1px solid #DEDEDE; text-align: left; line-height: 28px; font-size:16px; padding-left:15px; }

.tab_4{ width: 100%; border-collapse: collapse; }
.tab_4 td{  border: 1px solid #DEDEDE; border-left: none; border-top: 0; text-align: center; line-height: 32px; font-size:16px;  }

.tab_5{ width: 100%; border-collapse: collapse; }
.tab_5 td{  border: 1px solid #DEDEDE; border-left: none; border-right: none; border-top: 0; text-align: center; line-height: 36px; font-size:16px;  }


.title{ font-size: 22px; color:#000; font-weight: bold; height:50px;}
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
<c:forEach var="stu" items="${dzStudentList }" varStatus="i">
	<c:if test="${i.index !=0 }">
	<div class="pageNext"></div>
	</c:if>

<div class="box">
  <table id="table_${stu.id }" width="100%" border="0" cellspacing="0" cellpadding="0" class="table_border2">
    <tr><td colspan="6"  class="title" style="border:0;">民航广州子弟学校<fmt:formatDate value="${stu.createTime}" pattern="yyyy" />年小学新生入学报名表</td></tr>
    <tr>
		<td colspan="6" style="border:0;" > 
			<table class="tab_2">
				<tr>
					<td>编号：2015<fmt:formatNumber pattern="0000" value="${stu.number }" /></td>
					<td>身份证：${stu.iDCard }</td>
				</tr>
			</table>		</td>
	</tr>
    <tr>
      <td width="150">曾用名</td>
      <td width="150">${stu.usedName}</td>
      <td width="60"  >性别</td>
      <td width="60">${stu.gender }</td>
      <td style="text-align: left; padding-left:10px;">出生：<fmt:formatDate value="${stu.birthday}" pattern="yyyy年MM月dd日" /></td>
      <td rowspan="6">
      	<img src="${stu.headPicUrl }" style="width:auto;height: 132px;" />
      </td>
    </tr>
	 <tr>
      <td width="150">学生姓名</td>
      <td width="150">${stu.name }</td>
      <td colspan="2"  >姓名拼音</td>
      <td >${stu.namePinyin }</td>
    </tr>
	 <tr>
      <td width="150">国家</td>
      <td width="150">${stu.country }</td>
      <td colspan="2"  >健康状况</td>
      <td >${stu.healthyCondition }</td>
    </tr>
	 <tr>
      <td width="150">港澳台侨外</td>
      <td width="150">${stu.isOutside}</td>
      <td colspan="2"  >政治面貌</td>
      <td >${stu.politicsStatus }</td>
    </tr>
	<tr>
      <td colspan="2" style="text-align: left; padding-left:10px;">毕业幼儿园：${stu.graduate }</td>
      <td colspan="2" >特长</td>
      <td style="text-align: left; padding-left:10px;">${stu.rewardHobby }&nbsp;</td>
    </tr>
	<tr>
      <td >籍贯</td>
      <td >${stu.nativePlace }</td>
      <td colspan="3">
	  	<table class="tab_3">
			<tr><td style="border-top:0; border-bottom: 1px solid #DEDEDE">户口所在：${stu.domicil }</td></tr>
			<tr><td>户口性质：${stu.peasant}</td></tr>
		</table>	  </td>
    </tr>
	<tr>
      <td width="150">家庭住址</td>
      <td colspan="5" style="text-align: left; padding-left:10px;">${stu.homeAddress }</td>
    </tr>
	<tr>
      <td width="150">通讯地址</td>
      <td colspan="5" style="text-align: left; padding-left:10px;">${stu.mailingAddress }</td>
    </tr>
	
	
	 <tr>
      <td width="150">家庭主要成员</td>
      <td colspan="5" style="border: 0;">
	  	<table class="tab_4">
			<tr>
				<td >关系</td>
				<td >姓名</td>
				<td>单位电话</td>
				<td >民族</td>
				<td >户口所在地</td>
				<td>身份证号</td>
			</tr>
			<tr>
				<td>　${stu.relationship1 }</td>
			    <td>　${stu.fullName1 }</td>
			    <td>　${stu.telephone1 }</td>
				<td >${stu.nationality1 }</td>
				<td >${stu.domicile1 }</td>
				<td>${stu.IDCard1 }</td>
			</tr>
			<tr>
				<td colspan="6" style="text-align: left; padding-left:12px;">工作单位：${stu.unit1 }</td>
			</tr>
			
			<tr>
				<td>　${stu.relationship2 }</td>
			    <td>　${stu.fullName2 }</td>
			    <td>　${stu.telephone2 }</td>
				<td >${stu.nationality2 }</td>
				<td >${stu.domicile2 }</td>
				<td>${stu.IDCard2 }</td>
			</tr>
			<tr>
				<td colspan="6" style="text-align: left; padding-left:12px;">工作单位：${stu.unit2 }</td>
			</tr>
		</table>	</td>
    </tr>
	<tr>
      <td width="150">备注</td>
      <td colspan="5" style="border-top:none" >
	  	<table class="tab_3">
			<tr><td style=" border:0;">${stu.remark }</td></tr>
		</table>	</td>
    </tr>
	<tr>
      <td width="150">序号</td>
      <td colspan="4">单位</td>
      <td >请在相应部分打<br>&#8220;&#8730;&#8221;</td>
    </tr>
	 <tr>
      <td width="150">1</td>
      <td colspan="4" style=" text-align: left; padding-left:10px;">机场集团公司</td>
      <td > <span title="机场集团公司"></span></td>
    </tr>
	 <tr>
      <td width="150">2</td>
      <td colspan="4" style=" text-align: left; padding-left:10px;">工程建设指挥部</td>
      <td > <span title="工程建设指挥部"></span></td>
    </tr>
	 <tr>
      <td width="150">3</td>
      <td colspan="4" style=" text-align: left; padding-left:10px;">机场股份公司</td>
      <td > <span title="机场股份公司"></span></td>
    </tr>
	 <tr>
      <td width="150">4</td>
      <td colspan="4" style=" text-align: left; padding-left:10px;">南航集团</td>
      <td > <span title="南航集团"></span></td>
    </tr>
	 <tr>
      <td width="150">5</td>
      <td colspan="4" style=" text-align: left; padding-left:10px;">南航股份</td>
      <td > <span title="南航股份"></span></td>
    </tr>
	 <tr>
      <td width="150">6</td>
      <td colspan="4" style=" text-align: left; padding-left:10px;">南航合资单位</td>
      <td > <span title="南航合资单位"></span></td>
    </tr>
	 <tr>
      <td width="150">7</td>
      <td colspan="4" style=" text-align: left; padding-left:10px;">广州飞机维修工程有限公司</td>
      <td > <span title="广州飞机维修工程有限公司"></span></td>
    </tr>
	 <tr>
      <td width="150">8</td>
      <td colspan="4" style=" text-align: left; padding-left:10px;">油料公司</td>
      <td > <span title="油料公司"></span></td>
    </tr>
	 <tr>
      <td width="150">9</td>
      <td colspan="4" style=" text-align: left; padding-left:10px;">民航中南地区管理局、退休办</td>
      <td > <span title="民航中南地区管理局、退休办"></span></td>
    </tr>
	 <tr>
      <td width="150">10</td>
      <td colspan="4" style=" text-align: left; padding-left:10px;">民航中南空中交通管理局、退休办</td>
      <td > <span title="民航中南空中交通管理局、退休办"></span></td>
    </tr>
	 <tr>
      <td width="150">11</td>
      <td colspan="4" style=" text-align: left; padding-left:10px;">广州民航职业技术学院、退休办</td>
      <td > <span title="广州民航职业技术学院、退休办"></span></td>
    </tr>
	 <tr>
      <td width="150">12</td>
      <td colspan="4" style=" text-align: left; padding-left:10px;">白云出入境边防检查站(联检单位）</td>
      <td > <span title="白云出入境边防检查站(联检单位）"></span></td>
    </tr>
	 <tr>
      <td width="150">13</td>
      <td colspan="4" style=" text-align: left; padding-left:10px;">白云机场海关（联检单位）</td>
      <td > <span title="白云机场海关（联检单位）"></span></td>
    </tr>
	 <tr>
      <td width="150">14</td>
      <td colspan="4" style=" text-align: left; padding-left:10px;">外单位</td>
      <td > <span title="外单位"></span></td>
    </tr>
	
	 <tr><td colspan="6"   style="border:0; text-align: left; font-size:14px; color:#999">${interviewNote }</td></tr>
	 <tr><td colspan="6" style="border:0; line-height: 40px; text-align: right; padding-right:200px;">家长签名:</td></tr>
  </table>

  <script type="text/javascript">
	  	$(function(){
	  		if($("#table_${stu.id} span[title='${stu.companyName.trim()}']").size()>0){
	  	 		$("#table_${stu.id} span[title='${stu.companyName.trim()}']").html('&#8730;');
	  	 	}
	  	});
  </script>
</div> 
<!--#box-->
</c:forEach>
</body>
</html>