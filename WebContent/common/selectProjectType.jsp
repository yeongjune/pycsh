<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 引入JSTL标签库 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
引用页面使用用例：
<c:import url="/projectType/projectTypeSelect.action">
	<c:param name="id1" value="selectId1"></c:param>
	<c:param name="name1" value="selectName1"></c:param>
	<c:param name="defaultValue1" value="defaultValue1"></c:param>
	<c:param name="id2" value="selectId2"></c:param>
	<c:param name="name2" value="selectName2"></c:param>
	<c:param name="defaultValue2" value="defaultValue2"></c:param>
	<c:param name="pId" value="0"></c:param>
	<c:param name="readonly" value="yes"></c:param>
	<c:param name="category" value="project"></c:param>
</c:import>
--%>
    <select name="${name1 }"  id="${id1 }" class="piece" >
    	<option value="">-选择-</option>
    	<c:forEach items="${list }" var="vo">
    		<c:if test="${vo.pId=='0' }">
		    	<option value="${vo.id}" <c:if test="${vo.id==defaultValue1 }">selected="selected"</c:if>>${vo.name}</option>
    		</c:if>
    	</c:forEach>
	</select>
	<c:if test="${defaultValue2!=null && defaultValue2!='' }">
	<select name="${name2 }"  id="${id2 }" style="margin-left: 10px;" class="piece">
		<c:forEach items="${list }" var="vo">
			<c:if test="${vo.pId==defaultValue1 }">
				<option value="${vo.id}" <c:if test="${vo.id==defaultValue2 }">selected="selected"</c:if>>${vo.name}</option>
			</c:if>
		</c:forEach>
	</select>
	</c:if>
	<script type="text/javascript">
		var html = "";
		var list = ${jsonList};
		var index = 0;
		$("#${id1 }").live("change",function(){
			var id = $(this).val();
			for ( var i = 0; i < list.length; i++) {
				if(id==list[i].pId){
					html += '<option value="'+list[i].id+'" id="'+list[i].id+'" >'+list[i].name+'</option>';
					index++;
				}
				
			}
			if(index != 0){
				$("#${id2 }").remove();	
				$("#${id1 }").after('<select name="${name2 }"  id="${id2 }" style="margin-left: 10px:width:250px;" class="piece">'+html+'</select>');	
			}else{
				$("#${id2 }").remove();	
			}
			index = 0;
			html = '';
		});
	</script>

