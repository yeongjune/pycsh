 
<link rel="stylesheet" href="${ctx}/plugin/kindeditor-4.1.10/themes/default/default.css" />
<script charset="utf-8" src="${ctx}/plugin/kindeditor-4.1.10/kindeditor-min.js"></script>
<script charset="utf-8" src="${ctx}/plugin/kindeditor-4.1.10/lang/zh_CN.js"></script>
 
<script> 
		var editor;
        KindEditor.ready(function(K) { 
        editor = K.create('#myEditor', {
        	resizeType : 2,
			cssPath : '${ctx}/plugin/kindeditor-4.1.10/plugins/code/prettify.css',
        	//uploadJson : '${ctx}/plugin/kindeditor-4.1.10/jsp/upload_json.jsp',
        	//fileManagerJson : '${ctx}/plugin/kindeditor-4.1.10/jsp/file_manager_json.jsp',
        	uploadJson : '${ctx}/image/save.action',
			fileManagerJson : '${ctx}/image/fileManager.action?tempId='+$("#tempId").val(),
			allowFileManager : true,
			autoHeightMode : true,
			newlineTag:'br',
			filterMode:false,
			items : ['source','undo', 'redo', '|', 'preview', 'print', 'template', 'code', 'cut', 'copy', 'paste',
			         'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
			         'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
			         'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',
			         'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
			         'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image','multiimage',
			         'flash', 'media', 'insertfile', 'table', 'hr', 'emoticons', 'baidumap', 'pagebreak',
			         'anchor', 'link', 'unlink'
					],
			filePostName :'attachmentTempPath',
			extraFileUploadParams :{
				kindeditor :1,
				type : 4,
				tempId : $("#tempId").val(),
				articleId : $("#articleId").val()
			},
			afterChange:function(){
				var valLength= this.count('text');
				var maxValLength= K("#myEditor").attr("maxlength");
				if(valLength>maxValLength){
					var strVal=this.text();
					this.text("");
					strVal = strVal.substring(0,maxValLength);
					this.insertHtml(strVal);
				}
			},
			afterUpload : function (url){
				//alert(url);
			}
		});
       });
</script>