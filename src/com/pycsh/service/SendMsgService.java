package com.pycsh.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.base.vo.PageList;

/**
 * 短信
 * @author 
 *
 */
public interface SendMsgService {

	/**发送信息
	 * @param mobilesStr 接收信息的电话号码(多个可以用逗号隔开)
	 * @param msgContent 信息内容
	 * @return true发送成功，false发送失败
	 */
	boolean sendMsg(String mobilesStr, String msgContent);
	
	PageList findByPage(Integer currentPage,Integer pageSize,Integer type);
	
	void saveMsgRecord(String mobilesStr, String msgContent,Integer type);
	
	Integer getMsgCount();
	
	Integer getLastCount();
}
