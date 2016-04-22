package com.base.util;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jxl.format.Alignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;

/**
 * excel导出
 * 
 */
public class ExcelExportUtil<T> {
	

	public String getValue(Object value) {
		String textValue = "";
		if (value == null)
			return textValue;

		if (value instanceof Boolean) {
			boolean bValue = (Boolean) value;
			textValue = "是";
			if (!bValue) {
				textValue = "否";
			}
		} else if (value instanceof Date) {
			Date date = (Date) value;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			textValue = sdf.format(date);
		} else
			textValue = value.toString();

		return textValue;
	}
	
	/**
	 * 传入单元格数据和工作表返回单元格List
	 * @param y 单元所在行数
	 * @param strList 该行数据
	 * @param title 该行行头(第一个单元格内容,null则从第一个单元格开始写入内容)
	 * @param con 一条数据所占单元格数(合并单元格)
	 * @param  wsheet 工作表对象
	 */
	public static List<Label> getLabelList(Integer y ,List<Object> strList,String title,Integer con,WritableSheet wsheet)throws Exception{
		List<Label> labelList= new ArrayList<Label>();
		Label content =null;
		
		WritableCellFormat cellFormat=new WritableCellFormat();
	       cellFormat.setAlignment(Alignment.RIGHT);
	       

		int i = 0;
		if(title !=null){
			content = new Label(i, y, title,cellFormat); 
			
			wsheet.addCell(content);
			labelList.add(content);
			i++;
		}
		 cellFormat=new WritableCellFormat();
		 cellFormat.setAlignment(Alignment.CENTRE);
		 cellFormat.setWrap(true);
		if(strList!=null){
			for(Object str : strList){
				if(str!=null){
					str=str.toString();
				}else{
					str="";
				}
				content = new Label(i, y, str.toString(),cellFormat);  
				wsheet.addCell(content);
				wsheet.mergeCells(i,y,i+con-1,y);
				labelList.add(content);
				i+=con;
			}
		}
		
		return labelList;
	}
}