<%@ page language="java"  pageEncoding="UTF-8"%>
<!-- 说明：这个swfUpload2使用在界面已经使用了swfUpload。jsp才使用这个，即第二个上传时使用 -->
<%

String index=request.getParameter("index");
if(index==null){
	index="2";
}
%>
<div id="divStatus_<%=index %>"></div>
<div>
	<span id="spanButtonPlaceholder_<%=index %>"></span>
	<a href="#" class="base_btn" id="btnUpload_<%=index%>"><span>选择文件</span></a>
	<input style="display:none" id="btnCancel_<%=index %>"/>
</div>
<div class="flash" id="fsUploadProgress_<%=index %>"></div>


<script type="text/javascript">
	var swfu3 = null;
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
				upload_url : "/image/save.action?type="+type,
				file_size_limit : size,
				file_types : types,
				file_types_description : "All Files",
				file_post_name : "attachmentTempPath",
				file_upload_limit : upload_size,
				file_queue_limit : limit,
				custom_settings : {
					progressTarget : "fsUploadProgress_"+index,
					cancelButtonId : "btnCancel_"+index
				},
				use_query_string : true,//要想在后台能得到post_params里的参数, 就要把这个属性设为true;
				debug : false,
				
				button_placeholder_id : "spanButtonPlaceholder_"+index,
				button_width : 61,
				button_height : 22,
				button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
				button_cursor: SWFUpload.CURSOR.HAND,
				button_image_url: '/',
				post_params:{
					tempId : tempId,
					type : type ,
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
			
			swfu3 = new SWFUpload(settings);
			
		} catch (e) {
			alert(e);
		}
	})();
	
</script>


