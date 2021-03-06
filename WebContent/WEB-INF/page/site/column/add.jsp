<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>title</title>
</head>
<body>
	<fieldset class="fieldset_border" style="height: 398px;">
		<legend>添加栏目</legend>
		<form action="">
			<div class="view_rank">
				<span class="view_rank_span">所属栏目：</span><font id="pName"></font>
			</div>
			<div class="form_item">
				<span class="form_span">类型：</span>
				<select id="type" onchange="columnAdd.checkTypeForUrl(this)">
					<option value="单网页">单网页</option>
					<option value="新闻栏目" selected>新闻栏目</option>
					<option value="图片栏目">图片栏目</option>
					<option value="外部链接">外部链接</option>
				</select>
			</div>
			<div class="form_item" id="url_div" style="display: none;">
				<span class="form_span">url：</span>
				<input type="text" id="url" class="piece"/>
			</div>
			<div class="form_item">
				<span class="form_span">名称：</span>
				<input type="text" id="name" class="piece"/><font color="red" id="name_tip"></font>
			</div>
			<div class="form_item">
				<span class="form_span">英文名：</span>
				<input type="text" id="alias" class="piece"/>
			</div>
			<div class="form_item">
				<span class="form_span">栏目图片：</span>
				<input type="text" id="className" class="piece"/>
			</div>
			<div class="form_item">
				<span class="form_span">描述：</span>
				<textarea id="description" name="description"   maxlength="1000"  class="textarea_piece" rows="10" cols="68"  style="width:500px;height:50px;"></textarea>
			</div>
			<div class="form_item" id="pageSizeDiv" style="display: none;">
				<span class="form_span">每页显示新闻数：</span>
				<select id="pageSize" name="pageSize" style="width: 80px;">
					<c:forEach items="${pageSizesList}" var="item" varStatus="vs">
						<option value="${item.value}">${item.name }</option>
					</c:forEach>
				</select>
			</div>
			<div class="form_item">
				<span class="form_span">是否在导航显示：</span>
				<input type="radio" id="navigation_1" name="navigation" value="1" checked="checked"/> 是 
				<input type="radio" id="navigation_0" name="navigation" value="0"/> 否
			</div>
			<div class="form_submit">
				<a href="javascript:columnAdd.save()" class="base_btn" id="submitButton"><span>保存</span></a>
				<a href="javascript:cancel()" class="base_btn" id="submitButton"><span>取消</span></a>
			</div>
			<div class="clear"></div>
		</form>
	</fieldset>

	<script type="text/javascript">
		function ColumnAdd(){
			this.save = function(){
				var type = $('#type').val();
				var name = $('#name').val();
				var alias = $('#alias').val();
				var pageSize = $('#pageSize').val();
				var description = $('#description').val();
				var className = $("#className").val();
				var navigation = 0;
				$(':radio[name="navigation"]').each(function(){
					if($(this).attr('checked')=='checked'){
						navigation = $(this).val();
					}
				});
				if(type && type.trim()!='' && name && name.trim()!=''){
					var params = new Object();
					params.pid = static_columnId?static_columnId:0;
					params.type = type;
					if(type=='外部链接'){
						params.url = $('#url').val();
					}else{
						params.url = '';
					}
					params.name = name;
					params.alias = alias;
					params.navigation = navigation;
					params.pageSize = pageSize;
					params.description = description;
					params.className = className;
					lockWindow();
					$.post('/column/save.action', params, function(data){
						openLock();
						if(data!='fail'){
							reloadColumn();
						}
					});
				}else{
					if(name.trim()!=''){
						$('#name_tip').text('');
					}else{
						$('#name_tip').text('名称不能为空');
					}
				}
			};
			this.checkTypeForUrl = function(element){
				var element_val = $(element).val();
				if(element_val=='外部链接'){
					$('#url_div').show();
				}else{
					$('#url_div').hide();
				}
				if(element_val=="新闻栏目" || element_val=="图片栏目"){
					$("#pageSizeDiv").show();
				}else{
					$("#pageSizeDiv").hide();
				}
			};
		}
		var columnAdd = new ColumnAdd('${siteId}');
	</script>
</body>
</html>