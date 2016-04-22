<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${title }</title>
<style type="text/css">
.line_bg{
background-color: #eee;
}
</style>
<script type="text/javascript">
var static_select="";
var setting = {
	data: {
		key:{
			name:"name",
			title:"name",
			url:"javascript:void();"
		},
		simpleData: {
			enable: true,
			idKey:"id",
			pIdKey:"pid",
			rootPid:"/"
		}
	},
	callback: {
		onClick: function(event, treeId, treeNode){
				var id = treeNode.id;
				var type = treeNode.type;
				var pid = treeNode.pid;
				if(static_select!=id && type=="0"){
					fileManager.loadFileList(id); 
					static_select=id;
				}else if( static_select!=pid && type=="1"){
					fileManager.loadFileList(pid); 
					static_select=pid;
				}
				if(type==1){
					$("#tableBody").find("tr").removeClass("line_bg");
					$("input[name='chk_file_id'][value='"+id+"']").parent().parent().addClass("line_bg");
				}
		}
	}
};
var fileManager;
$(function(){
	fileManager=new FileManager();
	fileManager.loadDirectoryList();
	$("#chk_ids").click(function(){
		if($(this).attr("checked")){
			$("input[name='chk_file_id']").attr('checked',true);
		}else{
			$("input[name='chk_file_id']").attr('checked',false);
		}
	});
});
function  FileManager(){
	this.loadDirectoryList=function(){
		$.post('/fileManager/loadDirectory.action',{openDirectory:static_select},function(data){
			var mapList =data;//$.parseJSON
			$.fn.zTree.init($("#DirectoryTree"),setting,mapList);
			if(static_select){
				var zTree = $.fn.zTree.getZTreeObj("DirectoryTree");
				zTree.selectNode(zTree.getNodeByParam("id", static_select));
			}
				
		},'json');
	};
	this.loadFileList =function(directory){
		$("#chk_ids").attr("checked",false);
		$.post('/fileManager/loadFileList.action',{directory:directory},function(data){
			var list=data;
			if(list&&list.length>0){
				var tempStr="";
				for(var key in list){
					var item=list[key];
					var canEdit=(item.name.endWith('.js')||item.name.endWith('.css'))?true:false;
					var isImg=(item.name.endWith('.jpg')||item.name.endWith('.png')||item.name.endWith('.bmp')||item.name.endWith('.gif')||item.name.endWith('.jpeg')||item.name.endWith('.png'))?true:false;
					tempStr +='<tr id="tr_index_'+key+'">'+
									'<td>'+
										'<input type="checkbox" name="chk_file_id" value="'+item.id+'" />'+
										'<input type="hidden" name="chk_file_type" value="'+item.type+'" />'+
										'<input type="hidden" name="line_index" value="'+key+'" /></td>'+ 
									'<td style="text-align:left;padding-left:10px">'+item.name+
									'</td>'+
									'<td style="width:100px">'+(item.type==1?'文件':'文件夹')+'</td>'+
									'<td>'+
										(item.type==1&&canEdit?"<a href='javascript:fileManager.editFile(\""+item.id+"\");'>编辑</a> ":'')+
										(item.type==1&&isImg?"<a href='javascript:showBigPic(\""+item.id+"\");'>预览</a> ":'')+
										"<a href='javascript:fileManager.deleteFile(\""+item.id+"\",\""+item.type+"\",\""+key+"\",\""+item.name+"\");'>删除</a> "+
										"<a href='javascript:fileManager.download(\""+item.id+"\");'>下载</a> "+
									'</td>'+
								'</tr>';
				}
				$("#tableBody").empty().append(tempStr);
			}else{
				$("#tableBody").empty();
			}
		},'json');
	};
	//编辑文件
	this.editFile=function(id){
		art.dialog.open('/fileManager/toEdit.action?id='+id,{
			width : '100%',
			height: '100%',
			title : '编辑文件'
		});
	};
	//删除文件
	this.deleteFile=function(id,type,key,name){
		art.dialog.confirm('您确定要删除'+(type==1?'文件':'文件夹')+'['+name+"]吗？",function(){
			$.post('/fileManager/delete.action',{filePath:id,type:type},function(data){
				if(data=="succeed"){
					$("#tr_index_"+key).remove();
					fileManager.loadDirectoryList();
				}else if(data=="false"){
					art.dialog.tips("文件夹非空，不能删除");
				}else if(data=="fail"){
					art.dialog.tips("删除失败");
				}
			});
		});
	};
	//批量删除文件
	this.deleMutil=function(){
		var list=[];
		$("input[name='chk_file_id']:checked").each(function(){
			list.push({"id":$(this).val(),"name":$(this).parent().next().text(),"type":$(this).next().val(),"key":$(this).next().next().val()});
		});
		if(list.length==0){
			art.dialog.alert('您尚未选择任何要删除的项！');
			return;
		}
		art.dialog.confirm('您确认要删除选择了的文件或文件吗？',function(){
			var result="";
			for(var i=0;i<list.length;i++){
				var file=list[i];
				$.post('/fileManager/delete.action',{filePath:file.id,type:file.type},function(data){
				    if(data=="succeed"){
				    	//$("#tr_index_"+file.key).remove();
				    	 
					}else if(data=="false"){
						result += file.name+"文件夹非空，不能删除";
					}else if(data=="fail"){
						result += file.name+"删除失败";
					}
				    
				    if(i==list.length){
				    	fileManager.loadDirectoryList();
				    	fileManager.loadFileList(static_select);
				    	if(result){
				    		art.dialog.tips(result);
				    	}
				    } 
				});
			}
		});
	};
	//新增目录
	this.addDirectory=function(){
		if(!static_select){
			art.dialog.tips("请在左边选择文件夹");
			return;
		}
		art.dialog.open('/fileManager/toAdd.action?id='+static_select,{
			width : '450px',
			height: '150px',
			title : '新增文件夹'
		});
	};
	//下载
	this.download=function(id){
		window.location.href='/image/download.action?path='+id;
	};
	//导出文件
	this.exportFile=function(){
		var directory=static_select;
		var ids=[];
		$("input[type='checkbox'][name='chk_file_id']:checked").each(function(){
			ids.push($(this).val());
		});
		if(!directory&&ids.length==0){
			art.dialog.confirm('您没有选择任何文件夹或文件，是否要导出全部',function(){
				window.location.href='/fileManager/download.action';
			});
		}else{
			window.location.href='/fileManager/download.action?directory='+directory+'&ids='+ids.join(',');
		}
	};
}
//查看图片
function showBigPic(url,width,height){
	art.dialog({
	    padding: 0,
	    title: '照片',
	    content: '<img src="'+url+'" width="'+(width?width:'100%')+'" height="'+(height?height:'100%')+'" />',
	    lock: true,
	    resize:true
	});
}
//清空object对象
function removeObject(){
	 $('div').empty(); 
}
</script>
</head>
<body  onunload="removeObject()">
<fieldset class="fieldset_border">
	<legend class="legend_title">模版文件管理</legend>
		<div class="zTreeDemoBackground left" style="padding-bottom:30px;">
			<ul id="DirectoryTree" class="ztree"></ul>
		</div>
		<div style="margin-left: 252px;">
			<div class="form_search_item" >
				<div class="left">
					<input type="hidden"/>
					<c:import url="/common/swfUpload3.jsp">
						<c:param name="types">*.jpg;*.gif;*.png;*.bmp;*.jpeg;*.jsp;*.css;*.js;*.swf;*.mp3</c:param>
						<c:param name="index">1</c:param>
					</c:import>
					<a href="javascript:fileManager.addDirectory()" class="base_btn"><span>新增文件夹</span></a>
					<a href="javascript:fileManager.deleMutil()" class="base_btn"><span>批量删除</span></a>
					<a href="javascript:fileManager.exportFile()" class="base_btn" title="不选择文件时则导出当前文件夹下所有文件包括子文件夹为zip包"><span>导出文件/文件夹</span></a>
					<span>操作说明：在左边树单击选择文件夹</span>
				</div>
			</div>
			<table  class="table_border" style="width: 99.7%;">
				<tr class="head">
					<td width="40px"><input type="checkbox" id="chk_ids"/></td>
					<td >文件名</td>
					<td >类型</td>
					<td width="110px">操作 </td>
				</tr>
				<tbody id="tableBody"></tbody>
			</table>
		</div>
		<div class="clear"></div>
</fieldset>
</body>
</html>