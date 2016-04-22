<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
	<title>${title }</title>
	<script src="/plugin/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script src="/plugin/lodop/LodopFuncs.js" type="text/javascript"></script>
	<script type="text/javascript">
		function exportMyStudent(){
			var ids=[];
			$(".fieldset_border").each(function () {
				ids.push($(this).attr("id"));
		    });
			if(ids.length==0){
				alert('当前没有要学生数据');
			}else{
				alert('尚未开放');
				/* var url="/student/downloadHtml.action?ids="+ids.join(',');
				window.open(url); */
			}
		}
	</script>
</head>
<body>
<div style="text-align: left;width:920px; height: 35px;margin:0 auto;">
    <input type="button" value="打印" style="margin-top: 2px; cursor: pointer;margin-left:30px;border:solid 1px #ccc;padding:5px 10px;" onclick="prn1_preview();" />
    <input type="button" value="导出" style="margin-top: 2px; cursor: pointer;margin-left:30px;border:solid 1px #ccc;padding:5px 10px;display: none;" onclick="exportMyStudent();" />
</div>
<c:if test="${not empty studentList and fn:length(studentList)>0 }">
	<c:forEach var="item" items="${studentList }" >
		<fieldset class="fieldset_border" id="${item.id }" style="width:800px;min-height:1000px;margin:0px auto 0px 0px ; padding:10px 20px; border: 1px solid #DEDEDE; text-align: left; ">
			<div style="line-height: 50px;font-weight: bold;font-size: 24px;text-align: center;">学生信息</div>
			
			<div style="float: left;width: 70%;">
				<div class="form_item" style="margin: 8px 0 12px 0; text-align: left; clear: both;">
					<span class="form_span" style="text-align: right; width: 140px; line-height: 22px; float: left;">姓　　名：</span>
					<span id="name">${item.name }</span>
				</div>
				<div class="form_item" style="margin: 8px 0 12px 0; text-align: left; clear: both;">
					<span class="form_span" style="text-align: right; width: 140px; line-height: 22px; float: left;">证件号码：</span>
					<span id="certificate">${item.certificate }</span>　
					<span id="certificateType">(${item.certificateType })</span>
				</div>
				<div class="form_item" style="margin: 8px 0 12px 0; text-align: left; clear: both;">
					<span class="form_span" style="text-align: right; width: 140px; line-height: 22px; float: left;">小学学籍号：</span>
					<span id="enrollmentNumbers">${item.enrollmentNumbers }</span>
				</div>
				<div class="form_item" style="margin: 8px 0 12px 0; text-align: left; clear: both;">
					<span class="form_span" style="text-align: right; width: 140px; line-height: 22px; float: left;">性　　别：</span>
					<span id="gender">${item.gender }</span>
				</div>
				
				<div class="form_item" style="margin: 8px 0 12px 0; text-align: left; clear: both;">
					<span class="form_span" style="text-align: right; width: 140px; line-height: 22px; float: left;">民　　族：</span>
					<span id="nationality" >${item.nationality }</span>
				</div>
				<div class="form_item" style="margin: 8px 0 12px 0; text-align: left; clear: both;">
					<span class="form_span" style="text-align: right; width: 140px; line-height: 22px; float: left;">籍　　贯：</span>
					<span id="nativePlace">${item.nativePlace }</span>
				</div>
			</div>
			<div style="float: left;width: 25%;text-align: right;">
				<img  src="${item.headPicUrl }" alt="" style="width: 128px; height: 160px;margin-left:0px; vertical-align: middle; border: 1px solid #DEDEDE; border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px;"  />
			</div>
			<div style="clear: both;"></div>
			<div class="form_item" style="margin: 8px 0 12px 0; text-align: left; clear: both;">
				<span class="form_span" style="text-align: right; width: 140px; line-height: 22px; float: left;">户　　籍：</span>
				<span id="domicile">
					<c:choose>
						<c:when test="${item.domicileArea eq '其他' }">${item.domicile }</c:when>
						<c:otherwise>${item.domicileProvince }${item.domicileCity }${item.domicileArea }${item.domicile }</c:otherwise>
					</c:choose>
				</span>
			</div>
			<div class="form_item" style="margin: 8px 0 12px 0; text-align: left; clear: both;">
				<span class="form_span" style="text-align: right; width: 140px; line-height: 22px; float: left;">家庭住址：</span>
				<span id="homeAddress">${item.homeAddress }</span>
			</div>
			<div class="form_item" style="margin: 8px 0 12px 0; text-align: left; clear: both;">
				<span class="form_span" style="text-align: right; width: 140px; line-height: 22px; float: left;">毕业学校：</span>
				<span id="graduate">
					<c:choose>
						<c:when test="${item.graduateArea eq '其他' }">${item.graduate }</c:when>
						<c:otherwise>${item.graduateProvince }${item.graduateCity }${item.graduateArea }${item.graduate }</c:otherwise>
					</c:choose>
				</span>
			</div>
			<div class="form_item" style="margin: 8px 0 12px 0; text-align: left; clear: both;">
				<span class="form_span" style="text-align: right; width: 140px; line-height: 22px; float: left;">出生日期：</span>
				<span id="birthday"><fmt:formatDate value="${item.birthday }" pattern="yyyy年MM月dd日" /> </span>
			</div>
			<div class="form_item" style="margin: 8px 0 12px 0; text-align: left; clear: both;">
				<span class="form_span" style="text-align: right; width: 140px; line-height: 22px; float: left;">联系手机：</span>
				<span id="phoneNumber">${item.phoneNumber }</span>
			</div>
			<div class="form_item" style="margin: 8px 0 12px 0; text-align: left; clear: both;">
				<span class="form_span" style="text-align: right; width: 140px; line-height: 22px; float: left;">获奖及个人特长：</span>
				<span id="rewardHobby">${item.rewardHobby }</span>
			</div>
			<div class="form_item" style="margin: 8px 0 12px 0; text-align: left; clear: both;">
				<span class="form_span" style="text-align: right; width: 140px; line-height: 22px; float: left;">联系人1：</span>
				<span id="relationship1">${item.relationship1 }</span> 
				<span id="fullName1">${item.fullName1 }</span> 
				所在单位 <span id="unit1">${item.unit1 }</span> 
				职位 <span id="position1">${item.position1 }</span> 
				联系电话 <span id="telephone1">${item.telephone1 }</span>
			</div>
			<div class="form_item" style="margin: 8px 0 12px 0; text-align: left; clear: both;">
				<span class="form_span" style="text-align: right; width: 140px; line-height: 22px; float: left;">联系人2：</span>
				<span id="relationship2">${item.relationship2 }</span> 
				<span id="fullName2">${item.fullName2 }</span> 
				所在单位 <span id="unit2">${item.unit2 }</span> 
				职位 <span id="position2">${item.position2 }</span> 
				联系电话 <span id="telephone2">${item.telephone2 }</span>
			</div>
			<div style="clear: both;"></div>
		</fieldset>
		<br/><br/>
	</c:forEach>
</c:if>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0">
    <embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="/plugin/lodop/install_lodop.exe"></embed>
</object>
<script type="text/javascript">
var LODOP= getLodop(document.getElementById('LODOP'), document.getElementById('LODOP_EM'));  
//打印
function prn1_preview() {
    CreateOneFormPage();
    LODOP.PREVIEW();
};
function CreateOneFormPage() {
    LODOP.PRINT_INIT("打印");
    LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");
    $(".fieldset_border").each(function () {
        var $this = $(this);
        LODOP.NewPage();
        LODOP.SET_PRINT_TEXT_STYLE(1, "宋体", 18, 1, 0, 0, 1);
        LODOP.ADD_PRINT_HTM(0, 30, 700, 1200, $this.html());
    });
};
</script>
</body>
</html>