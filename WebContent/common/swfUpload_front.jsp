<%@ page language="java"  pageEncoding="UTF-8"%>
<!-- swfupload -->
<link href="/plugin/swfupload/css/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/plugin/swfupload/swfupload.js"></script>
<script type="text/javascript" src="/plugin/swfupload/swfupload.queue.js"></script>
<script type="text/javascript" src="/plugin/swfupload/fileprogress.js"></script>
<script type="text/javascript" src="/plugin/swfupload/handlers.js"></script>

<%
String index=request.getParameter("index");
if(index==null){
	index="1";
}
%>
<div id="divStatus_<%=index %>"></div>
<div>
	<span id="spanButtonPlaceholder_<%=index %>"></span>
	<a href="#" class="base_btn" id="btnUpload_<%=index%>"><span>选择文件</span></a>
	<input style="display:none" id="btnCancel_<%=index %>"/>
    <span id="uploadFileTextProgress_${param.index}" style="display: none;"></span>
</div>


<div class="flash" id="fsUploadProgress_<%=index %>"></div>




<script type="text/javascript">
	var swfu = null;
	(function() {
		try {
			var types = '${param.types}';
			var size = '${param.size}';
			var upload_size = '${param.upload_size}';
			var limit = '${param.limit}';
			//新闻文件分类:1、图片类型的新闻图片文件； 2、新闻的缩略图文件； 3、新闻的附近文件，4、其他文件
			var type = '${param.type}';
			var index= '${param.index}';
			var tempId=$("#tempId").val();
			var articleId=$("#articleId").val();
			if($.trim(types) == "null"){
				
				types = "*.txt;*.rar;*.zip;*.bmp;*.gif;*.jpg;*.tif;*.doc;*.docx;*.dotm;*.dotm;*.xls;*.xlsx;*.xlsm;*.xltm;*.xlsb;*.xlam;*.ppt;*.pptx;*.pptm;" +
				        "*.ppsx;*.potx;*.ppam";
			}
			if($.trim(size) == "null"){
				size = "200 MB";
			}
			if($.trim(upload_size) == "null"){
				upload_size = 200;
			}
			if($.trim(limit) == "null"){
				limit = 0;
			}
			var settings = {
				flash_url : "/plugin/swfupload/swfupload.swf",
				upload_url : "/imageFront/save.action?tempId=",
				file_size_limit : size,
				file_types : types,
				file_types_description : "All Files",
				file_post_name : "attachmentTempPath",
				file_upload_limit : upload_size,
				file_queue_limit : limit,
				custom_settings : {
					progressTarget : "fsUploadProgress_"+index,
					cancelButtonId : "btnCancel_"+index,
                    textProgressTarget : 'uploadFileTextProgress_'+index
				},
				use_query_string : true,//要想在后台能得到post_params里的参数, 就要把这个属性设为true;
				debug : false,
				
				button_placeholder_id : "spanButtonPlaceholder_"+index,
				button_width : 82,
				button_height : 30,
				button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
				button_cursor: SWFUpload.CURSOR.HAND,
				button_image_url: '/',
				post_params:{
					tempId : tempId,
					type : type,
					articleId : articleId
				},
				use_query_string : true,
	
				file_queued_handler : fileQueued,
				file_queue_error_handler : fileQueueError,
				file_dialog_complete_handler : fileDialogComplete,
				upload_start_handler : uploadStart,
				upload_progress_handler : uploadProgress,
				upload_error_handler : uploadError,
				upload_success_handler : uploadSuccess,
				upload_complete_handler : uploadComplete,
				queue_complete_handler : queueComplete
			};
			
			swfu = new SWFUpload(settings);
			
		} catch (e) {
			alert(e);
		}
	})();
	
	function delAttchment(url, divId,imgId,type) {
		art.dialog({
			content: "你确定要删除么？",
			ico: "alert",
			ok : function() {
				$.post(url, function(data) {
					if (data.code == 'succeed') {
						if($('#' + divId).length>0){
							 $('#' + divId).remove();
						}
						
						if($("#imageIds").length>0&&imgId){ //有保存文件id的隐藏文本是处理掉删除的
							var imageIds=$("#imageIds").val();
						    if(imageIds==imgId){//更新文本文件记录
						    	$("#imageIds").val('');
						    }else{
						    	imageIds=imageIds.replace(','+imgId,'').replace(imgId+',','');
								$("#imageIds").val(imageIds);
						    }
						}
						
						//下面处理为特殊处理图片显示问题，一般文件上传不用处理
						if(type==2){//删除缩略图
								$("#smallPicUrl").val('');
								$("#div_item_smallPic").empty();
								$("#div_item_smallPic").append("<img alt='缩略图' class='smallPic' src='/skins/blue/images/default.jpg' > </img>");
						}else if(type==1){//删除图片列表的图片div_item_imgList
							$("#div_img_list_"+imgId).empty();
							$("#div_img_list_"+imgId).remove();
						}else if (type==3){
							$("#div_file_"+imgId).remove();
						}
						
					} else {
						alert('删除失败');
					} 
					return true;
				},'json');
			},
			cancelVal : '取消',
			cancel : true
			
		});
		
	}
	
	
	
</script>


