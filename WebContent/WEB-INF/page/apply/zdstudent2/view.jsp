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
.form_item span{
line-height: 22px;
}
.head_Img_Div{
 position:absolute;
 z-index: 2px;
 top:80px;
 left: 400px;
}
.headImg{
margin:5px;
width: 128px;
height: 160px;
cursor:pointer;
vertical-align: middle;
border:1px solid #DEDEDE;
border-radius:3px;
-webkit-border-radius:3px;
-moz-border-radius:3px;
}
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

//打印
function print(){
	var ids='${student.id}';
	var name = '${student.name}';
	if(ids.length > 0){
		art.dialog.confirm('您确认要打印 [ '+name+' ]的信息(点击确认将进入打印预览)?',function(){
			window.open( '/zd_student2/toPrint.action?ids='+ids);
		});
	}
};

</script>
</head>
<body>
<div style="width:100%;line-height: 25px;text-align: left;">
    <a id="printStudent" href=" javascript:print()"   style="margi-top: 10px;margin-left:40px;cursor: pointer;border:solid 1px #ccc;padding:5px 10px;" >打印</a>
</div>
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
			<span class="form_span" >姓名拼音：</span>
			<span id="namePinyin">${student.namePinyin}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >曾用名：</span>
			<span id="usedName">${student.usedName}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >登录帐号：</span>
			<span id="account">${student.account}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >报名日期：</span>
			<span id="updateTime"><fmt:formatDate value="${student.updateTime}" pattern="yyyy-MM-dd" /></span>
		</div>
		<div class="form_item" >
			<span class="form_span" >面试日期：</span>
			<span id="interViewDate">${empty student.interViewDate ? '未定' : student.interViewDate }</span>
		</div>
		
		<%-- <div class="form_item" >
			<span class="form_span" >申请状态：</span>
			<span style="color:red;" id="status">
			<c:choose>
				<c:when test="${student.status==0 }">待审核</c:when>
				<c:when test="${student.status==1 }">审核通过</c:when>
				<c:when test="${student.status==2 }">审核不通过(${student.checkRemark })</c:when>
			</c:choose>
			</span>
		</div> --%>
		<div class="form_item" >
			<span class="form_span" >身份证：</span>
			<span id="IDCard">${student.IDCard}</span>　
		</div>
		<div class="form_item" >
			<span class="form_span" >性　　别：</span>
			<span id="gender">${student.gender}</span>
		</div>
		
		<div class="form_item" >
			<span class="form_span" >国　　家：</span>
			<span id="country">${student.country}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >民　　族：</span>
			<span id="nationality">${student.nationality}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >政治面貌：</span>
			<span id="nationality">${student.politicsStatus}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >港澳台侨外：</span>
			<span id="IsPeasant">${student.isOutSide}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >户口性质：</span>
			<span id="IsPeasant">${student.peasant}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >籍　　贯：</span>
			<span id="nativePlace">${student.nativePlaceProvince} ${student.nativePlaceCity}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >户　　籍：</span>
			<span id="domicile">
				<c:choose>
					<c:when test="${student.domicileArea eq '其他'}">
						${student.domicile}
					</c:when>
					<c:otherwise>
						${student.domiciProvince}${student.domicilCity}${student.domicileArea}${student.domicile}
					</c:otherwise>
				</c:choose>
			</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >现家庭住址：</span>
			<span id="homeAddress">${student.homeAddress}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >通讯住址：</span>
			<span id="homeAddress">${student.mailingAddress}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >毕业学校：</span>
			<span id="graduate">
				<c:choose>
					<c:when test="${student.graduateArea eq '其他'}">
						${student.graduate}
					</c:when>
					<c:otherwise>
						${student.graduateProvince}${student.graduateCity}${student.graduateArea}${student.graduate}
					</c:otherwise>
				</c:choose>
			</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >出生日期：</span>
			<span id="birthday"><fmt:formatDate value="${student.birthday}" pattern="yyyy-MM-dd" /></span>
		</div>
		<div class="form_item" >
			<span class="form_span" >出生地址：</span>
			<span id="birthdayAddress">${student.birthdayAddress }</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >联系手机：</span>
			<span id="homePhone">${student.homePhone}</span>
		</div>
		<%-- <div class="form_item" >
			<span class="form_span" >父亲身份证：</span>
			<span id="fatherIDCard">${student.fatherIDCard}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >母亲身份证：</span>
			<span id="motherIDCard">${student.motherIDCard}</span>
		</div> --%>
		<div class="form_item" >
			<span class="form_span" >健康状况：</span>
			<span id="rewardHobby">${student.healthyCondition}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >获奖及个人特长：</span>
			<span id="rewardHobby">${student.rewardHobby}</span>
		</div>
		<div class="form_item" >
			<span class="form_span"  >面试成绩：</span>
			<span id="interviewScore">${empty student.interviewScore ? '<span style="color:red">(尚未参加面试)</span>' : student.interviewScore}</span>
		</div>
		<div class="form_item" >
			<span class="form_span"  >是否录取：</span>
			<span id="admit"  style="color:red">${student.admit==0?'未录取':(student.admit==-1?'待公布' : '已录取')}</span>
		</div>
		<div class="form_item" >
			<span class="form_span"  >单　　位：</span>
			<span id="companyName">${student.companyName}</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >联系人1：</span>
			<span>
				${student.relationship1}${empty student.fullName1 ? '' : student.fullName1}
				<c:if test="${not empty  student.nationality1 }">,民族:${student.nationality1 }</c:if>
				<c:if test="${not empty  student.domicile1 }">,户口所在地:${student.domicile1 }</c:if>
				<c:if test="${not empty  student.unit1 }">,所在单位:${student.unit1 }</c:if>
				<c:if test="${not empty  student.position1 }">,职位:${student.position1 }</c:if>
				<c:if test="${not empty  student.telephone1 }">,联系电话:${student.telephone1 }</c:if>
				<c:if test="${not empty  student.IDCard1 }">,身份证号:${student.IDCard1 }</c:if>
			</span>
		</div>
		<div class="form_item" >
			<span class="form_span" >联系人2：</span>
			<span>
				${student.relationship2}${empty student.fullName2 ? '' : student.fullName2}
				<c:if test="${not empty  student.nationality2 }">,民族:${student.nationality2 }</c:if>
				<c:if test="${not empty  student.domicile2 }">,户口所在地:${student.domicile2 }</c:if>
				<c:if test="${not empty  student.unit2 }">,所在单位${student.unit2 }</c:if>
				<c:if test="${not empty  student.position2 }">,职位${student.position2 }</c:if>
				<c:if test="${not empty  student.telephone2 }">,联系电话${student.telephone2 }</c:if>
				<c:if test="${not empty  student.IDCard2 }">,身份证号:${student.IDCard2 }</c:if>
			</span>
		</div>
		
		<div style="clear: both;"></div>
</div>
<div style="clear: both;"></div>
</fieldset>
</body>
</html>