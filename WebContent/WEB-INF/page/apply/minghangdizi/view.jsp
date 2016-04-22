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
.head_Img_Div{position:absolute;z-index: 2px;top:80px;left: 400px;}
.headImg{
margin:5px;width: 128px;height: 160px;cursor:pointer;vertical-align: middle;border:1px solid #DEDEDE;border-radius:3px;-webkit-border-radius:3px;-moz-border-radius:3px;}
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
			<span class="form_span" >出生日期：</span>
			<span id="birthday"><fmt:formatDate value="${student.birthday}" pattern="yyyy-MM-dd" /></span>
		</div>
		<div class="form_item" >
			<span class="form_span" >性		别：</span>
			<span id="name">${student.gender}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >身份证号码：</span>
			<span id="certificate">${student.IDCard}</span>　
		</div>
		<div class="form_item" >
			<span class="form_span" >学籍号：</span>
			<span id="enrollmentNumbers">${student.inSchoolNo}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >毕业学校：</span>
			<span id="graduate">${student.graduate }</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >曾任何种职务：</span>
			<span id="gender">${student.position}　</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >籍　　贯：</span>
			<span id="nativePlace">${student.nativePlaceProvince}${student.nativePlaceCity}　</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >户口所在：</span>
			<span id="domicile">
				<c:choose>
					<c:when test="${empty student.domicileArea}">
						${student.domiciProvince}市${student.domicilCity}区
					</c:when>
					<c:otherwise>
						${student.domiciProvince}省${student.domicilCity}市${student.domicileArea}
					</c:otherwise>
				</c:choose>
			</span>　
		</div>
		<div class="form_item" >
			<span class="form_span" >是否农业：</span>
			<span id="graduate">${student.isPeasant==0?'否':'是' }</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >家庭住址：</span>
			<span id="homeAddress">${student.homeAddress}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >家庭电话：</span>
			<span id="homeAddress">${student.homePhone}　</span>
		</div>
		
		<div class="form_item" >
			<span class="form_span" >父亲手机：</span>
			<span id="phoneNumber">${student.fatherPhone}　</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >母亲手机：</span>
			<span id="phoneNumber">${student.matherPhone}　</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >学科竞赛获奖情况：</span>
			<span id="rewardHobby">${student.rewardHobby}　</span>
		</div>
		
		<div class="form_item" >
			<span class="form_span" >家庭主要成员：</span>
			<span>
				${student.relationship1}-${empty student.fullName1 ? '' : student.fullName1}
				<c:if test="${not empty  student.unit1 }">,工作单位-${student.unit1 }</c:if>
				<c:if test="${not empty  student.telephone1 }">,单位电话:${student.telephone1 }</c:if>
			</span>　
		</div>
		<div class="form_item" > 
			<span class="form_span" >　</span>
			<span>
				${student.relationship2}-${empty student.fullName2 ? '' : student.fullName2}
				<c:if test="${not empty  student.unit2 }">,工作单位-${student.unit2 }</c:if>
				<c:if test="${not empty  student.telephone2 }">,单位电话:${student.telephone2 }</c:if>
			</span>　
		</div>
		<div class="form_item" >
			<span class="form_span" >单位：</span>
			<span id="phoneNumber">${student.companyName}</span>
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