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
			<span class="form_span" >　曾用名：</span>
			<span id="name">${student.usedName}</span>
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
			<span class="form_span" >身份证号码：</span>
			<span id="certificate">${student.IDCard}</span>　
		</div>
		<div class="form_item" >
			<span class="form_span" >民族：</span>
			<span id="enrollmentNumbers">${student.nationality}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >籍　　贯：</span>
			<span id="nativePlace">${student.nativePlaceProvince}${student.nativePlaceCity}　</span>
		</div>
		
		<div class="form_item" >
			<span class="form_span" >健康情况：</span>
			<span id="enrollmentNumbers">${student.healthyCondition}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >特长：</span>
			<span id="graduate">${student.rewardHobby }</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >家庭住址：</span>
			<span id="homeAddress">${student.homeAddress}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >户口所在：</span>
			<span id="domicile">
				${student.domicile }
			</span>　
		</div>
		
		<div class="form_item" >
			<span class="form_span" >第一联系人：</span>
			<span>
				${student.relationship1}-${empty student.fullName1 ? '' : student.fullName1}
				<c:if test="${not empty  student.unit1 }">,工作单位-${student.unit1 }</c:if>
				<c:if test="${not empty  student.telephone1 }">,单位电话:${student.telephone1 }</c:if>
			</span>　
		</div>
		<div class="form_item" >
			<span class="form_span" >第二联系人：</span>
			<span>
				${student.relationship2}-${empty student.fullName2 ? '' : student.fullName2}
				<c:if test="${not empty  student.unit2 }">,工作单位-${student.unit2 }</c:if>
				<c:if test="${not empty  student.telephone2 }">,单位电话:${student.telephone2 }</c:if>
			</span>　
		</div>
		<div class="form_item" >
			<span class="form_span" >了解渠道：</span>
			<span>${student.ljqd}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >地段生：</span>
			<span>${student.dds}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >业主生：</span>
			<span>${student.yzs}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >广州户籍非地段生：</span>
			<span>${student.gzhjfdds}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >非广州户籍学生：</span>
			<span>${student.fgzhjxs}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >体检表：</span>
			<span>${student.tjb}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >预防接种证：</span>
			<span>${student.yfjzzh}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >计生证：</span>
			<span>${student.jszh}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >户口本：</span>
			<span>${student.hkb}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >就业证明：</span>
			<span>${student.jyzm}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >房产证或购房协议：</span>
			<span>${student.fczhhgfxy}</span>
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