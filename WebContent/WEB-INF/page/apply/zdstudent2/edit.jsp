<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="/plugin/kindeditor-4.1.10/themes/default/default.css" />
<script charset="utf-8" src="/plugin/kindeditor-4.1.10/kindeditor-min.js"></script>
<script charset="utf-8" src="/plugin/kindeditor-4.1.10/lang/zh_CN.js"></script>
<title>${title }</title>
<%@ include file="/common/taglibs.jsp" %>
<script type="text/javascript">
var edtStudentManager;
$(function(){
	edtStudentManager=new EdtStudentManager();
	$(".required").blur(function(){
		if(!$(this).val()){
			$(this).parent().next().text("此项不能为空");
		}else{
			$(this).parent().next().text("");
		}
	});
	$("#headImg").click(function(){
		art.dialog({
		    padding: 0,
		    title: '照片',
		    content: '<img src="'+$(this).attr("src")+'"  />',
		    lock: true
		});
	});
	
	var graduateProvince="${student.graduateProvince}";
	var graduateCity="${student.graduateCity}";
	var graduateArea="${student.graduateArea}";
	if(graduateArea=="其他"){
		$("#graduateProvince").val("");
		$("#graduateCity").val("");
	}else{
		$("#graduateProvince").val(graduateProvince);
		$("#graduateCity").val(graduateCity);
	}
	$("#graduateArea").val(graduateArea);
	var domiciProvince="${student.domiciProvince}";
	var domicilCity="${student.domicilCity}";
	var domicileArea="${student.domicileArea}";
	if(domicileArea=="其他"){
		$("#domiciProvince").val("");
		$("#domicilCity").val("");
	}else{
		$("#domiciProvince").val(domiciProvince);
		$("#domicilCity").val(domicilCity);
	}
	$("#domicileArea").val(domicileArea);
	$("#gender").val("${student.gender}");
	$("#certificateType").val("${student.certificateType}");
	
});
function EdtStudentManager(){
	this.checkAccount = function(submit){
		var account=$("#account").val();
		var id=$("#id").val();
		if(!account)return;
		$.post('/student/checkAccount.action',{account:account,id:id},function(data){
			if(data=='false'){
				if(submit){
					$.post('/student/update.action',$("#studentForm").serialize(),function(data){
						if(data=='succeed'){
							art.dialog.opener.mngStudent.load();
							art.dialog.close();
						}else{
							art.dialog.alert(data.msg);
						}
					});
				}
			}else{
				$("#account").parent().next().text("帐号已存在");
			}
		});
	};
	this.save = function (){
		var pass=true;
		$(".required").each(function(){
			if(!$(this).val()){
				$(this).parent().next().text("此项不能为空");
				pass=false;
			}
		});
		if(!$('#headPicUrl').val()){
			$("#photoup").next().removeClass("hasphoto").addClass("phototips").css("color","red").text("请上传本人近期小一寸彩色免冠照");
			if(checkpass){
				$("html,body").animate({scrollTop:$("#btn_top").offset().top},1000);
				art.dialog.tips("请上传报读人近期小一寸彩色免冠照");
			}
			pass=false;
		}else{
			$("#photoup").next().removeClass("phototips").addClass("hasphoto").text("已上传照片");
		}
		if(pass){
			edtStudentManager.checkAccount('submit');
		}
	};
}
var uploadbutton;
KindEditor.ready(function(K) {
	  uploadbutton = K.uploadbutton({
		button : K('#uploadBtn')[0],
		fieldName : 'attachmentTempPath',
		url : '/uploadFile/save.action?modleName=applyFace',
		afterUpload : function(data) {
			if (data.error === 0) {
				K('#headImg').attr("src",data.url);
				K('#headPicUrl').val(data.url);
				$("#photoup").next().removeClass("phototips").addClass("hasphoto").text("已上传照片");
			} else {
				$("#photoup").next().removeClass("hasphoto").addClass("phototips").text(data.msg?data.msg:'上传失败，请重试');
			}
		},
		afterError : function(str) {
			$("#photoup").next().removeClass("hasphoto").addClass("phototips").text(data.msg?data.msg:'上传失败，请重试');
		}
	});
	uploadbutton.fileBox.change(function(e) {
		uploadbutton.submit();
	});
}); 
</script>
<style type="text/css">
tr{
height: 40px;
}
.tdtext{
text-align: right;
width: 140px;
}
.text{
text-align:left;
width:340px;
}
.text span{
text-align: left;
}
</style>
</head>
<body>
<form id="studentForm" action="">
	<input type="hidden" name="id" id="id" value="${student.id }" />
    <table>
    	<tr>
    		<td class="tdtext">学生姓名</td>
    		<td class="text">
    			<span>
	    			<input name="name" type="text" value="${student.name }" class="piece required" maxlength="40"  />
				</span>
				<span class="red">*</span>
    		</td>
    		<td rowspan="4" colspan="2" align="center">
					<div id="photo">
						<img id="headImg" src="${student.headPicUrl }" style="width: 128px; height: 160px;" />
					</div>
					<div id="photoup"><!-- 上传照片 -->
						<div  style="display: block;">
							<input type="button" id="uploadBtn" value="上传图片"/>
						</div>
						<input type="hidden" name="headPicUrl" id="headPicUrl" value="${student.headPicUrl }"/>
					</div>
					<div class="phototips">必须是本人近期小一寸彩色免冠照</div>
    		</td>
    	</tr>
    	<tr>
    		<td class="tdtext">登录帐号</td>
    		<td class="text">
    			<span>
					<input name="account" id="account" value="${student.account }" onblur="edtStudentManager.checkAccount()" type="text" class="piece required"  maxlength="40" />
				</span>
				<span class="red">*</span>
    		</td>
    	</tr>
    	<tr>
    		<td class="tdtext">证件号码</td>
    		<td class="text">
    			<span>
					<select name="certificateType" id="certificateType" class="piece required" style="width:206px">
							<c:forEach var="item" items="${certificateList}">
								<option value="${item.name }" >${item.name }</option>
							</c:forEach>
					</select><br/>
					<input name="certificate" value="${student.certificate }" type="text" class="piece required"  maxlength="40" />
				</span>
				<span class="red">*</span>
    		</td>
    	</tr>
    	<tr>
    		<td class="tdtext">小学学籍号</td>
			<td class="text">
				<span>
					<input name="enrollmentNumbers" value="${student.enrollmentNumbers }" type="text" class="piece required"   maxlength="40"  />
				</span>
				<span class="red">*</span>
			</td>
    	</tr>
		<tr>
			<td class="tdtext">性别</td>
			<td class="text">
				<span class="text">
					<select name="gender" id="gender" class="piece"  style="width:206px">
						<option value="男" >男</option>
						<option value="女" >女</option>
					</select>
				</span>
				<span class="red"></span>
			</td>
			<td class="tdtext">民族</td>
			<td class="text">
				<span class="text">
					<input name="nationality" value="${student.nationality }" type="text" class="piece required"  maxlength="40"  />
				</span>
				<span class="red">*</span>
			</td>
		</tr>
    	<tr>
			<td class="tdtext">籍贯</td>
			<td class="text">
				<span>
					<input name="nativePlace" value="${student.nativePlace }" type="text" class="piece required"  maxlength="40" />
				</span>
				<span class="red">*</span>
			</td>
			<td class="tdtext">家庭住址</td>
			<td class="text">
				<span >
					<input name="homeAddress"  value="${student.homeAddress }" type="text" class="piece required"  maxlength="200"/>
				</span>
				<span class="red">*</span>
			</td>
	</tr>
	<tr>
		<td class="tdtext">户籍所在地</td>
			<td class="text">
				<span>
					<select name="domiciProvince" id="domiciProvince" class="piece" style="display: none;">
							<option value="广东省" selected="selected">广东省</option>
							<option value=""></option>
					</select>
					<select name="domicilCity" id="domicilCity" class="piece" style="display: none;">
							<option value="广州市"  selected="selected">广州市</option>
							<option value=""></option>
					</select>
					<select name="domicileArea" id="domicileArea" class="piece required" style="width:206px">
							<option selected="selected" value="天河区" >天河区</option>
							<option value="越秀区">越秀区</option>
							<option value="荔湾区">荔湾区</option>
							<option value="海珠区">海珠区</option>
							<option value="白云区">白云区</option>
							<option value="黄埔区">黄埔区</option>
							<option value="番禺区">番禺区</option>
							<option value="花都区">花都区</option>
							<option value="南沙区">南沙区</option>
							<option value="萝岗区">萝岗区</option>
							<option value="增城市">增城市</option>
							<option value="从化市">从化市</option>
							<option value="其他">其他</option>
					</select>
					<input name="domicile" id="domicile" value="${student.domicile }" type="text" class="piece required"  maxlength="200" />
				</span>
				<span class="red">*</span>
			</td>
		<td class="tdtext">毕业学校</td>
		<td class="text">
			<span>
				<select name="graduateProvince" id="graduateProvince" class="piece" style="display: none;">
						<option value="广东省" selected="selected">广东省</option>
						<option value=""></option>
				</select>
				<select name="graduateCity" id="graduateCity"  class="piece" style="display: none;">
						<option value="广州市"  selected="selected">广州市</option>
						<option value=""></option>
				</select>
				<select name="graduateArea" id="graduateArea" class="piece required"  style="width:206px">
						<option selected="selected" value="天河区">天河区</option>
						<option value="越秀区">越秀区</option>
						<option value="荔湾区">荔湾区</option>
						<option value="海珠区">海珠区</option>
						<option value="白云区">白云区</option>
						<option value="黄埔区">黄埔区</option>
						<option value="番禺区">番禺区</option>
						<option value="花都区">花都区</option>
						<option value="南沙区">南沙区</option>
						<option value="萝岗区">萝岗区</option>
						<option value="增城市">增城市</option>
						<option value="从化市">从化市</option>
						<option value="其他">其他</option>
				</select>
				<input name="graduate" id="graduate"  value="${student.graduate }" type="text" class="piece required"   maxlength="40" />
			</span>
			<span class="red">*</span>
		</td>
	</tr>
	<tr>
		<td class="tdtext">出生日期<br /> </td>
		<td class="text">
			<span >
				<input name="birthday1"  value='<fmt:formatDate value="${student.birthday }" pattern="yyyy-MM-dd" />' type="text" class="piece required" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"  maxlength="10" />
			</span>
			<span class="red">*</span>
		</td>
		<td class="tdtext">联系手机</td>
		<td class="text">
			<span >
				<input name="phoneNumber" value="${student.phoneNumber }"  type="text" class="piece required"  maxlength="15">
			</span>
			<span class="red">*</span>
		</td>
	</tr>
	<tr>
		<td class="tdtext">父亲姓名</td>
		<td class="text">
			<span >
				<input name="fullName1"  value="${student.fullName1 }" type="text" class="piece required"  maxlength="20"/>
			</span>
			<span class="red">*</span>
		</td>
		<td class="tdtext">母亲姓名</td>
		<td class="text">
			<span >
				<input name="fullName2" value="${student.fullName2 }" type="text" class="piece required"  maxlength="20"/>
			</span>
			<span class="red">*</span>
		</td>
	</tr>
	
	<tr>
		<td class="tdtext">父亲所在单位</td>
		<td class="text">
			<span >
				<input name="unit1"  value="${student.unit1 }" type="text" class="piece required"  maxlength="40"/>
			</span>
			<span class="red">*</span>
		</td>
		<td class="tdtext">母亲所在单位</td>
		<td class="text">
			<span >
				<input name="unit2" value="${student.unit2 }" type="text" class="piece required"  maxlength="40"/>
			</span>
			<span class="red">*</span>
		</td>
	</tr>
	<tr>
		<td class="tdtext">父亲职务</td>
		<td class="text">
			<span >
				<input name="position1" value="${student.position1 }" type="text" class="piece required"  maxlength="40"/>
			</span>
			<span class="red">*</span>
		</td>
		<td class="tdtext">母亲职务</td>
		<td class="text">
			<span >
				<input name="position2" value="${student.position2 }" type="text" class="piece required"  maxlength="40"/>
			</span>
			<span class="red">*</span>
		</td>
	</tr>
	<tr>
		<td class="tdtext">父亲联系电话</td>
		<td  class="text">
			<span >
				<input name="telephone1" value="${student.telephone1 }" type="text" class="piece required"  maxlength="15"/>
			</span>
			<span class="red">*</span>
		</td>
		<td class="tdtext">母亲联系电话</td>
		<td class="text">
			<span >
				<input name="telephone2" value="${student.telephone2 }" type="text" class="piece required"  maxlength="15"/>
			</span>
			<span class="red">*</span>
		</td>
	</tr>
	<tr>
		<td class="tdtext">小学年级获得区级以<br /> 上（含区级）获奖情况<br />及个人特长</td>
		<td colspan="3" style="text-align: left;">
			<textarea name="rewardHobby"  style="border: 1px solid rgb(173, 211, 245);width:690px;height:75px; color: rgb(102, 102, 102);">${student.rewardHobby }</textarea>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="text-align: center;">
			<a href="javascript:edtStudentManager.save()" class="base_btn"><span>保存</span></a>
		</td>
	</tr>
    </table>
	<div class="clear"></div>
</form>
</body>
</html>
