<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>template</title>
<c:import url="/common/taglibs.jsp" />
<script>
	$(document).ready(function(){
		$('select[name=sortType]').val("${data.sortType }");
		$("#submitBtn").click(function(){
			$.post("/data/update.action", $("#form").serialize(), function(data){
				if(data && data == 'succeed'){
					art.dialog.opener.loadUrlPage("/data/index.action?labelId=${labelId}");
					art.dialog.close();
				}else{
					alert("缺少必填字段，请重试！");
				}
			});
		});
		$("input[name='everyColumn']").click(function(){
			if($(this).val()=="1"){
				$("input[name='displayPage'][value=0]").attr("checked",true);
			}
		});
		$("input[name='displayPage']").click(function(){
			if($(this).val()=="1"){
				$("input[name='everyColumn'][value=0]").attr("checked",true);
			}
		});
		
		/*点击栏目，异步加载推荐位
		$("#columnList").on("select", "option", function(data){
			$.post("/recommend/findRecommend.action", {columnId: $(this).val()}, function(data){
				
					var dataJSON = $.parseJSON(data);
					var html = "";
					for(item in dataJSON){
						obj = dataJSON[item];
						html += '<option value= "' + obj.id + '">'
							+ obj.name
							+ '</option>';
					}
					$("#recommendId").html("");
					$("#recommendId").append(html);
				
			});
		});*/
	});
	
</script>
</head>
<body>
	<form id="form">
		<input name="labelId" type="hidden" value="${data.labelId }"/>
		<input name="id" type="hidden" value="${data.id }"/>
		<div class="form_item">
			<span class="form_span">名称：</span>
			<input name="name" type="text" class="piece" value="${data.name }"/>
		</div>
		<div class="form_item">
			<span class="form_span">所属栏目：</span>
			<select name="columnId" class="piece" multiple="multiple" style="height: 280px;">
				<option value="-1" <c:if test="${data.columnIds == '-1' }">selected="selected"</c:if> >传参</option>
				<option value="0" <c:if test="${data.columnIds == '0' }">selected="selected"</c:if>>整站</option>
				<c:forEach items="${columnList }" var="column">
					<option value="${column.id }"  <c:if test="${not empty column.selected}">selected="selected"</c:if> >
						<c:forEach begin="1" end="${column.level }">
							&nbsp;&nbsp;
						</c:forEach>${column.name }
					</option>
				</c:forEach>
			</select>
		</div>
		<div class="form_item">
			<span class="form_span">显示数量：</span>
			<input name="size" type="text" class="piece" value="${data.size }"/>
		</div>
		<div class="form_item">
			<span class="form_span">是否分栏目：</span>
			<input name="everyColumn" type="radio" value="0" <c:if test="${(empty data.everyColumn) or data.everyColumn == 0 }">checked="checked"</c:if> />否
			<input name="everyColumn" type="radio" value="1" <c:if test="${data.everyColumn == 1 }">checked="checked"</c:if> />是
		</div>
		<div class="form_item">
			<span class="form_span">是否显示分页：</span>
			<input name="displayPage" type="radio" value="0" <c:if test="${data.displayPage == 0 }">checked="checked"</c:if> />否
			<input name="displayPage" type="radio" value="1" <c:if test="${data.displayPage == 1 }">checked="checked"</c:if> />是
			&nbsp;&nbsp;分栏目查询时该项不起作用
		</div>
		<div class="form_item">
			<span class="form_span">json数据：</span>
			<input name="isJsonData" type="radio" value="0" <c:if test="${(empty data.isJsonData) or data.isJsonData == 0 }">checked="checked"</c:if> />否
			<input name="isJsonData" type="radio" value="1" <c:if test="${data.isJsonData == 1 }">checked="checked"</c:if> />是
		</div>
		<div class="form_item">
			<span class="form_span">显示内容简介字数：</span>
			<input type="text" name="displayContentSize" value="${data.displayContentSize }" /> -1表示不包含内容
		</div>
		<div class="form_item">
			<span class="form_span">推荐位：</span>
			<select name="recommendId" id="recommendId">
				<option value="">无</option>
				<c:forEach items="${recommendList }" var="item">
					<option value="${item.id }" <c:if test="${item.id == data.recommendId }">selected="selected"</c:if>>${item.name }</option>
				</c:forEach>
			</select>
		</div>
		<div class="form_item">
			<span class="form_span">排序：</span>
			<select name="sortType">
				<option value="0">最新</option>
				<option value="1">最旧</option>
				<option value="2">点击数</option>
				<option value="3">排序</option>
			</select>
		</div>
		<div class="form_submit">
			<a id="submitBtn" class="base_btn"><span>提交</span></a>
		</div>
	</form>
</body>
</html>