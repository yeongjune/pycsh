/* Demo Note:  This demo uses a FileProgress class that handles the UI for displaying the file name and percent complete.
The FileProgress class is not part of SWFUpload.
*/


/* **********************
   Event Handlers
   These are my custom event handlers to make my
   web application behave the way I went when SWFUpload
   completes different tasks.  These aren't part of the SWFUpload
   package.  They are part of my application.  Without these none
   of the actions SWFUpload makes will show up in my application.
   ********************** */
function fileQueued(file) {
	try {
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setStatus2("请稍候...");
		progress.toggleCancel(true, this);

	} catch (ex) {
		this.debug(ex);
	}

}

function fileQueueError(file, errorCode, message) {
	try {
		if (errorCode === SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED) {
			alert("每次只能" + (message === 0 ? "You have reached the upload limit." : "选择" + (message > 1 ? "up to " + message + " files." : "一个文件.")));
			return;
		}

		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setError();
		progress.toggleCancel(false);

		switch (errorCode) {
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			progress.setStatus("上传文件过大！");
			this.debug("Error Code: File too big, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			progress.setStatus("不能上传大小为0KB的文件!");
			this.debug("Error Code: Zero byte file, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
			progress.setStatus("不支持此类型的文件上传!");
			this.debug("Error Code: Invalid File Type, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		default:
			if (file !== null) {
				progress.setStatus("未知错误！");
			}
			this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		}
	} catch (ex) {
        this.debug(ex);
    }
}

function fileDialogComplete(numFilesSelected, numFilesQueued) {
	try {
		if (numFilesSelected > 0) {
			document.getElementById(this.customSettings.cancelButtonId).disabled = false;
		}
		
		/* I want auto start the upload and I can do that here */
		this.startUpload();
	} catch (ex)  {
        this.debug(ex);
	}
}

/**
 * 开始上传的时候调用的方法
 * @param file
 * @returns {Boolean}
 */
function uploadStart(file) {
	try {
		/* I don't want to do any file validation or anything,  I'll just update the UI and
		return true to indicate that the upload should start.
		It's important to update the UI here because in Linux no uploadProgress events are called. The best
		we can do is say we are uploading.
		 */
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setStatus2("正在上传");
		progress.toggleCancel(true, this);
	}
	catch (ex) {}
	
	return true;
}

/**
 * 文件的进度条
 * @param file
 * @param bytesLoaded
 * @param bytesTotal
 */
function uploadProgress(file, bytesLoaded, bytesTotal) {
	try {
		var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);

		var progress = new FileProgress(file, this.customSettings.progressTarget);
        if(this.customSettings.textProgressTarget && this.customSettings.textProgressTarget.trim() != ''){
            var textProgress = $('#' + this.customSettings.textProgressTarget.trim()).html(file.name + ' -- ' + percent + '%').show();
            if(percent == 100)
                textProgress.hide();
        }
		progress.setProgress(percent);
		swfupload.cancelUpload(file.id, false);
		progress.setStatus2("正在上传");
	} catch (ex) {
		this.debug(ex);
	}
}


/**
 *	上传成功的回调函数,file是指文件，可以获得文件名，
 *  serverData是是服务器反回的保存文件数据{code:,msg:,data:{id:,articleId:,path:,tempId:,size:,fileName:,createTime:}}，文件信息保存在image表
 *  删除附件，通过附件id就可以删除了，请求方法是/image/deleteById.action
 *  下载附件通过id也就可以下载文件了,请求方法是/image/download.action?path=
 */
function uploadSuccess(file, serverData) {
	try {
		var result=eval("("+serverData+")");
		var data=result.data;//serverData格式:{id:,articleId:,path:,tempId:,size:,fileName:,createTime:}
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setComplete();
		var url = '/image/deleteById.action?id=' + data.id;
		$('#' + file.id + " .progressCancel").bind("click",function(){
			delAttchment(url, file.id,data.id,data.type);
		});
//		progress.setStatus(str);
		progress.toggleCancel(true);
		// 添加name 为attachmentIds 的input隐藏域
		var inputObj = '<input type="hidden" name="attachmentIds" value="' + data.id + '" />';
		
		$("#" + file.id).append(inputObj);
		$("#" + file.id + " .progressBarStatus").remove();
		
		//以下为处理返回的数据，一般文件不需要处理
		var type=data.type;//新闻文件分类：1、图片类型的新闻图片文件； 2、新闻的缩略图文件； 3、新闻的附近文件，4、其他文件
		var imageId=data.id;
		var filePath=data.path;
		var fileName=data.fileName;
		if($("#imageIds").length>0){ //更新隐藏文本域保存上传过的ID
			//保存图片记录Id到隐藏文本域
			var imageIds=$("#imageIds").val();
			if(imageIds){
				$("#imageIds").val(imageIds+","+imageId);
			}else{
				$("#imageIds").val(imageId);
			}
		}
		//该if为处理新闻缩略图type=2和图片列表type=1 的显示，如果上传的是一般文件
		//不会进行该处理;上传的是图片的话显示到列表 id为 div_item_imgList的标签上
		if(type==1){
			appendImage(url, file.id,imageId,"#div_item_imgList",filePath,fileName,"200px","200px",type);
			//显示图片到界面
		}else if(type==2){
			//添加的是缩略图则先清空,并且设置隐藏文本域
			if ($("#smallPicUrl").length>0) {
				$("#smallPicUrl").val(filePath);
				$("#smallPicUrl").attr('data-original-path', data.originalPath);
				$("#div_item_smallPic").empty();
				appendSmallPic(url, file.id,imageId,"#div_item_smallPic",filePath,fileName,type);
			}
		}
		
		autoHeight();
	} catch (ex) {
		this.debug(ex);
	}
}
//create div_img add by lifq
function appendSmallPic(url, divId,imageId,parentId,filePath,fileName,type){
	var div=$('<div></div>');

	var img=$('<img></img>');
	img.attr("src",filePath);
	img.attr("alt","缩略图");
	img.addClass("smallPic");
	
	
	var alink=$('<a></a>');
	alink.attr("title",fileName);
	alink.text("删除");
	alink.click(function(){
		delAttchment(url, divId,imageId,type);
	});
	
	div.append(img);
	div.append(alink);
	div.appendTo(parentId);
}
//create div_img add by lifq
function appendImage(url, divId,imageId,parentId,filePath,fileName,width,height,type){
	var div=$('<div></div>');
	div.attr("id",'div_img_list_'+imageId);
	div.attr('class','divItemImg');
	
	var img=$('<img></img>');
	img.attr("src",filePath);
	img.attr("alt",fileName);
	img.attr("width",width);
	img.attr("height",height);
	
	var alink=$('<a></a>');
	alink.attr("title",fileName);
	alink.text("删除");
	alink.click(function(){
		delAttchment(url, divId,imageId,type);
	});
	
	div.append(img);
	div.append(alink);
	div.append(' <a href="javascript:;" onclick="editImg('+imageId+')">编辑</a>');
	div.appendTo(parentId);
}


function uploadError(file, errorCode, message) {
	try {
		var progress = new FileProgress(file, this.customSettings.progressTarget);
		progress.setError();
		progress.toggleCancel(false);

		switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
			progress.setStatus("上传错误: " + message);
			this.debug("Error Code: HTTP Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
			progress.setStatus("上传失败.");
			this.debug("Error Code: Upload Failed, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.IO_ERROR:
			progress.setStatus("服务器 (IO) 错误");
			this.debug("Error Code: IO Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
			progress.setStatus("安全错误");
			this.debug("Error Code: Security Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
			progress.setStatus("上传超出限制.");
			this.debug("Error Code: Upload Limit Exceeded, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED:
			progress.setStatus("验证失败.  跳过上传.");
			this.debug("Error Code: File Validation Failed, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
			// If there aren't any files left (they were all cancelled) disable the cancel button
			if (this.getStats().files_queued === 0) {
				document.getElementById(this.customSettings.cancelButtonId).disabled = true;
			}
			progress.setStatus("取消");
			progress.setCancelled();
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			progress.setStatus("Stopped");
			break;
		default:
			progress.setStatus("Unhandled Error: " + errorCode);
			this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		}
	} catch (ex) {
        this.debug(ex);
    }
}

function uploadComplete(file) {
	if (this.getStats().files_queued === 0) {
		document.getElementById(this.customSettings.cancelButtonId).disabled = true;

	}
}

// 上传完毕的反馈,numFilesUploaded上传成功的文件总数
function queueComplete(numFilesUploaded) {
}

