/**
 * excel导入
 * @param params 写法：&a=a&b=a
 * @param title
 * @param tip 导入说明 
 */
function excelImport(params, title, tip){
	if(title){
		
	}else{
		title = '数据导入';
	}
	art.dialog.open('/excel/entryImport.action?tip='+tip+params,
			{
				id: 'excelImportDialog',
				border:false,
				padding:0,
				lock: true,
				title: title,
			    background: 'white', // 背景色
			    opacity: 0.5,	// 透明度
			    height:'300px',
				width:'520px',
				drag: true,
				fixed: true,
				zIndex: 0,
				esc: true,
				top: '50%',
				left: '50%',
				resize: false
			});
}
/**
 * excel导出
 * @param workbook
 * @param fileName 导出的文件名称
 * @param params 写法：&a=a&b=a
 */
function excelExport(workbook,fileName,params){
	window.location.href='/excel/export.action?workbook='+workbook+'&sheet=Sheet1'+params+(fileName?'&fileName='+fileName:'');
}