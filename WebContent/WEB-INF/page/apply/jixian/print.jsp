<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>集贤小学一年级入学报名信息</title>

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


.box{ width: 870px;  margin: 0 auto; position: relative; z-index:3; background: #FFF; padding: 0 15px;}
.table_border2{ width: 100%; border-collapse: collapse; margin: 5px 0 5px 0; }
.table_border2 td{ border: 1px solid #DEDEDE; text-align: center; line-height: 34px; font-size:16px; height:50px; }

.title{ font-size: 26px; color:#000; font-weight: bold;line-height:60px;}
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
<c:forEach var="stu" items="${jxStudentList }" varStatus="i">
	<c:if test="${i.index>0 }">
	<div class="pageNext"></div>
	</c:if>
	<div class="box">
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_border2">
	    <tr>
	      <td colspan="8" style=" border: 0;"><font class="title"><fmt:formatDate value="${stu.createTime}" pattern="yyyy" />年集贤小学一年级入学报名表</font></td>
	    </tr>
	    <tr>
	      <td colspan="3" style=" border: 0; text-align: left">编号：</td>
		  <td  colspan="3" style=" border: 0; text-align: left">报名日期：<fmt:formatDate value="${stu.createTime}" pattern="yyyy年MM月dd日" /></td>
		  <td  colspan="2" style=" border: 0; text-align: left">验证人签名：</td>
	    </tr>
	    <tr>
	      <td width="100px">地段生</td>
	      <td width="100px">${stu.dds }</td>
	      <td width="100px">业主生</td>
	      <td width="100px">${stu.yzs }</td>
	      <td width="130px">广州户籍非地段生</td>
	      <td >${stu.gzhjfdds }</td>
	      <td width="125px">非广州户籍学生</td>
	      <td width="135px">${stu.fgzhjxs }</td>
	    </tr>
	    <tr>
	      <td colspan="3">通过什么渠道了解到集贤小学</td>
	      <td colspan="5">${stu.ljqd }</td>
	    </tr>
	    <tr>
	      <td rowspan="11">基<br>本<br>情<br>况<br></td>
	      <td>姓名</td>
	      <td>${stu.name }</td>
	      <td>性别</td>
	      <td>${stu.gender }</td>
	      <td>出生年月</td>
		  <td><fmt:formatDate value="${stu.birthday}" pattern="yyyy年MM月dd日" /></td>
	      <td rowspan="5" style="text-align: center;">
	       <img src="${stu.headPicUrl }" style="width:127px;height:158px;text-align: center;" />
	       <br>相片<br><font class="gray">(盖录取学校骑缝章)</font></td>
	    </tr>
	    <tr>
	      <td>曾用名</td>
	      <td>${stu.usedName }</td>
	      <td>名族</td>
	      <td>${stu.nationality }</td>
	      <td>健康情况</td>
		  <td>${stu.healthyCondition }</td>
	    </tr>
	    <tr>
	      <td>特长</td>
	      <td colspan="5" style="text-align: left;">${stu.rewardHobby }</td>
	    </tr>
	    <tr>
	      <td>身份证号</td>
	      <td colspan="5">${stu.IDCard }</td>
	    </tr>
	    <tr>
	      <td>籍贯</td>
	      <td colspan="5">${stu.nativePlace }</td>
	    </tr>
	    <tr>
	      <td>家庭住址</td>
	      <td colspan="6">${stu.homeAddress }</td>
	    </tr>
	    <tr>
	      <td>户口所在地</td>
	      <td colspan="6">${stu.domicile }</td>
	    </tr>
	    <tr>
	      <td>第一联系人</td>
	      <td colspan="2">${stu.fullName1 }</td>
	      <td>联系电话</td>
	      <td colspan="3">${stu.telephone1 }</td>
	    </tr>
	    <tr>
	      <td>关系说明</td>
	      <td colspan="2">${stu.relationship1 }</td>
	      <td>工作单位</td>
	      <td colspan="3">${stu.unit1 }</td>
	    </tr>
	    <tr>
	      <td>第二联系人</td>
	      <td colspan="2">${stu.fullName2 }</td>
	      <td>联系电话</td>
	      <td colspan="3">${stu.telephone2 }</td>
	    </tr>
	    <tr>
	      <td>关系说明</td>
	      <td colspan="2">${stu.relationship2 }</td>
	      <td>工作单位</td>
	      <td colspan="3">${stu.unit2 }</td>
	    </tr>
	    <tr>
	      <td rowspan="2">查验<br>资料</td>
	      <td>体检表</td>
	      <td>预防接种证</td>
	      <td>计生证</td>
	      <td>户口本</td>
	      <td>就业证明</td>
	      <td colspan="2">房产证或购房协议</td>
	    </tr>
	    <tr>
	      <td>${stu.tjb }</td>
	      <td>${stu.yfjzzh }</td>
	      <td>${stu.jszh }</td>
	      <td>${stu.hkb }</td>
	      <td>${stu.jyzm }</td>
	      <td colspan="2">${stu.fczhhgfxy }</td>
	    </tr>
		
	    <tr>
	      <td>面试<br>情况</td>
	      <td colspan="3"></td>
	      <td>学校意见</td>
	      <td colspan="4"></td>
	    </tr>
	    <tr>
		
	    <tr>
	      <td>录<br>取<br>意<br>见<br></td>
	      <td colspan="3" ><div style="text-align: left;"> 录取学校：<br/><br/></div><div style="text-align: right;">（盖章）<br/> 年　　月　　日 </div></td>
	      <td colspan="4"><div style="text-align: left;"> 录取学校：<br/><br/></div><div style="text-align: right;">（盖章）<br/> 年　　月　　日 </div></td>
	    </tr>
	  </table>
	  
	</div> <!--#box-->
</c:forEach>
</body>
</html>
  