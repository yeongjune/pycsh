<%@ page language="java"  pageEncoding="UTF-8"%>
<!-- swfupload -->
<link href="/plugin/swfupload/css/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/plugin/swfupload/swfupload.js"></script>
<script type="text/javascript" src="/plugin/swfupload/swfupload.queue.js"></script>
<script type="text/javascript" src="/plugin/swfupload/fileprogress.js"></script>
<script type="text/javascript" src="/plugin/swfupload/handlers.js"></script>

<style type="text/css">
    .swfupload {
        position: absolute;
        z-index: 1;
    }
</style>
<%
String index=request.getParameter("index");
if(index==null){
	index="1";
}
%>
<div style="float: left;">
<div id="divStatus_<%=index %>" ></div>
<div>
	<span id="spanButtonPlaceholder_<%=index %>"></span>
	<a href="#" class="base_btn" id="btnUpload_<%=index%>"><span style="width:100px;height:34px;line-height:34px;color:#fff;background:#409c5a;text-align:center;display:block;">上传图片</span></a>
	<input style="display:none" id="btnCancel_<%=index %>"/>
</div>
<div class="flash" id="fsUploadProgress_<%=index %>" style="display: none;"></div>
</div>



<script type="text/javascript">
	var imgIndex=0;
	//上传之前验证
	function myUploadStart(){
		return true;
	}
	//上传成功后处理
	//serverData格式:{code:,msg:,url:,error:}
	function uploadTemplateFileSuccess(file,serverData){
		
		try {
			var result=eval("("+serverData+")");
			var code=result.code;
			if(code=="succeed"){
				
				for(var i = imgIndex;i>=0;i--){
					if(imgIndex-3>i){
						$("#imgDiv"+i).remove();
					}
				}
				
				var html="";
				html+='<div id="imgDiv'+imgIndex+'" style="float:left;margin-right: 5px;margin-bottom: 5px;">';
				html+='<img  src="'+result.url+'" width="200" />';
				html+='<input name="imgUrls" value="'+result.url+'" type="hidden"/>';
				html+='</div>';
				$("#imgUrlDiv").append(html);
				imgIndex++;
			}else if(code=="false"){
				alert(result.msg);
			}else{
				art.dialog.tips('上传失败');
			}
		} catch (ex) {
			this.debug(ex);
		}
	}
	
	var swfu = null;
	(function() {
		try {
			var types = '${param.types}';
			var size = '${param.size}';
			var upload_size = '${param.upload_size}';
			var limit = '${param.limit}';
			var index= '${param.index}';
			var type = '${param.type}';
			if($.trim(types) == "null"){
				types = "*.gif;*.png;*.jpeg;*.jpg;*.bmp";
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
				upload_url : "/cshImage/save.action?type=6",
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
				debug : false,
				button_placeholder_id : "spanButtonPlaceholder_"+index,
				button_width : 61,
				button_height : 22,
				button_value :'上传文件',
				button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
				button_cursor: SWFUpload.CURSOR.HAND,
				button_image_url: '/',
				//post_params:{directory:static_select},
				use_query_string : true,//要想在后台能得到post_params里的参数, 就要把这个属性设为true;
	
				file_queued_handler : fileQueued,
				file_queue_error_handler : fileQueueError,
				file_dialog_complete_handler : fileDialogComplete,
				upload_progress_handler : uploadProgress,
				upload_error_handler : uploadError,
				upload_success_handler : uploadTemplateFileSuccess,
				upload_complete_handler : uploadComplete,
				queue_complete_handler : queueComplete,
				upload_start_handler : uploadStart
				//upload_start_handler : myUploadStart
			};
			
			swfu = new SWFUpload(settings);
			
		} catch (e) {
			alert(e);
		}
	})();
</script>


