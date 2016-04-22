<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<style type="text/css">
.form_item span{line-height: 22px;}
.head_Img_Div{position:absolute;z-index: 2px;top:80px;left: 600px;}
.headImg{
margin:5px;width: 128px;height: 160px;cursor:pointer;vertical-align: middle;border:1px solid #DEDEDE;border-radius:3px;-webkit-border-radius:3px;-moz-border-radius:3px;}
.table_scode{width:600px;border-collapse: collapse;}
.table_scode td{border: 1px solid #DEDEDE;text-align: center;line-height: 30px;}
</style>
<script type="text/javascript">
$(function(){
	$("#headPicUrl").click(function(){
		art.dialog({
		    padding: 0,
		    title: '照片',
		    content: '<img src="'+$(this).attr("src")+'" width="379" height="500" />',
		    lock: true
		});
	});
});

</script>
</head>
<body>
<fieldset class="fieldset_border">
<div id="printPage">
<div class="head_Img_Div">
	<img id="headPicUrl" class="headImg" alt="点击看大图" src="${student.headPicUrl }" />
</div>
		<div class="form_item" >
			<span class="form_span" >姓　　名：</span>
			<span id="name">${student.name}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >性		别：</span>
			<span id="name">${student.gender}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >出生日期：</span>
			<span id="birthday"><fmt:formatDate value="${student.birthday}" pattern="yyyy-MM-dd" /></span>
		</div>
		<div class="form_item" >
			<span class="form_span" >毕业小学：</span>
			<span id="certificate">${student.graduation}</span>　
		</div>
		<div class="form_item" >
			<span class="form_span" >曾任职务：</span>
			<span id="enrollmentNumbers">${student.position}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >户口所在地：</span>
			<span id="nativePlace">${student.domicile}　</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >家庭住址：</span>
			<span id="homeAddress">${student.homeAddress}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >父亲：</span>
			<span>
				姓名 - ${student.fullName1}
				<c:if test="${not empty  student.unit1 }">,工作单位 - ${student.unit1}</c:if>
				<c:if test="${not empty  student.telephone1 }">,联系方式 - ${student.telephone1 }</c:if>
			</span>　
		</div>
		<div class="form_item" >
			<span class="form_span" >母亲：</span>
			<span>
				姓名 - ${student.fullName2}
				<c:if test="${not empty  student.unit2 }">,工作单位 - ${student.unit2}</c:if>
				<c:if test="${not empty  student.telephone2 }">,联系方式 - ${student.telephone2 }</c:if>
			</span>　
		</div>
		<div class="form_item" >
			<span class="form_span" >特长：</span>
			<span id="graduate">${student.hobby }</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >近两年成绩：</span>
			<table class="table_scode">
				<tr>
					<td colspan="4">五年级第一、二学期期末成绩</td>
					<td colspan="4">六年级第一、二学期期末成绩</td>
				</tr>
				<tr>
					<td>语文</td>
					<td>数学</td>
					<td>英语</td>
					<td>级排名</td>
					<td>语文</td>
					<td>数学</td>
					<td>英语</td>
					<td>级排名</td>
				</tr>
				<tr>
					<td>${student.yuwen1 }</td>
					<td>${student.shuxue1 }</td>
					<td>${student.yingyu1 }</td>
					<td>${student.paiming1 }</td>
					<td>${student.yuwen3 }</td>
					<td>${student.shuxue3 }</td>
					<td>${student.yingyu3 }</td>
					<td>${student.paiming3 }</td>
				</tr>
				<tr>
					<td>${student.yuwen2 }</td>
					<td>${student.shuxue2 }</td>
					<td>${student.yingyu2 }</td>
					<td>${student.paiming2 }</td>
					<td>${student.yuwen4 }</td>
					<td>${student.shuxue4 }</td>
					<td>${student.yingyu4 }</td>
					<td>${student.paiming4 }</td>
				</tr>
			</table>
		</div>
		<div class="form_item" >
			<span class="form_span" >区以上获奖情况：</span>
			<span id="graduate">${student.rewardInArea }</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >校内获奖情况：</span>
			<span id="graduate">${student.rewardInSchool }</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >报名时间：</span>
			<span id="phoneNumber"><fmt:formatDate value="${student.createTime}" pattern="yyyy-MM-dd" /></span>
		</div>
		<div style="clear: both;"></div>
</div>
<div style="clear: both;"></div>
</fieldset>
</body>
</html>